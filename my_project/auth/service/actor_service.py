from my_project.auth.service.general_service import GeneralService
from my_project.auth.dao.actor_dao import ActorDAO

class ActorService(GeneralService):
    def __init__(self):
        super().__init__(ActorDAO())