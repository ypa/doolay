from django.db import models
from wagtail.wagtailadmin.edit_handlers import FieldPanel

class ContactFields(models.Model):
    name = models.CharField(max_length=255, blank=True)
    email = models.EmailField(blank=True)
    city = models.CharField(max_length=255, blank=True)
    country = models.CharField(max_length=255, blank=True)

    panels = [
        FieldPanel('name', 'The full/formatted name of the person'),
        FieldPanel('email'),
        FieldPanel('city'),
        FieldPanel('country'),
    ]

    class Meta:
        abstract = True
