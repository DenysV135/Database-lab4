from my_project import db

class ContentActors(db.Model):
    __tablename__ = 'content_actors'
    
    actors_id = db.Column(db.Integer, db.ForeignKey('actors.id'), primary_key=True)
    content_id = db.Column(db.Integer, db.ForeignKey('content.id'), primary_key=True)
    role_name = db.Column(db.String(45), nullable=False)

    actor = db.relationship('Actor', back_populates='contents')
    content = db.relationship('Content', back_populates='actors')