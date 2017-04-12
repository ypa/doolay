from __future__ import unicode_literals

from django.db import models

from modelcluster.models import ClusterableModel
from modelcluster.fields import ParentalKey

from wagtail.wagtailcore.models import Page, Orderable
from wagtail.wagtailsearch import index
from wagtail.wagtailimages.edit_handlers import ImageChooserPanel
from wagtail.wagtailcore.fields import StreamField
from wagtail.wagtailadmin.edit_handlers import (
        FieldPanel,
        InlinePanel,
        StreamFieldPanel,
        PageChooserPanel
        )
from wagtail.wagtailsnippets.models import register_snippet
from wagtail.wagtailsnippets.edit_handlers import SnippetChooserPanel
from doolay.blocks import GlobalStreamBlock


@register_snippet
class HostInterest(ClusterableModel):
    """
    This snippet allows an editor to define what possible employment interests
    a staff member may have. Or whether they're a wizard...
    """

    search_fields = Page.search_fields + [
        index.SearchField('title'),
    ]

    title = models.CharField("Interest", max_length=254)

    panels = [
        FieldPanel('title'),
    ]

    def __str__(self):
        # We have to return a string to populate the snippets screen. The
        # Snippets admin screen will only support a string
        return self.title

    class Meta:
        ordering = ['title']
        verbose_name = "Interest"
        verbose_name_plural = "Interests"


class HostInterestRelationship(models.Model):
    """
    This defines the relationship between the `HostEmploymentInterest` snippet
    above and the HostPage below. It does so by defining a ForeignKey
    relationship between the two, which can be accessed by the respective
    'related_name'. The magic key is the 'related_name'
    Docs: http://www.tivix.com/blog/working-wagtail-i-want-my-m2ms/
    """
    host_page = ParentalKey(
        'HostPage', related_name='host_interest_relationship'
    )
    host_interests = models.ForeignKey(
        'HostInterest',
        related_name="interest_host_relationship"
    )
    panels = [
        SnippetChooserPanel('host_interests')
    ]


class HostLocationRelationship(models.Model):
    """
    This defines the relationship between the `LocationPage`, within the
    `locations` app, and the HostPage below. Again the magic key is
    the related_name. On the LocationPage model in the locations app you can
    see the reverse relationship of the related_name being used to populate
    hosts on the LocationPage
    """
    host_page = ParentalKey(
        'HostPage', related_name='host_location_relationship'
    )
    location = models.ForeignKey(
        'locations.LocationPage',
        related_name="location_host_relationship"
    )
    panels = [
        PageChooserPanel('location')
    ]


class HostExperienceRelationship(Orderable, models.Model):
    """
    This defines the relationship between the `ExperiencePage` within the `experiences`
    app and the HostPage below allowing us to add experiences to a host. As above
    the magic key is the related_name
    """
    host_page = ParentalKey(
        'HostPage', related_name='host_experience_relationship'
    )
    experiences = models.ForeignKey(
        'experiences.ExperiencePage', related_name='experience_host_relationship'
    )
    panels = [
        PageChooserPanel('experiences')
    ]


class HostPage(Page):
    image = models.ForeignKey(
        'wagtailimages.Image',
        null=True,
        blank=True,
        on_delete=models.SET_NULL,
        related_name='+',
        help_text='Host image'
    )

    body = StreamField(
        GlobalStreamBlock(), verbose_name="Host's biography", blank=True
        )
    # We've defined the StreamBlock() within blocks.py that we've imported on
    # line 20. Defining it in a different file aids consistency across the site
    # but it can be defined on a per page basis if that's helpful for you

    content_panels = Page.content_panels + [
        ImageChooserPanel('image'),
        StreamFieldPanel('body'),
        InlinePanel(
            'host_experience_relationship',
            label='Providing Experience',
            min_num=None
            ),
        InlinePanel(
            'host_interest_relationship',
            label='Interest',
            min_num=None,
            max_num=1
            ),
        InlinePanel(
            'host_location_relationship',
            label='Location',
            min_num=None,
            max_num=1
            ),
    ]

    # Defining the parent. This means the editor will only be able to add the
    # page under a HostIndexPage and won't see that the HostPage exists as
    # an option until that parent page has been added.
    parent_page_types = [
        'HostIndexPage'
    ]

    # Defining what content type can sit under the parent
    # The empty array will mean no children can be added
    subpage_types = []

    # We iterate within the model over the experiences, interest
    # and location so they can be accessible to the template
    def experiences(self):
        experiences = [
            n.experiences for n in self.host_experiences_relationship.all()
        ]
        return experiences

    def interest(self):
        interest = [
            n.host_interests for n in self.host_interest_relationship.all()
        ]
        return interest

    def location(self):
        location = [
            n.location for n in self.host_location_relationship.all()
        ]
        return location

    # For ForeignKeys that we want to access via the API we need to explictly
    # access a specific field from the related content. I've added unnecessary
    # verbosity here because we could use the `experiences(self)` method above to
    # give us the objects in a list within the for loop.
    # This isn't terribly useful since I'm only returning the title but hopefully
    # enough to be extendable/ understandable
    def experience(obj):
        experience_set = obj.host_experience_relationship.all()
        experiences = [
            n.experience for n in experience_set
        ]
        for experience in experiences:
            return experience.title

    api_fields = [
        'image',
        'body',
        'experience'
    ]


class HostIndexPage(Page):
    """
    This is a page to list all the hosts on the site
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
        help_text='Hosts listing image'
    )

    introduction = models.TextField(
        help_text='Text to describe the index page',
        blank=True)

    content_panels = Page.content_panels + [
        ImageChooserPanel('image'),
        FieldPanel('introduction')
    ]

    parent_page_types = [
        'home.HomePage'
    ]

    # Defining what content type can sit under the parent
    subpage_types = [
        'HostPage'
    ]

# We're using get context to organise alphabetically
# Docs http://docs.wagtail.io/en/v1.6.3/topics/pages.html#template-context
    def get_context(self, request):
        context = super(HostIndexPage, self).get_context(request)
        context['hosts'] = HostPage.objects.descendant_of(
            self).live().order_by(
            'title')
        return context