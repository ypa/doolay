from django import template

register = template.Library()


MINUTE = 60
HOUR = 60 * 60
DAY = 60 * 60 * 24


@register.filter
def duration(time_delta):
    duration_str = ''

    total_seconds = int(time_delta.total_seconds())
    days = total_seconds // DAY
    hours = (total_seconds % DAY) // HOUR
    minutes = (total_seconds % HOUR) // MINUTE

    if days:
        duration_str += '{} days '.format(days)
    if hours:
        duration_str += '{} hours '.format(hours)

    duration_str += '{} minutes'.format(minutes)

    return duration_str

