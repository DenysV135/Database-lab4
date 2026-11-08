from flask import jsonify, abort
from my_project.auth.controller.general_controller import GeneralController
from my_project.auth.service.actor_service import ActorService
from my_project.auth.domain.actor import Actor
from my_project.auth.domain.content import Content

class ActorController(GeneralController):
    def __init__(self):
        super().__init__(ActorService(), Actor)

    def get_content_for_actor(self, actor_id):
        actor = self.service.find_by_id(actor_id)
        if not actor:
            abort(404, description="Актора не знайдено")
        
        result = []
        for content_actor_link in actor.contents:
            content_dto = Content.put_into_dto(content_actor_link.content)
            content_dto['role_name'] = content_actor_link.role_name
            result.append(content_dto)
            
        return jsonify(result), 200