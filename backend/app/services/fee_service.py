from datetime import datetime
from sqlalchemy.orm import Session
from fastapi import HTTPException

from app.models.models import Fee
from app.schemas.schemas import FeeCreate, FeePayment


def create_fee(db: Session, data: FeeCreate) -> Fee:
    fee = Fee(
        student_id=data.student_id,
        amount=data.amount,
        description=data.description,
        due_date=data.due_date,
    )
    db.add(fee)
    db.commit()
    db.refresh(fee)
    return fee


def get_student_fees(db: Session, student_id: int) -> list[Fee]:
    return (
        db.query(Fee)
        .filter(Fee.student_id == student_id)
        .order_by(Fee.due_date.asc())
        .all()
    )


def mark_fee_paid(db: Session, fee_id: int, data: FeePayment) -> Fee:
    fee = db.query(Fee).filter(Fee.id == fee_id).first()
    if not fee:
        raise HTTPException(status_code=404, detail="Fee record not found")
    if fee.is_paid:
        raise HTTPException(status_code=400, detail="Fee already marked as paid")
    fee.is_paid = True
    fee.paid_at = datetime.utcnow()
    fee.payment_reference = data.payment_reference
    db.commit()
    db.refresh(fee)
    return fee


def get_all_fees(db: Session, unpaid_only: bool = False) -> list[Fee]:
    q = db.query(Fee)
    if unpaid_only:
        q = q.filter(Fee.is_paid == False)
    return q.order_by(Fee.due_date.asc()).all()
