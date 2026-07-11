from sqlalchemy.orm import Session
from fastapi import HTTPException

from app.models.models import Homework, HomeworkSubmission, User, UserRole
from app.schemas.schemas import HomeworkCreate, HomeworkUpdate, SubmissionCreate, SubmissionGrade


def create_homework(db: Session, data: HomeworkCreate, teacher_id: int) -> Homework:
    hw = Homework(
        title=data.title,
        description=data.description,
        class_id=data.class_id,
        subject_id=data.subject_id,
        teacher_id=teacher_id,
        due_date=data.due_date,
    )
    db.add(hw)
    db.commit()
    db.refresh(hw)
    return hw


def update_homework(db: Session, homework_id: int, data: HomeworkUpdate, teacher_id: int) -> Homework:
    hw = db.query(Homework).filter(Homework.id == homework_id).first()
    if not hw:
        raise HTTPException(status_code=404, detail="Homework not found")
    if hw.teacher_id != teacher_id:
        raise HTTPException(status_code=403, detail="Not your homework assignment")
    for field, value in data.model_dump(exclude_none=True).items():
        setattr(hw, field, value)
    db.commit()
    db.refresh(hw)
    return hw


def get_class_homework(db: Session, class_id: int) -> list[Homework]:
    return (
        db.query(Homework)
        .filter(Homework.class_id == class_id, Homework.is_active == True)
        .order_by(Homework.due_date.asc())
        .all()
    )


def get_student_homework(db: Session, student: User) -> list[Homework]:
    """Returns homework for the student's class."""
    if not student.class_name:
        return []
    return (
        db.query(Homework)
        .filter(Homework.is_active == True)
        .join(Homework.class_)
        .filter_by(name=student.class_name, section=student.section)
        .order_by(Homework.due_date.asc())
        .all()
    )


def submit_homework(
    db: Session, homework_id: int, student_id: int, data: SubmissionCreate
) -> HomeworkSubmission:
    hw = db.query(Homework).filter(Homework.id == homework_id).first()
    if not hw:
        raise HTTPException(status_code=404, detail="Homework not found")

    existing = db.query(HomeworkSubmission).filter(
        HomeworkSubmission.homework_id == homework_id,
        HomeworkSubmission.student_id == student_id,
    ).first()
    if existing:
        existing.content = data.content
        existing.file_url = data.file_url
        db.commit()
        db.refresh(existing)
        return existing

    submission = HomeworkSubmission(
        homework_id=homework_id,
        student_id=student_id,
        content=data.content,
        file_url=data.file_url,
    )
    db.add(submission)
    db.commit()
    db.refresh(submission)
    return submission


def grade_submission(
    db: Session, submission_id: int, data: SubmissionGrade, teacher_id: int
) -> HomeworkSubmission:
    sub = db.query(HomeworkSubmission).filter(HomeworkSubmission.id == submission_id).first()
    if not sub:
        raise HTTPException(status_code=404, detail="Submission not found")
    sub.grade = data.grade
    sub.feedback = data.feedback
    db.commit()
    db.refresh(sub)
    return sub


def get_homework_submissions(db: Session, homework_id: int) -> list[HomeworkSubmission]:
    return db.query(HomeworkSubmission).filter(
        HomeworkSubmission.homework_id == homework_id
    ).all()
