from my_project import db
from my_project.auth.domain.content_actors import ContentActors

class Actor(db.Model):
    __tablename__ = 'actors'
    
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    name = db.Column(db.String(45), nullable=False)
    birthday = db.Column(db.Date, nullable=False)

    contents = db.relationship('ContentActors', back_populates='actor', cascade="all, delete-orphan")

    @staticmethod
    def put_into_dto(item):
        return {
            "id": item.id,
            "name": item.name,
            "birthday": str(item.birthday) if item.birthday else None
        }

    @staticmethod
    def put_into_entity(data):
        return Actor(
            name=data.get('name'),
            birthday=data.get('birthday')
        )