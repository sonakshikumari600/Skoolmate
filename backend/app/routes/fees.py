from fastapi import APIRouter, Depends, Query
from sqlalchemy.orm import Session

from app.database.session import get_db
from app.auth.jwt import get_current_user, require_role
from app.models.models import User
from app.schemas.schemas import FeeCreate, FeePayment, FeeOut
from app.services import fee_service

router = APIRouter(prefix="/fees", tags=["Fees"])


@router.post("/", response_model=FeeOut, status_code=201)
def create_fee(
    data: FeeCreate,
    db: Session = Depends(get_db),
    _: User = Depends(require_role("admin")),
):
    return fee_service.create_fee(db, data)


@router.get("/my", response_model=list[FeeOut])
def get_my_fees(
    db: Session = Depends(get_db),
    current_user: User = Depends(require_role("student")),
):
    return fee_service.get_student_fees(db, current_user.id)


@router.get("/student/{student_id}", response_model=list[FeeOut])
def get_student_fees(
    student_id: int,
    db: Session = Depends(get_db),
    _: User = Depends(require_role("admin", "teacher")),
):
    return fee_service.get_student_fees(db, student_id)


@router.get("/", response_model=list[FeeOut])
def list_all_fees(
    unpaid_only: bool = Query(False),
    db: Session = Depends(get_db),
    _: User = Depends(require_role("admin")),
):
    return fee_service.get_all_fees(db, unpaid_only)


@router.patch("/{fee_id}/pay", response_model=FeeOut)
def mark_fee_paid(
    fee_id: int,
    data: FeePayment,
    db: Session = Depends(get_db),
    _: User = Depends(require_role("admin")),
):
    return fee_service.mark_fee_paid(db, fee_id, data)
