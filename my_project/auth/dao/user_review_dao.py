from my_project.auth.dao.general_dao import GeneralDAO
from my_project.auth.domain.user_review import UserReview

class UserReviewDAO(GeneralDAO):
    def __init__(self):
        super().__init__(UserReview)