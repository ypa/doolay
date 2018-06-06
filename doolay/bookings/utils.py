from calendar import HTMLCalendar
from datetime import datetime as dtime, date, time
import datetime
from doolay.bookings.models import BookingSlot
 
 
class BookingSlotCalendar(HTMLCalendar):
    """
    Rendering HTMLCalendar using python's calendar module.
    https://alexpnt.github.io/2017/07/15/django-calendar/
    """
    def __init__(self, slots=None):
        super(BookingSlotCalendar, self).__init__()
        self.slots = slots
 
    def formatday(self, day, weekday, slots):
        """
        Return a day as a table cell.
        """
        slots_from_day = slots.filter(start__day=day)
        slots_html = "<ul>"
        for slot in slots_from_day:
            slots_html += slot.get_absolute_url() + "<br>"
        slots_html += "</ul>"
 
        if day == 0:
            return '<td class="noday">&nbsp;</td>'  # day outside month
        else:
            return '<td class="%s">%d%s</td>' % (self.cssclasses[weekday], day, slots_html)
 
    def formatweek(self, theweek, slots):
        """
        Return a complete week as a table row.
        """
        s = ''.join(self.formatday(d, wd, slots) for (d, wd) in theweek)
        return '<tr>%s</tr>' % s
 
    def formatmonth(self, booking_id, theyear, themonth, withyear=True):
        """
        Return a formatted month as a table.
        """
 
        slots = BookingSlot.objects.filter(booking_id=booking_id, start__month=themonth)
 
        v = []
        a = v.append
        a('<table border="0" cellpadding="0" cellspacing="0" class="month">')
        a('\n')
        a(self.formatmonthname(theyear, themonth, withyear=withyear))
        a('\n')
        a(self.formatweekheader())
        a('\n')
        for week in self.monthdays2calendar(theyear, themonth):
            a(self.formatweek(week, slots))
            a('\n')
        a('</table>')
        a('\n')
        return ''.join(v)