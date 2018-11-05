from datetime import datetime
from rest_framework import serializers
from doolay.bookings.models import BookingSlotRequest


class BookingSlotRequestSerializer(serializers.ModelSerializer):

    class Meta:
        model = BookingSlotRequest
        fields = '__all__'

    def validate(self, data):
        request_dt = data['request_date']
        self.validate_request_slot_date(request_dt.date())
        return super(__class__, self).validate(data)

    def get_datetime_from_date(self, date, hour=0, minute=0, second=0):
        return datetime(
            year=date.year,
            month=date.month,
            day=date.day,
            hour=hour,
            minute=minute,
            second=second
        )

    def validate_request_slot_date(self, request_date):

        request_date_valid = True

        if self.is_request_not_available(request_date):
            request_date_valid = False

        if request_date not in self.fetch_inventory_slot_dates(request_date):
            request_date_valid = False

        if not request_date_valid:
            raise serializers.ValidationError('The requested date is not available')
        else:
            return request_date_valid

    def fetch_inventory_slot_dates(self, request_date):
        slot = self.context['slot']
        from_date = self.get_datetime_from_date(request_date)
        to_date = self.get_datetime_from_date(request_date, 23, 59, 59)

        return [start_dt.date() for (start_dt, end_dt, s) in
                slot.all_occurrences(from_date, to_date)]

    def is_request_not_available(self, request_date):
        already_requested = BookingSlotRequest.objects.filter(request_date=request_date)
        return already_requested.count() > 0

    def create(self, validated_data):
        validated_data['slot'] = self.context['slot']
        return BookingSlotRequest.objects.create(**validated_data)