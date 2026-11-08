from flask import Blueprint
from my_project.auth.controller.subscription_controller import SubscriptionController

# Створюємо Blueprint (групу маршрутів) для підписок
subscription_bp = Blueprint('subscription', __name__, url_prefix='/api/subscriptions')
subscription_controller = SubscriptionController()

# Стандартні CRUD операції
@subscription_bp.route('', methods=['GET'])
def get_all():
    return subscription_controller.find_all()

@subscription_bp.route('/<int:item_id>', methods=['GET'])
def get_by_id(item_id):
    return subscription_controller.find_by_id(item_id)

@subscription_bp.route('', methods=['POST'])
def create():
    return subscription_controller.create()

@subscription_bp.route('/<int:item_id>', methods=['PUT'])
def update(item_id):
    return subscription_controller.update(item_id)

@subscription_bp.route('/<int:item_id>', methods=['DELETE'])
def delete(item_id):
    return subscription_controller.delete(item_id)

# Спеціальний маршрут для зв'язку 1:M
@subscription_bp.route('/<int:item_id>/users', methods=['GET'])
def get_users(item_id):
    return subscription_controller.get_users_by_subscription(item_id)