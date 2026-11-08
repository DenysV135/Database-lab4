from my_project import db

class UserReview(db.Model):
    __tablename__ = 'user_review'
    
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    rating = db.Column(db.Integer, nullable=False)
    text = db.Column(db.Text, nullable=True)
    
    # Два зовнішні ключі (хто залишив і на який фільм)
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)
    content_id = db.Column(db.Integer, db.ForeignKey('content.id'), nullable=False)

    @staticmethod
    def put_into_dto(item):
        return {
            "id": item.id,
            "rating": item.rating,
            "text": item.text,
            "user_id": item.user_id,
            "content_id": item.content_id
        }

    @staticmethod
    def put_into_entity(data):
        return UserReview(
            rating=data.get('rating'),
            text=data.get('text'),
            user_id=data.get('user_id'),
            content_id=data.get('content_id')
        )