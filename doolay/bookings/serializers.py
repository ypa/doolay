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
        slot = self.context['slot']
        from_date = self.get_datetime_from_date(request_date)
        to_date = self.get_datetime_from_date(request_date, 23, 59, 59)
        available_slots = [start_dt.date() for (start_dt, end_dt, s) in
                           slot.all_occurrences(from_date, to_date)]
        if request_date not in available_slots:
            raise serializers.ValidationError('The requested date is not available')
        else:
            return None

    def create(self, validated_data):
        validated_data['slot'] = self.context['slot']
        return BookingSlotRequest.objects.create(**validated_data)