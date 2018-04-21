from django.db import models
from django.conf import settings


class BookingStatus(modles.Model):
    name = models.SlugField()
    description = models.CharField(max_length=255)


class Booking(models.Model):
    USD = 'USD'
    MMK = 'MMK'

    CURRENCY_CHOICES = (
        (USD, 'USD'),
        (MMK, 'MMK')
    )

    experience = models.ForeignKey('experiences.ExperiencePage', null=False)
    customer_email = models.EmailField()
    customer_first_name = models.CharField(max_length=35)
    customer_last_name = models.CharField(max_length=50)
    group_size = models.PositiveSmallIntegerField(null=False, blank=False)
    status = models.ForeignKey(
        'bookings.BookingStatus'
        verbose_name='Booking Status',
        null=False,
        blank=False,
    )
    start_at = models.DateTimeField(
        null=False,
        blank=False,
        verbose_name='Experience start date time'
    )
    special_request = models.Text(verbose_name='Customer special request')
    price = models.DecimalField(max_digits=9, decimal_places=2)
    currency = models.CharField(choices=CURRENCY_CHOICES, default=USD)
    notes = models.Text(verbose_name='Staff notes')
    time_period = models.PositiveIntegerField(
        verbose_name='Time period',
        blank=True, null=True,
    )
    time_unit = models.CharField(
        verbose_name=_('Time unit'),
        default=getattr(settings, 'BOOKING_TIME_INTERVAL', 'hour'),
        max_length=10,
        blank=True,
    )
    confirmation_id = models.CharField(
        verbose_name=_('Confirmation Number'),
        max_length=36,
        unique=True,
        null=True,
        blank=True,
    )
    created_at = models.DateTimeField(auto_now_add=True)
    modified_at = models.DateTimeField(auto_now=True)

    class Meta:
        ordering = ['-created_at']

    def __str__(self):
        return '#{} ({})'.format(self.confirmation_id or self.pk,
                                 self.created_at)