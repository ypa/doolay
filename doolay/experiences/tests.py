
import unittest
from django.test import Client
from wagtail.tests.utils import WagtailPageTests
from doolay.home.models import HomePage
from doolay.experiences.models import ExperiencePage, ExperienceIndexPage
from model_mommy.recipe import Recipe, foreign_key
from doolay.places.models import PlacePage
from doolay.hosts.models import HostPage
from doolay.bookings.models import Booking


class ExpPageFactoryMixin(object):

    def make_experience_page(self):
        existing_page_count = ExperienceIndexPage.objects.count()

        host = HostPage.objects.first()
        assert host is not None, "At least one host page is needed to create an experience page"

        place = PlacePage.objects.first()
        assert host is not None, "At least one place page is needed to create an experience page"

        return Recipe(
            ExperiencePage,
            host=host,
            place=place,
            path=self.get_next_exp_page_path(),
            depth=4,
        ).make()

    def get_next_exp_page_path(self):
        # TODO: Replace this code and instead ask wagatail for the next path
        exp_path_width = 4
        last_exp_page = ExperiencePage.objects.last()

        if last_exp_page is not None:
            current_path_index = int(last_exp_page.path[-exp_path_width:]) # Implicit assumptions
            path_prefix = last_exp_page.path[:-exp_path_width] # Implicit assumptions
        else:
            current_path_index = 0
            path_prefix = ExperienceIndexPage.objects.first().path # Use Index Page's path (Could potentially throw NoneType AttributeError)

        next_path_index = current_path_index + 1
        next_path_suffix = str(next_path_index).rjust(exp_path_width, '0') # padding with zeros for fixed width

        return "%s%s" % (path_prefix, next_path_suffix)


class ExperienceModelTest(WagtailPageTests, ExpPageFactoryMixin):

    fixtures = ['test.json']

    def test_can_create_exp_page_under_exp_index_page(self):
        self.assertCanCreateAt(ExperienceIndexPage, ExperiencePage)

    def test_can_create_exp_index_page_under_home_page(self):
        self.assertCanCreateAt(HomePage, ExperienceIndexPage)

    def test_creating_exp_page_also_create_booking_obj(self):
        num_bookings_before = len(Booking.objects.all())

        new_exp_page = self.make_experience_page()

        num_bookings_after = len(Booking.objects.all())
        self.assertEqual(num_bookings_after, num_bookings_before + 1)
        booking = Booking.objects.get(experience_page=new_exp_page)
        self.assertIsNotNone(booking)



class ExperiencePageViewTests(WagtailPageTests, ExpPageFactoryMixin):

    fixtures = ['test.json'] # load fixtures needed to mock create an experience page

    def setUp(self):
        self.client = Client()

    def test_uses_correct_template(self):
        exp_page = self.make_experience_page()
        self.assertTrue(exp_page.template.endswith('experience_page.html'))

    def test_can_navigate_to_page(self):
        exp_page = ExperiencePage.objects.first()
        site = exp_page.get_site()
        page_url = exp_page.relative_url(site)
        response = self.client.get(page_url)
        self.assertEqual(response.status_code, 200)

    def test_can_navigate_to_home(self):
        response = self.client.get('/')
        self.assertEqual(response.status_code, 200)

    def test_can_navigate_to_places(self):
        response = self.client.get('/places/')
        self.assertEqual(response.status_code, 200)

    def test_can_navigate_to_experiences(self):
        response = self.client.get('/experiences/')
        self.assertEqual(response.status_code, 200)

    def test_can_navigate_to_home(self):
        response = self.client.get('/')
        self.assertEqual(response.status_code, 200)

    def test_can_navigate_to_hosts(self):
        response = self.client.get('/hosts/')
        self.assertEqual(response.status_code, 200)
