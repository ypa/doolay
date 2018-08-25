from django.test import TestCase
from django.conf import settings
from doolay.bookings.models import Booking, BookingSlot, BookingSlotRequest
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


class BookingSlotRequestCreateViewTest(TestCase):
    fixtures = ['unittest_data.json']

    def setUp(self):
        self.exp = ExperiencePage.objects.first()
        self.booking = Booking(experience_page=self.exp)
        self.booking.save()
        self.slot_recipe = Recipe(BookingSlot, booking=self.booking)
        self.slot_recipe.make()

    def test_saving_a_POST_slot_request_request(self):
        slot = BookingSlot.objects.first()
        self.assertEqual(slot.booking_slot_requests.count(), 0) # makeing sure no request created for slot yet
        response = self.client.post(
            '/bookings/request/%d/' % (slot.id,),
            data= {
                'request_date': '2018-08-26', 
                'first_name': 'Joe', 
                'last_name': 'Doe',
                'email_address': 'jd@example.com', 
                'group_size': 4,
                'message': 'We need a child seat',
            }
        )
        self.assertEqual(response.status_code, 302)
        slot.refresh_from_db()
        self.assertEqual(slot.booking_slot_requests.count(), 1)


