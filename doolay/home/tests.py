
import unittest
from django.test import Client
from wagtail.core.models import Page
from wagtail.tests.utils import WagtailPageTests
from doolay.home.models import HomePage

class HomePageTests(WagtailPageTests):
    fixtures = ['test.json']

    def test_can_create_a_page(self):
        self.assertCanCreateAt(HomePage, Page)

    def test_full_url(self):
        home_page = HomePage.objects.first()
        self.assertEqual(home_page.get_url(), '/')

    def test_homepage_under_root(self):
        home_page = HomePage.objects.first()
        root_page = home_page.get_root()
        self.assertTrue(root_page.is_root())

class HomePageViewTests(unittest.TestCase):

    def setUp(self):
        self.client = Client()

    def test_can_navigate_to_root_url(self):
        response = self.client.get('/')
        self.assertEqual(response.status_code, 200)

