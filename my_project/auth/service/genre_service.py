from my_project.auth.service.general_service import GeneralService
from my_project.auth.dao.genre_dao import GenreDAO

class GenreService(GeneralService):
    def __init__(self):
        super().__init__(GenreDAO())