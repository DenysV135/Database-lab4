from flask import jsonify, abort
from my_project.auth.controller.general_controller import GeneralController
from my_project.auth.service.subscription_service import SubscriptionService
from my_project.auth.domain.subscription import Subscription
from my_project.auth.domain.user import User

class SubscriptionController(GeneralController):
    def __init__(self):
        super().__init__(SubscriptionService(), Subscription)

    # Реалізація зв'язку 1:M - отримання користувачів за ID підписки
    def get_users_by_subscription(self, sub_id):
        sub = self.service.find_by_id(sub_id)
        if not sub:
            abort(404, description="Підписку не знайдено")
        
        # Перетворюємо кожного знайденого користувача у формат DTO
        users_dto = [User.put_into_dto(user) for user in sub.users]
        return jsonify(users_dto), 200