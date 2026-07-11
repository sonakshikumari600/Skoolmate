from datetime import date
from sqlalchemy.orm import Session
from fastapi import HTTPException

from app.models.models import Attendance, AttendanceStatus, User, UserRole
from app.schemas.schemas import AttendanceCreate, AttendanceBulkCreate


def add_attendance(db: Session, data: AttendanceCreate, marked_by_id: int) -> Attendance:
    record = Attendance(
        student_id=data.student_id,
        class_id=data.class_id,
        date=data.date,
        status=AttendanceStatus(data.status),
        marked_by=marked_by_id,
        remarks=data.remarks,
    )
    db.add(record)
    db.commit()
    db.refresh(record)
    return record


def add_bulk_attendance(
    db: Session, data: AttendanceBulkCreate, marked_by_id: int
) -> list[Attendance]:
    records = []
    for item in data.records:
        # Upsert: update if record for same student+class+date exists
        existing = db.query(Attendance).filter(
            Attendance.student_id == item.student_id,
            Attendance.class_id == data.class_id,
            Attendance.date == data.date,
        ).first()
        if existing:
            existing.status = AttendanceStatus(item.status)
            existing.remarks = item.remarks
            existing.marked_by = marked_by_id
            records.append(existing)
        else:
            record = Attendance(
                student_id=item.student_id,
                class_id=data.class_id,
                date=data.date,
                status=AttendanceStatus(item.status),
                marked_by=marked_by_id,
                remarks=item.remarks,
            )
            db.add(record)
            records.append(record)
    db.commit()
    return records


def get_student_attendance(
    db: Session, student_id: int, limit: int = 100
) -> list[Attendance]:
    return (
        db.query(Attendance)
        .filter(Attendance.student_id == student_id)
        .order_by(Attendance.date.desc())
        .limit(limit)
        .all()
    )


def get_class_attendance(
    db: Session, class_id: int, attendance_date: date
) -> list[Attendance]:
    return (
        db.query(Attendance)
        .filter(
            Attendance.class_id == class_id,
            Attendance.date == attendance_date,
        )
        .all()
    )
