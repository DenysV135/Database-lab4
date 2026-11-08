from my_project import db
from my_project.auth.domain.content_actors import ContentActors

class Content(db.Model):
    __tablename__ = 'content'
    
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    description = db.Column(db.Text, nullable=False)
    release_year = db.Column(db.Integer, nullable=False)
    title = db.Column(db.String(45), nullable=False)
    age_ratings_id = db.Column(db.Integer, db.ForeignKey('age_ratings.id'), nullable=False)

    actors = db.relationship('ContentActors', back_populates='content', cascade="all, delete-orphan")

    @staticmethod
    def put_into_dto(item):
        return {
            "id": item.id,
            "title": item.title,
            "description": item.description,
            "release_year": item.release_year,
            "age_ratings_id": item.age_ratings_id
        }

    @staticmethod
    def put_into_entity(data):
        return Content(
            description=data.get('description'),
            release_year=data.get('release_year'),
            title=data.get('title'),
            age_ratings_id=data.get('age_ratings_id')
        )