from datetime import date
from fastapi import APIRouter, Depends, Query
from sqlalchemy.orm import Session

from app.database.session import get_db
from app.auth.jwt import get_current_user, require_role
from app.models.models import User
from app.schemas.schemas import AttendanceCreate, AttendanceBulkCreate, AttendanceOut
from app.services import attendance_service

router = APIRouter(prefix="/attendance", tags=["Attendance"])


@router.post("/", response_model=AttendanceOut, status_code=201)
def mark_attendance(
    data: AttendanceCreate,
    db: Session = Depends(get_db),
    current_user: User = Depends(require_role("admin", "teacher")),
):
    return attendance_service.add_attendance(db, data, current_user.id)


@router.post("/bulk", response_model=list[AttendanceOut], status_code=201)
def mark_bulk_attendance(
    data: AttendanceBulkCreate,
    db: Session = Depends(get_db),
    current_user: User = Depends(require_role("admin", "teacher")),
):
    return attendance_service.add_bulk_attendance(db, data, current_user.id)


@router.get("/student/{student_id}", response_model=list[AttendanceOut])
def get_student_attendance(
    student_id: int,
    limit: int = Query(100, le=500),
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    return attendance_service.get_student_attendance(db, student_id, limit)


@router.get("/class/{class_id}", response_model=list[AttendanceOut])
def get_class_attendance(
    class_id: int,
    date: date = Query(...),
    db: Session = Depends(get_db),
    _: User = Depends(require_role("admin", "teacher")),
):
    return attendance_service.get_class_attendance(db, class_id, date)
