from flask import Blueprint
from my_project.auth.controller.actor_controller import ActorController

actor_bp = Blueprint('actor', __name__, url_prefix='/api/actors')
actor_controller = ActorController()

@actor_bp.route('', methods=['GET'])
def get_all():
    return actor_controller.find_all()

@actor_bp.route('/<int:item_id>', methods=['GET'])
def get_by_id(item_id):
    return actor_controller.find_by_id(item_id)

@actor_bp.route('', methods=['POST'])
def create():
    return actor_controller.create()

@actor_bp.route('/<int:item_id>', methods=['PUT'])
def update(item_id):
    return actor_controller.update(item_id)

@actor_bp.route('/<int:item_id>', methods=['DELETE'])
def delete(item_id):
    return actor_controller.delete(item_id)

@actor_bp.route('/<int:item_id>/content', methods=['GET'])
def get_actor_content(item_id):
    return actor_controller.get_content_for_actor(item_id)