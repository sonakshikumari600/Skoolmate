from fastapi import APIRouter, Depends, Query
from sqlalchemy.orm import Session
from typing import Optional

from app.database.session import get_db
from app.auth.jwt import get_current_user, require_role
from app.models.models import User
from app.schemas.schemas import ResultCreate, ResultOut, MessageResponse
from app.services import exam_service

router = APIRouter(prefix="/results", tags=["Exams & Results"])


@router.post("/", response_model=ResultOut, status_code=201)
def add_result(
    data: ResultCreate,
    db: Session = Depends(get_db),
    _: User = Depends(require_role("admin", "teacher")),
):
    return exam_service.add_result(db, data)


@router.get("/student/{student_id}", response_model=list[ResultOut])
def get_student_results(
    student_id: int,
    db: Session = Depends(get_db),
    _: User = Depends(get_current_user),
):
    return exam_service.get_student_results(db, student_id)


@router.get("/my", response_model=list[ResultOut])
def get_my_results(
    db: Session = Depends(get_db),
    current_user: User = Depends(require_role("student")),
):
    return exam_service.get_student_results(db, current_user.id)


@router.get("/class/{class_id}", response_model=list[ResultOut])
def get_class_results(
    class_id: int,
    exam_name: Optional[str] = Query(None),
    db: Session = Depends(get_db),
    _: User = Depends(require_role("admin", "teacher")),
):
    return exam_service.get_class_results(db, class_id, exam_name)


@router.delete("/{result_id}", response_model=MessageResponse)
def delete_result(
    result_id: int,
    db: Session = Depends(get_db),
    _: User = Depends(require_role("admin")),
):
    exam_service.delete_result(db, result_id)
    return {"success": True, "message": "Result deleted"}
