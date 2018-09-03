import calendar
from datetime import datetime
from collections import defaultdict
from dateutil import relativedelta
from django import template
from doolay.experiences.models import ExperiencePage
from collections import namedtuple

register = template.Library()

HOUR = 60 * 60

CalendarDate = namedtuple('CalendarDate', 'day, isodate, is_available')

@register.filter
def duration(time_delta):
    total_seconds = int(time_delta.total_seconds())
    hours = float(total_seconds / HOUR)

    return "{:.1f} hours".format(hours)


@register.inclusion_tag('tags/experiences_grid.html', takes_context=True)
def experiences_grid(context):
    return {
        'experiences':
        ExperiencePage.objects.all().live().order_by('-first_published_at'),
        'request':
        context['request'],
    }

@register.inclusion_tag('tags/booking_modal.html', takes_context=True)
def booking_modal(context):
    return { 'request': context['request'] }

@register.inclusion_tag('tags/booking_calendar.html', takes_context=True)
def booking_calendar(context):
    page = context.get('self')
    available_dates = page.get_available_slot_dates()
    today = datetime.today()
    today_next_month = today + relativedelta.relativedelta(months=1)
    this_month_days = get_calendar_month_days(today.year, today.month, available_dates)
    next_month_days = get_calendar_month_days(today_next_month.year, today_next_month.month, available_dates)
    return {
        'request': context['request'],
        'this_month': today.strftime(calendar.month_name.format),
        'this_month_year': today.year,
        'this_month_previous': this_month_days['previous'],
        'this_month_current': this_month_days['current'],
        'this_month_next': this_month_days['next'],

        'next_month': today_next_month.strftime(calendar.month_name.format),
        'next_month_year': today_next_month.year,
        'next_month_previous': next_month_days['previous'],
        'next_month_current': next_month_days['current'],
        'next_month_next': next_month_days['next'],
    }


def get_calendar_month_days(year, month, available_dates):
    date_by_month = defaultdict(list)
    cal = calendar.Calendar(calendar.SUNDAY)
    for date in cal.itermonthdates(year, month):
        if date.month < month:
            date_by_month['previous'].append(CalendarDate(date.day, date.strftime('%Y-%m-%d'), date in available_dates))
        elif date.month == month:
            date_by_month['current'].append(CalendarDate(date.day, date.strftime('%Y-%m-%d'), date in available_dates))
        else:
            date_by_month['next'].append(CalendarDate(date.day, date.strftime('%Y-%m-%d'), date in available_dates))
    return date_by_month
