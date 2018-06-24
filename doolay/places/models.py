from __future__ import unicode_literals

from django.db import models

from wagtail.core.models import Page, Orderable
from wagtail.search import index
from wagtail.images.edit_handlers import ImageChooserPanel
from wagtail.core.fields import StreamField
from wagtail.admin.edit_handlers import (FieldPanel, InlinePanel,
                                         StreamFieldPanel)
from wagtail.snippets.models import register_snippet
from wagtail.snippets.edit_handlers import SnippetChooserPanel
from doolay.blocks import GlobalStreamBlock


class PlacePage(Page):
    """
    The PlacePage allows details to be added about different places
    """
    image = models.ForeignKey(
        'wagtailimages.Image',
        null=True,
        blank=True,
        on_delete=models.SET_NULL,
        related_name='+',
        help_text='Place image')

    body = StreamField(
        GlobalStreamBlock(), verbose_name="Place's details", blank=True)
    # We've defined the StreamBlock() within blocks.py that we've imported on
    # line 12. Defining it in a different file gives us consistency across the
    # site, though StreamFields _can_ be created on a per model basis if you
    # have a use case for it

    content_panels = Page.content_panels + [
        ImageChooserPanel('image'),
        StreamFieldPanel('body'),
    ]

    parent_page_types = ['PlaceIndexPage']

    # Defining what content type can sit under the parent
    # The empty array means that no children can be placed under the
    # PlacePage page model
    subpage_types = []

    api_fields = ['image', 'body']


class PlaceIndexPage(Page):
    """
    This is a page to list all the places on the site
    """
    search_fields = Page.search_fields + [
        index.SearchField('introduction'),
    ]

    image = models.ForeignKey(
        'wagtailimages.Image',
        null=True,
        blank=True,
        on_delete=models.SET_NULL,
        related_name='+',
        help_text='Place listing image')

    introduction = models.TextField(
        help_text='Text to describe the index page', blank=True)

    content_panels = Page.content_panels + [
        ImageChooserPanel('image'),
        FieldPanel('introduction')
    ]

    parent_page_types = ['home.HomePage']

    # Defining what content type can sit under the parent
    subpage_types = ['PlacePage']

    api_fields = ['introduction']

    # Strictly speaking this isn't necessary since it's just doing the default
    # behaviour of Wagtail e.g. gets all host pages that are my descendent, show
    # them if they're published ('live') and order by their first published date
    # Docs http://docs.wagtail.io/en/v1.6.3/topics/pages.html#template-context
    def get_context(self, request):
        context = super(PlaceIndexPage, self).get_context(request)
        context['places'] = PlacePage.objects.descendant_of(
            self).live().order_by('-first_published_at')
        return context
