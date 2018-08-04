import calendar
from collections import defaultdict
from django import template
from doolay.experiences.models import ExperiencePage

register = template.Library()

HOUR = 60 * 60


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
    year, month = get_current_year_month()
    this_month_days = get_calendar_month_days(year, month)
    return {
        'request': context['request'],
        'month': month,
        'year': year,
        'this_month_previous': this_month_days['previous'],
        'this_month_current': this_month_days['current'],
        'this_month_next': this_month_days['next'],
    }


def get_current_year_month():
    return (2018, 8)


def get_calendar_month_days(year, month):
    date_by_month = defaultdict(list)
    cal = calendar.Calendar(calendar.SUNDAY)
    for date in cal.itermonthdates(year, month):
        if date.month < month:
            date_by_month['previous'].append(date.day)
        elif date.month == month:
            date_by_month['current'].append(date.day)
        else:
            date_by_month['next'].append(date.day)
    return date_by_month
