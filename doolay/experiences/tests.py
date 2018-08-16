
from wagtail.tests.utils import WagtailPageTests
from doolay.home.models import HomePage
from doolay.experiences.models import ExperiencePage, ExperienceIndexPage


class BookingModelTest(WagtailPageTests):


    def test_can_create_exp_page_under_exp_index_page(self):
        self.assertCanCreateAt(ExperienceIndexPage, ExperiencePage)

    def test_can_create_exp_index_page_under_home_page(self):
        self.assertCanCreateAt(HomePage, ExperienceIndexPage)