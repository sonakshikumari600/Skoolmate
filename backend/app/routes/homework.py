from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from app.database.session import get_db
from app.auth.jwt import get_current_user, require_role
from app.models.models import User
from app.schemas.schemas import (
    HomeworkCreate, HomeworkUpdate, HomeworkOut,
    SubmissionCreate, SubmissionOut, SubmissionGrade,
)
from app.services import homework_service

router = APIRouter(prefix="/homework", tags=["Homework"])


@router.post("/", response_model=HomeworkOut, status_code=201)
def create_homework(
    data: HomeworkCreate,
    db: Session = Depends(get_db),
    current_user: User = Depends(require_role("admin", "teacher")),
):
    return homework_service.create_homework(db, data, current_user.id)


@router.patch("/{homework_id}", response_model=HomeworkOut)
def update_homework(
    homework_id: int,
    data: HomeworkUpdate,
    db: Session = Depends(get_db),
    current_user: User = Depends(require_role("admin", "teacher")),
):
    return homework_service.update_homework(db, homework_id, data, current_user.id)


@router.get("/class/{class_id}", response_model=list[HomeworkOut])
def get_class_homework(
    class_id: int,
    db: Session = Depends(get_db),
    _: User = Depends(get_current_user),
):
    return homework_service.get_class_homework(db, class_id)


@router.get("/my", response_model=list[HomeworkOut])
def get_my_homework(
    db: Session = Depends(get_db),
    current_user: User = Depends(require_role("student")),
):
    return homework_service.get_student_homework(db, current_user)


@router.post("/{homework_id}/submit", response_model=SubmissionOut, status_code=201)
def submit_homework(
    homework_id: int,
    data: SubmissionCreate,
    db: Session = Depends(get_db),
    current_user: User = Depends(require_role("student")),
):
    return homework_service.submit_homework(db, homework_id, current_user.id, data)


@router.get("/{homework_id}/submissions", response_model=list[SubmissionOut])
def get_submissions(
    homework_id: int,
    db: Session = Depends(get_db),
    _: User = Depends(require_role("admin", "teacher")),
):
    return homework_service.get_homework_submissions(db, homework_id)


@router.patch("/submissions/{submission_id}/grade", response_model=SubmissionOut)
def grade_submission(
    submission_id: int,
    data: SubmissionGrade,
    db: Session = Depends(get_db),
    current_user: User = Depends(require_role("admin", "teacher")),
):
    return homework_service.grade_submission(db, submission_id, data, current_user.id)
