from django.core.management.base import BaseCommand
from doolay.experiences.models import ExperiencePage
from doolay.bookings.models import Booking


class Command(BaseCommand):
    """
	Command to back-fill Booking objects for all ExperiencePage objects
	that don't have one associated.
	"""

    def handle(self, **options):
        experience_pages = ExperiencePage.objects.filter(booking__isnull=True)

        for experience_page in experience_pages:
            Booking.objects.create(experience_page=experience_page)

        return None
