from flask import Blueprint
from my_project.auth.controller.user_review_controller import UserReviewController

user_review_bp = Blueprint('user_review', __name__, url_prefix='/api/user-reviews')
user_review_controller = UserReviewController()

@user_review_bp.route('', methods=['GET'])
def get_all(): return user_review_controller.find_all()

@user_review_bp.route('/<int:item_id>', methods=['GET'])
def get_by_id(item_id): return user_review_controller.find_by_id(item_id)

@user_review_bp.route('', methods=['POST'])
def create(): return user_review_controller.create()

@user_review_bp.route('/<int:item_id>', methods=['PUT'])
def update(item_id): return user_review_controller.update(item_id)

@user_review_bp.route('/<int:item_id>', methods=['DELETE'])
def delete(item_id): return user_review_controller.delete(item_id)