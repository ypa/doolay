from django.test import TestCase
from django.conf import settings
from doolay.bookings.models import Booking, BookingSlot
from doolay.experiences.models import ExperiencePage


from model_mommy import mommy
from model_mommy.recipe import Recipe, foreign_key



class BookingModelTest(TestCase):
    fixtures = ['unittest_data.json']

    def setUp(self):
        self.exp = ExperiencePage.objects.first()
        self.booking = Booking(experience_page=self.exp)
        self.booking.save()

    def test_booking_is_linked_to_experience(self):
        self.assertEqual(self.exp.booking, self.booking)

    def test_create_booking_slots(self):
        slot_recipe = Recipe(BookingSlot, booking=self.booking)
        slot = slot_recipe.make()
        self.assertEqual(slot, BookingSlot.objects.get(pk=slot.pk))

    def test_slot_get_abs_url(self):
        slot = mommy.make(BookingSlot, booking=self.booking)
        abs_url = slot.get_absolute_url()
        self.assertIn(str(self.booking), abs_url)
