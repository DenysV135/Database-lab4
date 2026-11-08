from flask import jsonify, request, abort

class GeneralController:
    def __init__(self, service, mapper):
        self.service = service
        self.mapper = mapper

    def find_all(self):
        items = self.service.find_all()
        return jsonify([self.mapper.put_into_dto(item) for item in items]), 200

    def find_by_id(self, item_id):
        item = self.service.find_by_id(item_id)
        if item:
            return jsonify(self.mapper.put_into_dto(item)), 200
        abort(404, description="Запис не знайдено")

    def create(self):
        data = request.get_json()
        if not data:
            abort(400, description="Неправильний формат даних (очікується JSON)")
        
        item = self.mapper.put_into_entity(data)
        created_item = self.service.create(item)
        return jsonify(self.mapper.put_into_dto(created_item)), 201

    def update(self, item_id):
        data = request.get_json()
        if not data:
            abort(400, description="Неправильний формат даних (очікується JSON)")
            
        updated_item = self.service.update(item_id, data)
        if updated_item:
            return jsonify(self.mapper.put_into_dto(updated_item)), 200
        abort(404, description="Запис не знайдено для оновлення")

    def delete(self, item_id):
        success = self.service.delete(item_id)
        if success:
            return '', 204
        abort(404, description="Запис не знайдено для видалення")