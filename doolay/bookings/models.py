from django.db import models


from eventtools.models import BaseEvent, BaseOccurrence
from doolay.experiences.models import ExperiencePage


class Booking(BaseEvent):
	experience_page = models.OneToOneField(
        ExperiencePage,
        on_delete=models.CASCADE,
        primary_key=True,
    )


class BookingSlot(BaseOccurrence):
	booking = models.ForeignKey(
		Booking,
		on_delete=models.CASCADE,
		related_name='booking_slots',
		related_query_name='booking_slot',
	)
