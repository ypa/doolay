from django.utils import timezone
from rest_framework import serializers
from doolay.bookings.models import BookingSlotRequest


class BookingSlotRequestSerializer(serializers.ModelSerializer):

    class Meta:
        model = BookingSlotRequest
        fields = '__all__'

    def validate(self, data):
        request_dt = data['request_date']
        self.validate_request_slot_date(request_dt)
        return super(__class__, self).validate(data)

    def get_entire_day_date_time_range_from_datetime(self, dt):
        start_window = dt.replace(hour=0, minute=0, second=0, microsecond=0)
        end_window = dt.replace(hour=23, minute=59, second=59, microsecond=0)
        return (start_window, end_window)

    def validate_request_slot_date(self, request_dt):

        if request_dt.date() not in self.fetch_inventory_slot_dates(request_dt):
            raise serializers.ValidationError('The requested date is not available')

        if self.is_request_already_booked(request_dt):
            raise serializers.ValidationError('The requested date was recently marked as unavailable')

        return request_dt

    def fetch_inventory_slot_dates(self, request_dt):
        slot = self.context['slot']
        from_dt, to_dt = self.get_entire_day_date_time_range_from_datetime(request_dt)
        return [start_dt.date() for (start_dt, end_dt, s) in
                slot.all_occurrences(from_dt, to_dt)]

    def is_request_already_booked(self, request_dt):
        dt_range = self.get_entire_day_date_time_range_from_datetime(request_dt)
        already_requested = BookingSlotRequest.objects.filter(request_date__range=dt_range)
        return already_requested.count() > 0

    def create(self, validated_data):
        validated_data['slot'] = self.context['slot']
        return BookingSlotRequest.objects.create(**validated_data)