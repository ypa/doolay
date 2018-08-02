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
    return { 'request': context['request'] }
