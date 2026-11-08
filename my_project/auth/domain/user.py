from my_project import db

class User(db.Model):
    __tablename__ = 'user'
    
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    username = db.Column(db.String(16), nullable=False, unique=True)
    email = db.Column(db.String(255), unique=True, nullable=True)
    password = db.Column(db.String(255), nullable=False)
    phone = db.Column(db.String(45), nullable=False)
    # Зовнішній ключ на таблицю підписок
    subscription_id = db.Column(db.Integer, db.ForeignKey('subscription.id'), nullable=False)

    @staticmethod
    def put_into_dto(item):
        return {
            "id": item.id,
            "username": item.username,
            "email": item.email,
            "phone": item.phone,
            "subscription_id": item.subscription_id
        }

    @staticmethod
    def put_into_entity(data):
        return User(
            username=data.get('username'),
            email=data.get('email'),
            password=data.get('password'),
            phone=data.get('phone'),
            subscription_id=data.get('subscription_id')
        )