from django.forms import ValidationError
from django.shortcuts import get_object_or_404
from django.views.generic.edit import CreateView
from doolay.bookings.models import BookingSlotRequest, BookingSlot


class BookingSlotRequestCreate(CreateView):
    model = BookingSlotRequest
    success_url = '/'
    # form_class = BookingSlotRequestForm
    fields = ['request_date', 'first_name', 'last_name',
              'email_address', 'group_size', 'message']

    def dispatch(self, request, *args, **kwargs):
        """
        Overridden so we can make sure the `BookingSlot` instance exists
        before going any further.
        https://codereview.stackexchange.com/questions/164147/createview-set-foreign-key-from-url-parameter
        """
        self.slot = get_object_or_404(BookingSlot, pk=kwargs['slot_id'])
        return super().dispatch(request, *args, **kwargs)

    def form_valid(self, form):
        """
        Overridden to add the Slot relation to the `SlotRequest` instance.
        """
        form.instance.slot = self.slot
        self.validate_request_date(form)
        return super().form_valid(form)

    def validate_request_date(self, form):
        slot = form.instance.slot
        request_date = form.instance.request_date
        from_date = request_date.replace(hour=0, minute=0, second=0)
        to_date = request_date.replace(hour=23, minute=59, second=59)
        available_slots = [start_dt.date() for (start_dt, end_dt, slot) in
                          self.slot.all_occurrences(from_date, to_date)]
        if request_date.date() not in available_slots:
            raise ValidationError('The requested date is not available', code='invalid')
        else:
            return None
