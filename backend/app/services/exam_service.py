from sqlalchemy.orm import Session
from fastapi import HTTPException

from app.models.models import Result
from app.schemas.schemas import ResultCreate


def add_result(db: Session, data: ResultCreate) -> Result:
    # Upsert: one result per student+subject+exam_name
    existing = db.query(Result).filter(
        Result.student_id == data.student_id,
        Result.subject_id == data.subject_id,
        Result.exam_name == data.exam_name,
    ).first()
    if existing:
        existing.marks_obtained = data.marks_obtained
        existing.total_marks = data.total_marks
        existing.grade = data.grade
        existing.exam_date = data.exam_date
        db.commit()
        db.refresh(existing)
        return existing

    result = Result(**data.model_dump())
    db.add(result)
    db.commit()
    db.refresh(result)
    return result


def get_student_results(db: Session, student_id: int) -> list[Result]:
    return (
        db.query(Result)
        .filter(Result.student_id == student_id)
        .order_by(Result.exam_date.desc())
        .all()
    )


def get_class_results(db: Session, class_id: int, exam_name: str | None = None) -> list[Result]:
    from app.models.models import Subject
    q = (
        db.query(Result)
        .join(Subject, Result.subject_id == Subject.id)
        .filter(Subject.class_id == class_id)
    )
    if exam_name:
        q = q.filter(Result.exam_name == exam_name)
    return q.all()


def delete_result(db: Session, result_id: int) -> None:
    result = db.query(Result).filter(Result.id == result_id).first()
    if not result:
        raise HTTPException(status_code=404, detail="Result not found")
    db.delete(result)
    db.commit()
