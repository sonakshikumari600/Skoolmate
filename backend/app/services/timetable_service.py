from sqlalchemy.orm import Session
from fastapi import HTTPException

from app.models.models import Timetable
from app.schemas.schemas import TimetableCreate

DAYS = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"}


def create_timetable_entry(db: Session, data: TimetableCreate) -> Timetable:
    if data.day_of_week not in DAYS:
        raise HTTPException(status_code=400, detail=f"day_of_week must be one of {DAYS}")
    entry = Timetable(**data.model_dump())
    db.add(entry)
    db.commit()
    db.refresh(entry)
    return entry


def get_class_timetable(db: Session, class_id: int) -> list[Timetable]:
    return (
        db.query(Timetable)
        .filter(Timetable.class_id == class_id)
        .order_by(Timetable.day_of_week, Timetable.start_time)
        .all()
    )


def get_teacher_timetable(db: Session, teacher_id: int) -> list[Timetable]:
    return (
        db.query(Timetable)
        .filter(Timetable.teacher_id == teacher_id)
        .order_by(Timetable.day_of_week, Timetable.start_time)
        .all()
    )


def delete_timetable_entry(db: Session, entry_id: int) -> None:
    entry = db.query(Timetable).filter(Timetable.id == entry_id).first()
    if not entry:
        raise HTTPException(status_code=404, detail="Timetable entry not found")
    db.delete(entry)
    db.commit()
