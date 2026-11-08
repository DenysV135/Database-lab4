from flask import Blueprint
from my_project.auth.controller.age_rating_controller import AgeRatingController

age_rating_bp = Blueprint('age_rating', __name__, url_prefix='/api/age-ratings')
age_rating_controller = AgeRatingController()

@age_rating_bp.route('', methods=['GET'])
def get_all():
    return age_rating_controller.find_all()

@age_rating_bp.route('/<int:item_id>', methods=['GET'])
def get_by_id(item_id):
    return age_rating_controller.find_by_id(item_id)

@age_rating_bp.route('', methods=['POST'])
def create():
    return age_rating_controller.create()

@age_rating_bp.route('/<int:item_id>', methods=['PUT'])
def update(item_id):
    return age_rating_controller.update(item_id)

@age_rating_bp.route('/<int:item_id>', methods=['DELETE'])
def delete(item_id):
    return age_rating_controller.delete(item_id)