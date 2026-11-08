class GeneralService:
    def __init__(self, dao):
        self.dao = dao

    def find_all(self):
        return self.dao.find_all()

    def find_by_id(self, item_id):
        return self.dao.find_by_id(item_id)

    def create(self, item):
        return self.dao.create(item)

    def update(self, item_id, item_data):
        return self.dao.update(item_id, item_data)

    def delete(self, item_id):
        return self.dao.delete(item_id)