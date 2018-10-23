from django.utils import dateparse
from rest_framework.generics import CreateAPIView
from doolay.bookings.models import BookingSlot, BookingSlotRequest
from doolay.bookings.serializers import BookingSlotRequestSerializer


class BookingSlotRequestAPIView(CreateAPIView):
    serializer_class = BookingSlotRequestSerializer
    lookup_slot_id_kwarg = 'slot_id'

    def get_query_set(self):
        slot = self.get_slot()
        return slot.booking_slot_requests.all()

    def get_serializer_context(self):
        context = super(__class__, self).get_serializer_context() 
        context['slot'] = self.get_slot()
        return context

    def get_slot(self):
        slot_id = self.kwargs.get(self.lookup_slot_id_kwarg)
        return BookingSlot.objects.get(pk=int(slot_id))

    def get_serializer(self, *args, **kwargs):
        data = kwargs['data']
        # Forcing request_date field date value to a datetime value.
        request_d = dateparse.parse_date(data['request_date'])
        kwargs['data']['request_date'] = request_d.strftime('%Y-%m-%d 00:00:00')
        return super(__class__, self).get_serializer(*args, **kwargs)
