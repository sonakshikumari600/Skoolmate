from sqlalchemy.orm import Session
from fastapi import HTTPException

from app.models.models import Class, Subject
from app.schemas.schemas import ClassCreate, SubjectCreate


def create_class(db: Session, data: ClassCreate) -> Class:
    cls = Class(**data.model_dump())
    db.add(cls)
    db.commit()
    db.refresh(cls)
    return cls


def get_all_classes(db: Session) -> list[Class]:
    return db.query(Class).order_by(Class.name).all()


def get_teacher_classes(db: Session, teacher_id: int) -> list[Class]:
    return db.query(Class).filter(Class.teacher_id == teacher_id).all()


def get_class_by_id(db: Session, class_id: int) -> Class:
    cls = db.query(Class).filter(Class.id == class_id).first()
    if not cls:
        raise HTTPException(status_code=404, detail="Class not found")
    return cls


def create_subject(db: Session, data: SubjectCreate) -> Subject:
    subject = Subject(**data.model_dump())
    db.add(subject)
    db.commit()
    db.refresh(subject)
    return subject


def get_class_subjects(db: Session, class_id: int) -> list[Subject]:
    return db.query(Subject).filter(Subject.class_id == class_id).all()
