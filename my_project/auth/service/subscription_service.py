from my_project.auth.service.general_service import GeneralService
from my_project.auth.dao.subscription_dao import SubscriptionDAO

class SubscriptionService(GeneralService):
    def __init__(self):
        super().__init__(SubscriptionDAO())