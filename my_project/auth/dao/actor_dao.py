from my_project.auth.dao.general_dao import GeneralDAO
from my_project.auth.domain.actor import Actor

class ActorDAO(GeneralDAO):
    def __init__(self):
        super().__init__(Actor)