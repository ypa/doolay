
from wagtail.tests.utils import WagtailPageTests
from doolay.home.models import HomePage
from doolay.experiences.models import ExperiencePage, ExperienceIndexPage
from model_mommy.recipe import Recipe, foreign_key
from doolay.places.models import PlacePage
from doolay.hosts.models import HostPage
from doolay.bookings.models import Booking


class ExperienceModelTest(WagtailPageTests):
    fixtures = ['unittest_data.json']
    exp_page_counter = 1 # there's already one exp page created by fixtures

    def setUp(self):
        host = HostPage.objects.first()
        place = PlacePage.objects.first()
        exp_list = ExperienceIndexPage.objects.first()
        self.exp_page_counter += 1
        self.exp_page = Recipe(
            ExperiencePage,
            host=host,
            place=place,
            path='%s000%s' % (exp_list.path, self.exp_page_counter),
            depth=4,
            url_path="/home/experiences/exp_page_%s" % (self.exp_page_counter,)
        )

    def test_can_create_exp_page_under_exp_index_page(self):
        self.assertCanCreateAt(ExperienceIndexPage, ExperiencePage)

    def test_can_create_exp_index_page_under_home_page(self):
        self.assertCanCreateAt(HomePage, ExperienceIndexPage)

    def test_creating_exp_page_also_create_booking_obj(self):
        num_bookings_before = len(Booking.objects.all())

        new_exp_page = self.exp_page.make()

        num_bookings_after = len(Booking.objects.all())
        self.assertEqual(num_bookings_after, num_bookings_before + 1)
        booking = Booking.objects.get(experience_page=new_exp_page)
        self.assertIsNotNone(booking)
