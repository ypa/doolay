from __future__ import unicode_literals

from django.db import models

from modelcluster.models import ClusterableModel
from modelcluster.fields import ParentalKey
from modelcluster.tags import ClusterTaggableManager
from taggit.models import TaggedItemBase

from wagtail.wagtailcore.models import Page, Orderable
from wagtail.wagtailsearch import index
from wagtail.wagtailimages.edit_handlers import ImageChooserPanel
from wagtail.wagtailcore.fields import StreamField
from wagtail.wagtailadmin.edit_handlers import (
        FieldPanel,
        InlinePanel,
        StreamFieldPanel,
        PageChooserPanel,
        MultiFieldPanel
        )
from wagtail.wagtailsnippets.models import register_snippet
from wagtail.wagtailsnippets.edit_handlers import SnippetChooserPanel
from doolay.blocks import GlobalStreamBlock


class HostInterest(TaggedItemBase):
    content_object = ParentalKey('HostPage', related_name='host_interests')


@register_snippet
class HostLanguage(ClusterableModel):
    """
    This snippet allows an editor to define what possible employment languages
    a staff member may have. Or whether they're a wizard...
    """

    search_fields = Page.search_fields + [
        index.SearchField('title'),
    ]

    title = models.CharField("Language", max_length=254)

    panels = [
        FieldPanel('title'),
    ]

    def __str__(self):
        # We have to return a string to populate the snippets screen. The
        # Snippets admin screen will only support a string
        return self.title

    class Meta:
        ordering = ['title']
        verbose_name = "Language"
        verbose_name_plural = "Languages"


class HostLanguageRelationship(models.Model):
    """
    This defines the relationship between the `HostEmploymentLanguage` snippet
    above and the HostPage below. It does so by defining a ForeignKey
    relationship between the two, which can be accessed by the respective
    'related_name'. The magic key is the 'related_name'
    Docs: http://www.tivix.com/blog/working-wagtail-i-want-my-m2ms/
    """
    host_page = ParentalKey(
        'HostPage', related_name='host_language_relationship'
    )
    host_languages = models.ForeignKey(
        'HostLanguage',
        related_name="language_host_relationship"
    )
    panels = [
        SnippetChooserPanel('host_languages')
    ]


class HostPlaceRelationship(models.Model):
    """
    This defines the relationship between the `PlacePage`, within the
    `places` app, and the HostPage below. Again the magic key is
    the related_name. On the PlacePage model in the places app you can
    see the reverse relationship of the related_name being used to populate
    hosts on the PlacePage
    """
    host_page = ParentalKey(
        'HostPage', related_name='host_place_relationship'
    )
    place = models.ForeignKey(
        'places.PlacePage',
        related_name="place_host_relationship"
    )
    panels = [
        PageChooserPanel('place')
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

    interests = ClusterTaggableManager(through=HostInterest, blank=True)

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
            label='Providing Experiences',
            min_num=None
        ),
        InlinePanel(
            'host_language_relationship',
            label='Language',
            min_num=None,
            max_num=3
        ),
        FieldPanel('interests'),
        InlinePanel(
            'host_place_relationship',
            label='Place',
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

    # We iterate within the model over the experiences, language
    # and place so they can be accessible to the template
    def experiences(self):
        experiences = [
            n.experiences for n in self.host_experience_relationship.all()
        ]
        return experiences

    def languages(self):
        languages = [
            n.host_languages for n in self.host_language_relationship.all()
        ]
        return languages

    def places(self):
        places = [
            n.place for n in self.host_place_relationship.all()
        ]
        return places

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
