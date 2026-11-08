from my_project import db

class GeneralDAO:
    def __init__(self, model):
        self.model = model

    def find_all(self):
        return db.session.query(self.model).all()

    def find_by_id(self, item_id):
        return db.session.query(self.model).get(item_id)

    def create(self, item):
        db.session.add(item)
        db.session.commit()
        return item

    def update(self, item_id, item_data):
        item = self.find_by_id(item_id)
        if item:
            for key, value in item_data.items():
                setattr(item, key, value)
            db.session.commit()
        return item

    def delete(self, item_id):
        item = self.find_by_id(item_id)
        if item:
            db.session.delete(item)
            db.session.commit()
            return True
        return False