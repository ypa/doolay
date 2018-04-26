from wagtail.contrib.modeladmin.options import (
    ModelAdmin, ModelAdminGroup, modeladmin_register
)
from doolay.bookings.models import BookingStatus, Booking

class BookingStatusAdmin(ModelAdmin):
    model = BookingStatus
    menu_label = 'Booking Statuses'
    menu_icon = 'snippet'
    list_display = ('name', 'description')
    list_filter = ('name',)
    search_fields = ('name',)

class BookingAdmin(ModelAdmin):
    model = Booking
    menu_label = 'Booking'
    menu_icon = 'snippet'
    list_display = ('experience', 'customer_email')
    list_filter = ('customer_email',)
    search_fields = ('customer_email',)

class BookingAdminGroup(ModelAdminGroup):
    menu_label = 'Booking'
    menu_icon = 'folder-open-inverse'  # change as required
    menu_order = 200  # will put in 3rd place (000 being 1st, 100 2nd)
    items = (BookingStatusAdmin, BookingAdmin)

modeladmin_register(BookingAdminGroup)
