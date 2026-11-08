from my_project.auth.service.general_service import GeneralService
from my_project.auth.dao.age_rating_dao import AgeRatingDAO

class AgeRatingService(GeneralService):
    def __init__(self):
        super().__init__(AgeRatingDAO())