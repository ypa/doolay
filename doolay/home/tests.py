
from wagtail.core.models import Page
from wagtail.tests.utils import WagtailPageTests
from doolay.home.models import HomePage

class HomePageTests(WagtailPageTests):
	fixtures = ['unittest_data.json']

	def test_can_create_a_page(self):
		self.assertCanCreateAt(HomePage, Page)

	def test_absolute_url(self):
		home_page = HomePage.objects.first()
		self.assertTrue(home_page.is_root())
		self.assertEqual(home_page.get_url(), '/')

