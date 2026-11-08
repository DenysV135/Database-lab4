from my_project import db

class Genre(db.Model):
    __tablename__ = 'genres'
    
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    name = db.Column(db.String(45), nullable=False)
    description = db.Column(db.Text, nullable=True)
    content_id = db.Column(db.Integer, db.ForeignKey('content.id'), nullable=False)

    @staticmethod
    def put_into_dto(item):
        return {
            "id": item.id,
            "name": item.name,
            "description": item.description,
            "content_id": item.content_id
        }

    @staticmethod
    def put_into_entity(data):
        return Genre(
            name=data.get('name'),
            description=data.get('description'),
            content_id=data.get('content_id')
        )