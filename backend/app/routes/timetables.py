from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from app.database.session import get_db
from app.auth.jwt import get_current_user, require_role
from app.models.models import User
from app.schemas.schemas import TimetableCreate, TimetableOut, MessageResponse
from app.services import timetable_service

router = APIRouter(prefix="/timetables", tags=["Timetables"])


@router.post("/", response_model=TimetableOut, status_code=201)
def create_entry(
    data: TimetableCreate,
    db: Session = Depends(get_db),
    _: User = Depends(require_role("admin")),
):
    return timetable_service.create_timetable_entry(db, data)


@router.get("/class/{class_id}", response_model=list[TimetableOut])
def get_class_timetable(
    class_id: int,
    db: Session = Depends(get_db),
    _: User = Depends(get_current_user),
):
    return timetable_service.get_class_timetable(db, class_id)


@router.get("/my", response_model=list[TimetableOut])
def get_my_timetable(
    db: Session = Depends(get_db),
    current_user: User = Depends(require_role("teacher")),
):
    return timetable_service.get_teacher_timetable(db, current_user.id)


@router.get("/teacher/{teacher_id}", response_model=list[TimetableOut])
def get_teacher_timetable(
    teacher_id: int,
    db: Session = Depends(get_db),
    _: User = Depends(require_role("admin")),
):
    return timetable_service.get_teacher_timetable(db, teacher_id)


@router.delete("/{entry_id}", response_model=MessageResponse)
def delete_entry(
    entry_id: int,
    db: Session = Depends(get_db),
    _: User = Depends(require_role("admin")),
):
    timetable_service.delete_timetable_entry(db, entry_id)
    return {"success": True, "message": "Timetable entry deleted"}
