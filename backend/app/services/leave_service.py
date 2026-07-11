from datetime import datetime
from sqlalchemy.orm import Session
from fastapi import HTTPException

from app.models.models import LeaveApplication, LeaveStatus
from app.schemas.schemas import LeaveCreate, LeaveStatusUpdate


def apply_leave(db: Session, student_id: int, data: LeaveCreate) -> LeaveApplication:
    leave = LeaveApplication(
        student_id=student_id,
        from_date=data.from_date,
        to_date=data.to_date,
        reason=data.reason,
        status=LeaveStatus.pending,
    )
    db.add(leave)
    db.commit()
    db.refresh(leave)
    return leave


def update_leave_status(
    db: Session, leave_id: int, data: LeaveStatusUpdate, reviewer_id: int
) -> LeaveApplication:
    leave = db.query(LeaveApplication).filter(LeaveApplication.id == leave_id).first()
    if not leave:
        raise HTTPException(status_code=404, detail="Leave application not found")
    if leave.status != LeaveStatus.pending:
        raise HTTPException(status_code=400, detail="Leave already reviewed")

    leave.status = LeaveStatus(data.status)
    leave.remarks = data.remarks
    leave.reviewed_by = reviewer_id
    leave.updated_at = datetime.utcnow()
    db.commit()
    db.refresh(leave)
    return leave


def get_student_leaves(db: Session, student_id: int) -> list[LeaveApplication]:
    return (
        db.query(LeaveApplication)
        .filter(LeaveApplication.student_id == student_id)
        .order_by(LeaveApplication.applied_at.desc())
        .all()
    )


def get_pending_leaves(db: Session) -> list[LeaveApplication]:
    return (
        db.query(LeaveApplication)
        .filter(LeaveApplication.status == LeaveStatus.pending)
        .order_by(LeaveApplication.applied_at.asc())
        .all()
    )
