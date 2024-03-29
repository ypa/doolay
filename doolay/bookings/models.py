from django.db import models
from django.db.models.signals import post_save
from django.dispatch import receiver
from django.urls import reverse

from eventtools.models import BaseEvent, BaseOccurrence
from doolay.experiences.models import ExperiencePage


class Booking(BaseEvent):

    experience_page = models.OneToOneField(
        ExperiencePage,
        on_delete=models.CASCADE,
        primary_key=True,
        verbose_name="experience page",
    )

    def __str__(self):
        exp_page = self.experience_page
        host = exp_page.host
        return "%s - %s" % (host, exp_page)


@receiver(post_save, sender=ExperiencePage)
def create_booking(sender, instance, created, **kwargs):
    if created:
        Booking.objects.create(experience_page=instance)


class BookingSlot(BaseOccurrence):
    booking = models.ForeignKey(
        Booking,
        on_delete=models.CASCADE,
        related_name='booking_slots',
        related_query_name='booking_slot',
        verbose_name='Booking for Experience page')

    notes = models.TextField(
        help_text='Notes about the booking slot', blank=True, null=True)

    def get_absolute_url(self):
        url = reverse(
            'admin:%s_%s_change' % (self._meta.app_label,
                                    self._meta.model_name),
            args=[self.id])
        return u'<a href="%s" title="%s">%s</a>' % (url, str(self.start),
                                                    str(self.booking))

class BookingSlotRequest(models.Model):
    request_date = models.DateTimeField(db_index=True)

    slot = models.ForeignKey(
        BookingSlot,
        on_delete=models.SET_NULL,
        null=True,
        related_name='booking_slot_requests',
        related_query_name='booking_slot_request',
        verbose_name='Request for booking slot')

    first_name = models.CharField(max_length=254)

    last_name = models.CharField(max_length=254)

    email_address = models.EmailField()

    group_size = models.PositiveIntegerField()

    message = models.TextField(
        help_text='Special notes', blank=True, null=True)
