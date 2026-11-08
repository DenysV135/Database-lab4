from my_project.auth.dao.general_dao import GeneralDAO
from my_project.auth.domain.genre import Genre

class GenreDAO(GeneralDAO):
    def __init__(self):
        super().__init__(Genre)