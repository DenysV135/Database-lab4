from my_project.auth.dao.general_dao import GeneralDAO
from my_project.auth.domain.subscription import Subscription

class SubscriptionDAO(GeneralDAO):
    def __init__(self):
        super().__init__(Subscription)