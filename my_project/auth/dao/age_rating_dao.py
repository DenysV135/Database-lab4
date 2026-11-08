from my_project.auth.dao.general_dao import GeneralDAO
from my_project.auth.domain.age_rating import AgeRating

class AgeRatingDAO(GeneralDAO):
    def __init__(self):
        super().__init__(AgeRating)