from django.core.management.base import BaseCommand
from wagtail.wagtailimages.models import Rendition


class Command(BaseCommand):
    """
    Command to delete wagtial thumbnails in Wagtail image Renditions.
    So that they can get regenerated.
    """

    def handle(self, **options):
        renditions = Rendition.objects.all()
        renditions.delete()

