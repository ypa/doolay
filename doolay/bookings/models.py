from datetime import timedelta
from django.db import models
from django.conf import settings
from django.forms import ValidationError
from wagtail.wagtailsearch import index
from wagtail.wagtailadmin.edit_handlers import FieldPanel
from wagtail.wagtailcore.models import Page, Orderable
from wagtail.wagtailsnippets.models import register_snippet
from modelcluster.models import ClusterableModel


@register_snippet
class BookingStatus(ClusterableModel):
    search_fields = Page.search_fields + [
        index.SearchField('title'),
    ]
    title = models.SlugField()
    description = models.CharField(max_length=255)

    panels = [
        FieldPanel('title'),
        FieldPanel('description'),
    ]

    def __str__(self):
        return self.title

    class Meta:
        ordering = ['title']
        verbose_name = "Booking Status"
        verbose_name_plural = "Booking Statuses"


class Booking(Page):
    USD = 'USD'
    MMK = 'MMK'

    CURRENCY_CHOICES = (
        (USD, 'USD'),
        (MMK, 'MMK')
    )

    experience = models.ForeignKey(
        'experiences.ExperiencePage',
        null=True,
        blank=False,
        on_delete=models.SET_NULL,
    )
    customer_email = models.EmailField()
    customer_first_name = models.CharField(max_length=35)
    customer_last_name = models.CharField(max_length=50)
    group_size = models.PositiveSmallIntegerField(null=False, blank=False)
    status = models.ForeignKey(
        'bookings.BookingStatus',
        verbose_name='Booking Status',
        null=True,
        blank=False,
        on_delete=models.SET_NULL,
    )
    start_at = models.DateTimeField(
        null=False,
        blank=False,
        verbose_name='Experience start date time'
    )
    special_request = models.TextField(verbose_name='Customer special request')
    price = models.DecimalField(max_digits=9, decimal_places=2)
    currency = models.CharField(max_length=3, choices=CURRENCY_CHOICES, default=USD)
    notes = models.TextField(verbose_name='Staff notes')
    time_period = models.PositiveIntegerField(
        verbose_name='Time period',
        blank=True, null=True,
    )
    time_unit = models.CharField(
        verbose_name='Time unit',
        default=getattr(settings, 'BOOKING_TIME_INTERVAL', 'hour'),
        max_length=10,
        blank=False,
        null=False,
    )
    confirmation_id = models.CharField(
        verbose_name='Confirmation Number',
        max_length=36,
        unique=True,
        null=True,
        blank=True,
    )
    created_at = models.DateTimeField(auto_now_add=True)
    modified_at = models.DateTimeField(auto_now=True)

    content_panels = Page.content_panels + [
        FieldPanel('price'),
        FieldPanel('currency'),
        FieldPanel('notes'),
        FieldPanel('status'),
        FieldPanel('time_period'),
        FieldPanel('time_unit'),
    ]

    # Defining the parent. This means the editor will only be able to add the
    # page under a ExperiencePage and won't see that the Booking exists as
    # an option until that parent page has been added.
    parent_page_types = [
        'experiences.ExperiencePage'
    ]

    @property
    def duration(self):
        if self.time_period is not None:
            time_unit_plura = '%ss' % (self.time_unit.strip(),)
            duration_params = {time_unit_plura: self.time_period}
            return timedelta(**duration_params)
        else:
            return None

    def validate_duration(self):
        if self.duration is not None:
            if self.duration != self.experience.duration:
                msg = ("Experience page duration and booking duration don't match")
                raise ValidationError(msg)

    def clean(self, *args, **kwargs):
        # self.validate_duration()
        super(Booking, self).clean(*args, **kwargs)

    def __str__(self):
        return '#{} ({})'.format(self.confirmation_id or self.pk,
                                 self.created_at)
    class Meta:
        unique_together = (
            ('experience', 'start_at'), # To avoid duplicate entries on the same date time.
        )
        index_together = [
            ['customer_email'],
            ['customer_last_name', 'customer_first_name'],
        ]
        ordering = ['-created_at']
