from django.db import models
from wagtail.wagtailcore.models import Page
from wagtail.wagtailimages.edit_handlers import ImageChooserPanel
from wagtail.wagtailcore.fields import StreamField
from wagtail.wagtailsearch import index
from wagtail.wagtailadmin.edit_handlers import (
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
