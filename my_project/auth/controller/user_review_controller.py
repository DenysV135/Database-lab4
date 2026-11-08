from my_project.auth.controller.general_controller import GeneralController
from my_project.auth.service.user_review_service import UserReviewService
from my_project.auth.domain.user_review import UserReview

class UserReviewController(GeneralController):
    def __init__(self):
        super().__init__(UserReviewService(), UserReview)