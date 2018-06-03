from django.db import models
from django.db.models.signals import post_save
from django.dispatch import receiver

from eventtools.models import BaseEvent, BaseOccurrence
from doolay.experiences.models import ExperiencePage


class Booking(BaseEvent):
	experience_page = models.OneToOneField(
        ExperiencePage,
        on_delete=models.CASCADE,
        primary_key=True,
    )


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
	)

	notes = models.TextField(
		help_text='Notes about the booking slot',
		blank=True,
		null=True
	)
