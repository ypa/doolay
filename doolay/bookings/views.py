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
        return super().form_valid(form)

