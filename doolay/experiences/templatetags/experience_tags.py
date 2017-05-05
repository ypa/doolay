from django import template

register = template.Library()


HOUR = 60 * 60


@register.filter
def duration(time_delta):
    total_seconds = int(time_delta.total_seconds())
    hours = float(total_seconds / HOUR)

    return "{:.1f} hours".format(hours)

