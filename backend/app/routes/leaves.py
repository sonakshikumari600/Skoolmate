from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from app.database.session import get_db
from app.auth.jwt import get_current_user, require_role
from app.models.models import User
from app.schemas.schemas import LeaveCreate, LeaveStatusUpdate, LeaveOut
from app.services import leave_service

router = APIRouter(prefix="/leaves", tags=["Leaves"])


@router.post("/", response_model=LeaveOut, status_code=201)
def apply_leave(
    data: LeaveCreate,
    db: Session = Depends(get_db),
    current_user: User = Depends(require_role("student")),
):
    return leave_service.apply_leave(db, current_user.id, data)


@router.get("/my", response_model=list[LeaveOut])
def get_my_leaves(
    db: Session = Depends(get_db),
    current_user: User = Depends(require_role("student")),
):
    return leave_service.get_student_leaves(db, current_user.id)


@router.get("/student/{student_id}", response_model=list[LeaveOut])
def get_student_leaves(
    student_id: int,
    db: Session = Depends(get_db),
    _: User = Depends(require_role("admin", "teacher")),
):
    return leave_service.get_student_leaves(db, student_id)


@router.get("/pending", response_model=list[LeaveOut])
def get_pending_leaves(
    db: Session = Depends(get_db),
    _: User = Depends(require_role("admin", "teacher")),
):
    return leave_service.get_pending_leaves(db)


@router.patch("/{leave_id}/status", response_model=LeaveOut)
def update_leave_status(
    leave_id: int,
    data: LeaveStatusUpdate,
    db: Session = Depends(get_db),
    current_user: User = Depends(require_role("admin", "teacher")),
):
    return leave_service.update_leave_status(db, leave_id, data, current_user.id)
