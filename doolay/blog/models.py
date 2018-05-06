from django.db import models
from wagtail.core.models import Page
from wagtail.images.edit_handlers import ImageChooserPanel
from wagtail.core.fields import StreamField
from wagtail.search import index
from wagtail.admin.edit_handlers import (
    FieldPanel, StreamFieldPanel
)
from doolay.blocks import GlobalStreamBlock

class BlogPage(Page):

    image = models.ForeignKey(
        'wagtailimages.Image',
        null=True,
        blank=True,
        on_delete=models.SET_NULL,
        related_name='+',
        help_text='Blog page image'
    )

    date = models.DateField("Post date")
    intro = models.CharField(max_length=250)

    body = StreamField(
        GlobalStreamBlock(),
        verbose_name='Blog page body',
        blank=True
    )

    search_fields = Page.search_fields + [
        index.SearchField('intro'),
        index.SearchField('body'),
    ]

    content_panels = Page.content_panels + [
        ImageChooserPanel('image'),
        FieldPanel('date'),
        FieldPanel('intro'),
        StreamFieldPanel('body'),
    ]

    api_fields = ['image', 'date', 'intro', 'body']

    parent_page_types = [
        'BlogIndexPage'
    ]

    # Defining what content type can sit under the parent
    # The empty array will mean no children can be added
    subpage_types = []

    def first_paragraph(self):
        paragraphs = [p['value'] for p in self.body.stream_data
                      if p['type'] == 'paragraph']
        if len(paragraphs) > 0:
            return paragraphs[0]
        else:
            return '<p></p>'



class BlogIndexPage(Page):
    """
    This is a page to list all the blog pages on the site
    """
    parent_page_types = [
        'home.HomePage'
    ]

    subpage_types = [
        'BlogPage'
    ]

    def get_context(self, request):
        context = super(BlogIndexPage, self).get_context(request)
        live_blogs = BlogPage.objects.descendant_of(self).live()
        context['blogs'] = live_blogs.order_by('date')
        return context
