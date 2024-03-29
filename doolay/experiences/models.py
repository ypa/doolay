from __future__ import unicode_literals

from datetime import timedelta
from django.db import models
from django.utils import timezone

from wagtail.core.models import Page
from wagtail.search import index
from wagtail.images.edit_handlers import ImageChooserPanel
from wagtail.core.fields import StreamField
from wagtail.admin.edit_handlers import (FieldPanel, StreamFieldPanel,
                                         PageChooserPanel)
from doolay.blocks import GlobalStreamBlock


class ExperiencePage(Page):
    """
    This is a page for all the details about a specific experience
    """

    search_fields = Page.search_fields
    # Defining that search should only catch the `page` default, which will
    # be title.

    image = models.ForeignKey(
        'wagtailimages.Image',
        null=True,
        blank=True,
        on_delete=models.SET_NULL,
        related_name='+',
        help_text='Experiences image')

    host = models.ForeignKey(
        'hosts.HostPage',
        null=True,
        on_delete=models.SET_NULL,
        related_name='providing_experiences')

    place = models.ForeignKey(
        'places.PlacePage',
        on_delete=models.PROTECT,
        related_name='experiences')

    duration = models.DurationField(default=timedelta)

    # Defining fields that should be within this page model
    body = StreamField(
        GlobalStreamBlock(),
        verbose_name='A description of this experience',
        blank=True)

    # Defining the fields that should be shown to the editor within the content
    # editor (it may be that you wouldn't want to show a field defined above in
    # the content editor)
    content_panels = Page.content_panels + [
        ImageChooserPanel('image'),
        PageChooserPanel('host'),
        PageChooserPanel('place'),
        FieldPanel('duration'),
        StreamFieldPanel('body'),
    ]

    parent_page_types = ['ExperienceIndexPage']

    # Setting a parent means that it can only be added under that parent

    def parent_url(self):
        parent_set = Page.objects.parent_of(self).all()
        # Get all objects for the parent page within a queryset using
        # Treebeard's `parent_of`

        parent_url_string = [n.url for n in parent_set]
        # Get the URL out of the queryset
        # If you try to access it directly you'll hit the error:
        # 'PageQuerySet' object has no attribute 'url'

        for object in parent_url_string:
            return object
        # The PageQuerySet behaves exactly as you'd expect it to
        # meaning that you could loop over the `parent_set` in the template
        # by doing:
        #   {% for object in parent_set %}
        #       {{ object.url }}
        #   {% endfor %}

    api_fields = ['image', 'body']

    def get_available_slot_dates(self, within_days=65):
        """
        Return a dict of available slot date -> slot_id for the experience.
        """
        from_date = timezone.now().date()
        to_date = from_date + timedelta(days=within_days)

        return {start_dt.date(): slot.id
                for (start_dt, end_dt, slot) in
                self.booking.all_occurrences(from_date, to_date)}


class ExperienceIndexPage(Page):
    """
    This is a page to list all the experiences on the site
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
        help_text='Experiences listing image')

    introduction = models.TextField(
        help_text='Text to describe the index page', blank=True)

    content_panels = Page.content_panels + [
        ImageChooserPanel('image'),
        FieldPanel('introduction')
    ]

    parent_page_types = ['home.HomePage']

    # Defining what content type can sit under the parent
    subpage_types = ['ExperiencePage']
