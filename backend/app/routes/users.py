from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from app.database.session import get_db
from app.auth.jwt import get_current_user, require_role
from app.models.models import User
from app.schemas.schemas import UserOut, UserUpdate, LinkStudentRequest, LinkedStudentOut, MessageResponse
from app.services import user_service

router = APIRouter(prefix="/users", tags=["Users"])

# ── /me routes must come before /{user_id} to avoid path shadowing ────────────

@router.get("/me", response_model=UserOut)
def get_profile(current_user: User = Depends(get_current_user)):
    return current_user


@router.patch("/me", response_model=UserOut)
def update_profile(
    data: UserUpdate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    return user_service.update_user(db, current_user, data)


@router.get("/me/linked-students", response_model=list[LinkedStudentOut])
def get_linked_students(
    db: Session = Depends(get_db),
    current_user: User = Depends(require_role("parent")),
):
    return user_service.get_linked_students(db, current_user)


@router.post("/me/link-student", response_model=LinkedStudentOut)
def link_student(
    data: LinkStudentRequest,
    db: Session = Depends(get_db),
    current_user: User = Depends(require_role("parent")),
):
    return user_service.link_student_to_parent(db, current_user, data)


@router.delete("/me/linked-students/{student_id}", response_model=MessageResponse)
def unlink_student(
    student_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(require_role("parent")),
):
    user_service.unlink_student_from_parent(db, current_user, student_id)
    return {"success": True, "message": "Student unlinked"}


# ── Static list routes before /{user_id} ─────────────────────────────────────

@router.get("/students", response_model=list[UserOut])
def list_students(
    db: Session = Depends(get_db),
    _: User = Depends(require_role("admin", "teacher")),
):
    return user_service.list_students(db)


@router.get("/teachers", response_model=list[UserOut])
def list_teachers(
    db: Session = Depends(get_db),
    _: User = Depends(require_role("admin")),
):
    return user_service.list_teachers(db)


# ── Parameterised routes last ─────────────────────────────────────────────────

@router.get("/{user_id}", response_model=UserOut)
def get_user(
    user_id: int,
    db: Session = Depends(get_db),
    _: User = Depends(require_role("admin", "teacher")),
):
    return user_service.get_user_by_id(db, user_id)


@router.delete("/{user_id}", response_model=MessageResponse)
def deactivate_user(
    user_id: int,
    db: Session = Depends(get_db),
    _: User = Depends(require_role("admin")),
):
    user_service.deactivate_user(db, user_id)
    return {"success": True, "message": "User deactivated"}
