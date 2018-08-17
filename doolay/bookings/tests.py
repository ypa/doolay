from django.test import TestCase
from django.conf import settings
from doolay.home.models import HomePage


from model_mommy import mommy
from model_mommy.recipe import Recipe, foreign_key



class BookingModelTest(TestCase):
	fixtures = ['doolay/fixtures/unittest_data.json']

	def test_home(self):
		home = HomePage.objects.first()
		self.assertEqual(home, '')
