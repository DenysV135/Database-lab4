from my_project import db

class Subscription(db.Model):
    __tablename__ = 'subscription'
    
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    name = db.Column(db.String(45), nullable=False)
    description = db.Column(db.Text, nullable=True)

    # Зв'язок 1:M з таблицею User. 
    # lazy='dynamic' дозволяє робити запити до пов'язаних користувачів.
    users = db.relationship('User', backref='subscription', lazy='dynamic')

    @staticmethod
    def put_into_dto(item):
        return {
            "id": item.id,
            "name": item.name,
            "description": item.description
        }

    @staticmethod
    def put_into_entity(data):
        return Subscription(
            name=data.get('name'),
            description=data.get('description')
        )