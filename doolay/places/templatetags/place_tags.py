from django import template
register = template.Library()

@register.inclusion_tag('tags/experiences_grid.html')
def experiences_grid(place_page):
    return {
        'experiences': place_page.experiences.all(),
    }
