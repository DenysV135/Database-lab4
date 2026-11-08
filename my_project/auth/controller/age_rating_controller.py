from my_project.auth.controller.general_controller import GeneralController
from my_project.auth.service.age_rating_service import AgeRatingService
from my_project.auth.domain.age_rating import AgeRating

class AgeRatingController(GeneralController):
    def __init__(self):
        super().__init__(AgeRatingService(), AgeRating)