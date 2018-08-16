
from wagtail.core.models import Page
from wagtail.tests.utils import WagtailPageTests
from doolay.home.models import HomePage

class HomePageTests(WagtailPageTests):

	def test_can_create_a_page(self):
		self.assertCanCreateAt(HomePage, Page)

