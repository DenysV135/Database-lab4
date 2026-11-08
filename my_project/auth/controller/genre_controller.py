from my_project.auth.controller.general_controller import GeneralController
from my_project.auth.service.genre_service import GenreService
from my_project.auth.domain.genre import Genre

class GenreController(GeneralController):
    def __init__(self):
        super().__init__(GenreService(), Genre)