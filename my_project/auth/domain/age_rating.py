from my_project import db

class AgeRating(db.Model):
    __tablename__ = 'age_ratings'
    
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    name = db.Column(db.String(45), nullable=False)
    description = db.Column(db.Text, nullable=False)

    # Зв'язок 1:M до таблиці Content
    contents = db.relationship('Content', backref='age_rating', lazy='dynamic')

    @staticmethod
    def put_into_dto(item):
        return {
            "id": item.id,
            "name": item.name,
            "description": item.description
        }

    @staticmethod
    def put_into_entity(data):
        return AgeRating(
            name=data.get('name'),
            description=data.get('description')
        )