from flask import Blueprint
from my_project.auth.controller.genre_controller import GenreController

genre_bp = Blueprint('genre', __name__, url_prefix='/api/genres')
genre_controller = GenreController()

@genre_bp.route('', methods=['GET'])
def get_all(): return genre_controller.find_all()

@genre_bp.route('/<int:item_id>', methods=['GET'])
def get_by_id(item_id): return genre_controller.find_by_id(item_id)

@genre_bp.route('', methods=['POST'])
def create(): return genre_controller.create()

@genre_bp.route('/<int:item_id>', methods=['PUT'])
def update(item_id): return genre_controller.update(item_id)

@genre_bp.route('/<int:item_id>', methods=['DELETE'])
def delete(item_id): return genre_controller.delete(item_id)