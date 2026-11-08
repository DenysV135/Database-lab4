from my_project.auth.service.general_service import GeneralService
from my_project.auth.dao.user_review_dao import UserReviewDAO

class UserReviewService(GeneralService):
    def __init__(self):
        super().__init__(UserReviewDAO())