from django.test import TestCase
from django.conf import settings
from doolay.bookings.models import Booking
from doolay.experiences.models import ExperiencePage


from model_mommy import mommy
from model_mommy.recipe import Recipe, foreign_key



class BookingModelTest(TestCase):
	fixtures = ['unittest_data.json']

	def test_create_booking(self):
		exp = ExperiencePage.objects.first()
		booking = Booking(experience_page=exp)
		booking.save()

		exp = ExperiencePage.objects.get(pk=exp.pk)
		self.assertEqual(exp.booking, booking)
