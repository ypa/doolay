from datetime import timedelta
import json
from django.utils import timezone
from django.test import TestCase
from django.conf import settings
from doolay.bookings.models import Booking, BookingSlot, BookingSlotRequest
from doolay.experiences.models import ExperiencePage
from rest_framework.serializers import ValidationError

from eventtools.models import REPEAT_CHOICES


from model_mommy import mommy
from model_mommy.recipe import Recipe, foreign_key



class BookingModelTest(TestCase):
    fixtures = ['test.json']

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
    fixtures = ['test.json']

    def setUp(self):
        self.exp = ExperiencePage.objects.first()
        self.booking = Booking(experience_page=self.exp)
        self.booking.save()
        self.slot_recipe = Recipe(BookingSlot, booking=self.booking)
        self.slot_recipe.make()

    def _request_booking_for_slot(self, slot_id, request_dt, group_size):
        response = self.client.post(
            '/api/bookings/%d/request/' % slot_id,
            json.dumps({
                'request_date': request_dt.strftime('%Y-%m-%d'),
                'first_name': 'Joe', 
                'last_name': 'Doe',
                'email_address': 'jd@example.com', 
                'group_size': group_size,
                'message': 'We need a child seat',
            }),
            content_type='application/json',
        )
        return response

    def test_create_booking_slot_occurrences(self):
        slot  = BookingSlot(
                                booking=self.booking,
                                start=timezone.now(),
                                end=timezone.now() + timedelta(hours=8),
                                repeat=REPEAT_CHOICES[1][0], # weekly
                                repeat_until=(timezone.now() + timedelta(weeks=4)).date(),
                                notes='test notes'
                            )

        slot.save()
        slot.refresh_from_db()
        self.assertEqual(len([oc for oc in slot.all_occurrences()]), 5)

    def test_saving_a_POST_slot_request_request(self):
        slot = BookingSlot.objects.first()
        self.assertEqual(slot.booking_slot_requests.count(), 0) # makeing sure no request created for slot yet
        request_dt = slot.first_occurrence()[0]
        response = self._request_booking_for_slot(slot.id, request_dt, group_size=4)
        self.assertEqual(response.status_code, 201)
        slot.refresh_from_db()
        self.assertEqual(slot.booking_slot_requests.count(), 1) # verify that one entry got created

    def test_slot_request_raises_validation_error_if_no_occurrence(self):
        slot  = BookingSlot(
                    booking=self.booking,
                    start=timezone.now(),
                    end=timezone.now() + timedelta(hours=8),
                    repeat=REPEAT_CHOICES[1][0], # weekly
                    repeat_until=(timezone.now() + timedelta(weeks=4)).date(),
                    notes='test notes'
                )

        slot.save()
        slot.refresh_from_db()

        request_dt = slot.first_occurrence()[0] - timedelta(days=1)
        response = self._request_booking_for_slot(slot.id, request_dt, group_size=4)
        self.assertEqual(response.status_code, 400)
        slot.refresh_from_db()
        self.assertEqual(slot.booking_slot_requests.count(), 0)

    def test_slot_request_raises_validation_error_if_not_available(self):
        """
        Prevent double-booking test.
        """
        slot  = BookingSlot(
                    booking=self.booking,
                    start=timezone.now(),
                    end=timezone.now() + timedelta(hours=8),
                    repeat=REPEAT_CHOICES[1][0], # weekly
                    repeat_until=(timezone.now() + timedelta(weeks=4)).date(),
                    notes='test notes'
                )

        slot.save()
        slot.refresh_from_db()
        request_dt = slot.first_occurrence()[0]
        response = self._request_booking_for_slot(slot.id, request_dt, group_size=4)
        self.assertEqual(response.status_code, 201)
        slot.refresh_from_db()
        self.assertEqual(slot.booking_slot_requests.count(), 1) # verify that the first request got created

        # now attempt to request for the same spot.
        response = self._request_booking_for_slot(slot.id, request_dt, group_size=4)
        self.assertEqual(response.status_code, 400) # verify that it throws bad request error
        slot.refresh_from_db()
        self.assertEqual(slot.booking_slot_requests.count(), 1) # verify that another request didn't get created
