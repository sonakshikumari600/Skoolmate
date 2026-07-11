from datetime import datetime
from sqlalchemy.orm import Session
from fastapi import HTTPException

from app.models.models import User, UserRole, parent_student
from app.schemas.schemas import UserUpdate, LinkStudentRequest


def get_user_by_id(db: Session, user_id: int) -> User:
    user = db.query(User).filter(User.id == user_id, User.is_active == True).first()
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    return user


def update_user(db: Session, user: User, data: UserUpdate) -> User:
    for field, value in data.model_dump(exclude_none=True).items():
        setattr(user, field, value)
    user.updated_at = datetime.utcnow()
    db.commit()
    db.refresh(user)
    return user


def list_students(db: Session) -> list[User]:
    return db.query(User).filter(
        User.role == UserRole.student, User.is_active == True
    ).all()


def list_teachers(db: Session) -> list[User]:
    return db.query(User).filter(
        User.role == UserRole.teacher, User.is_active == True
    ).all()


def link_student_to_parent(db: Session, parent: User, data: LinkStudentRequest) -> User:
    """
    Mirrors the linkStudentToParent Cloud Function.
    Finds a student by admission_no + verification_code, then links them.
    """
    if parent.role != UserRole.parent:
        raise HTTPException(status_code=403, detail="Only parents can link students")

    student = db.query(User).filter(
        User.admission_no == data.admission_no,
        User.verification_code == data.verification_code,
        User.role == UserRole.student,
        User.is_active == True,
    ).first()

    if not student:
        raise HTTPException(status_code=404, detail="Student not found or invalid verification code")

    # Duplicate prevention — mirrors Firestore batch duplicate check
    if student in parent.children:
        raise HTTPException(status_code=409, detail="Student already linked to this parent")

    parent.children.append(student)
    db.commit()
    return student


def unlink_student_from_parent(db: Session, parent: User, student_id: int) -> None:
    student = db.query(User).filter(User.id == student_id).first()
    if not student or student not in parent.children:
        raise HTTPException(status_code=404, detail="Linked student not found")
    parent.children.remove(student)
    db.commit()


def get_linked_students(db: Session, parent: User) -> list[User]:
    if parent.role != UserRole.parent:
        raise HTTPException(status_code=403, detail="Only parents have linked students")
    return parent.children


def deactivate_user(db: Session, user_id: int) -> None:
    user = get_user_by_id(db, user_id)
    user.is_active = False
    user.updated_at = datetime.utcnow()
    db.commit()
