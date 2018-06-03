from django.contrib import admin

from doolay.bookings.models import BookingSlot

class BookingSlotAdmin(admin.ModelAdmin):
    list_display = ['start', 'end', 'repeat', 'repeat_until', 'notes']

admin.site.register(BookingSlot, BookingSlotAdmin)
