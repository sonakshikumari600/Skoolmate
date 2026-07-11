from __future__ import annotations
from datetime import date, datetime
from typing import List, Optional
from pydantic import BaseModel, EmailStr, field_validator


# ── Auth ──────────────────────────────────────────────────────────────────────

class RegisterRequest(BaseModel):
    email: EmailStr
    password: str
    name: str
    role: str  # admin | teacher | student | parent
    phone: Optional[str] = None
    # student extras
    admission_no: Optional[str] = None
    dob: Optional[date] = None
    class_name: Optional[str] = None
    section: Optional[str] = None
    roll_no: Optional[str] = None
    # teacher extras
    subject: Optional[str] = None
    employee_id: Optional[str] = None

    @field_validator("role")
    @classmethod
    def validate_role(cls, v: str) -> str:
        allowed = {"admin", "teacher", "student", "parent"}
        if v.lower() not in allowed:
            raise ValueError(f"role must be one of {allowed}")
        return v.lower()


class LoginRequest(BaseModel):
    email: EmailStr
    password: str


class ChangePasswordRequest(BaseModel):
    current_password: str
    new_password: str


class ResetPasswordRequest(BaseModel):
    email: EmailStr


class TokenResponse(BaseModel):
    access_token: str
    refresh_token: str
    token_type: str = "bearer"


class RefreshRequest(BaseModel):
    refresh_token: str


# ── User ──────────────────────────────────────────────────────────────────────

class UserOut(BaseModel):
    id: int
    name: str
    email: str
    role: str
    phone: Optional[str] = None
    is_active: bool
    admission_no: Optional[str] = None
    dob: Optional[date] = None
    class_name: Optional[str] = None
    section: Optional[str] = None
    roll_no: Optional[str] = None
    subject: Optional[str] = None
    employee_id: Optional[str] = None
    created_at: datetime
    updated_at: datetime

    model_config = {"from_attributes": True}


class UserUpdate(BaseModel):
    name: Optional[str] = None
    phone: Optional[str] = None
    class_name: Optional[str] = None
    section: Optional[str] = None
    roll_no: Optional[str] = None
    subject: Optional[str] = None
    dob: Optional[date] = None


# ── Class ─────────────────────────────────────────────────────────────────────

class ClassCreate(BaseModel):
    name: str
    section: Optional[str] = None
    teacher_id: Optional[int] = None


class ClassOut(BaseModel):
    id: int
    name: str
    section: Optional[str] = None
    teacher_id: Optional[int] = None
    created_at: datetime

    model_config = {"from_attributes": True}


# ── Subject ───────────────────────────────────────────────────────────────────

class SubjectCreate(BaseModel):
    name: str
    code: Optional[str] = None
    class_id: int
    teacher_id: Optional[int] = None


class SubjectOut(BaseModel):
    id: int
    name: str
    code: Optional[str] = None
    class_id: int
    teacher_id: Optional[int] = None

    model_config = {"from_attributes": True}


# ── Attendance ────────────────────────────────────────────────────────────────

class AttendanceCreate(BaseModel):
    student_id: int
    class_id: int
    date: date
    status: str  # present | absent | late
    remarks: Optional[str] = None

    @field_validator("status")
    @classmethod
    def validate_status(cls, v: str) -> str:
        if v not in {"present", "absent", "late"}:
            raise ValueError("status must be present, absent, or late")
        return v


class AttendanceBulkCreate(BaseModel):
    class_id: int
    date: date
    records: List[AttendanceCreate]


class AttendanceOut(BaseModel):
    id: int
    student_id: int
    class_id: int
    date: date
    status: str
    marked_by: Optional[int] = None
    remarks: Optional[str] = None
    created_at: datetime

    model_config = {"from_attributes": True}


# ── Homework ──────────────────────────────────────────────────────────────────

class HomeworkCreate(BaseModel):
    title: str
    description: Optional[str] = None
    class_id: int
    subject_id: Optional[int] = None
    due_date: date


class HomeworkUpdate(BaseModel):
    title: Optional[str] = None
    description: Optional[str] = None
    due_date: Optional[date] = None
    is_active: Optional[bool] = None


class HomeworkOut(BaseModel):
    id: int
    title: str
    description: Optional[str] = None
    class_id: int
    subject_id: Optional[int] = None
    teacher_id: int
    due_date: date
    is_active: bool
    created_at: datetime

    model_config = {"from_attributes": True}


class SubmissionCreate(BaseModel):
    content: Optional[str] = None
    file_url: Optional[str] = None


class SubmissionOut(BaseModel):
    id: int
    homework_id: int
    student_id: int
    content: Optional[str] = None
    file_url: Optional[str] = None
    submitted_at: datetime
    grade: Optional[str] = None
    feedback: Optional[str] = None

    model_config = {"from_attributes": True}


class SubmissionGrade(BaseModel):
    grade: str
    feedback: Optional[str] = None


# ── Exams & Results ───────────────────────────────────────────────────────────

class ResultCreate(BaseModel):
    student_id: int
    subject_id: int
    exam_name: str
    marks_obtained: float
    total_marks: float
    grade: Optional[str] = None
    exam_date: Optional[date] = None


class ResultOut(BaseModel):
    id: int
    student_id: int
    subject_id: int
    exam_name: str
    marks_obtained: float
    total_marks: float
    grade: Optional[str] = None
    exam_date: Optional[date] = None
    created_at: datetime

    model_config = {"from_attributes": True}


# ── Notifications ─────────────────────────────────────────────────────────────

class NotificationCreate(BaseModel):
    user_id: int
    title: str
    body: Optional[str] = None


class NotificationOut(BaseModel):
    id: int
    user_id: int
    title: str
    body: Optional[str] = None
    is_read: bool
    created_at: datetime

    model_config = {"from_attributes": True}


# ── Messages ──────────────────────────────────────────────────────────────────

class MessageCreate(BaseModel):
    receiver_id: int
    content: str


class MessageOut(BaseModel):
    id: int
    sender_id: int
    receiver_id: int
    content: str
    is_read: bool
    sent_at: datetime

    model_config = {"from_attributes": True}


# ── Leave Applications ────────────────────────────────────────────────────────

class LeaveCreate(BaseModel):
    from_date: date
    to_date: date
    reason: str


class LeaveStatusUpdate(BaseModel):
    status: str  # approved | rejected
    remarks: Optional[str] = None

    @field_validator("status")
    @classmethod
    def validate_status(cls, v: str) -> str:
        if v not in {"approved", "rejected"}:
            raise ValueError("status must be approved or rejected")
        return v


class LeaveOut(BaseModel):
    id: int
    student_id: int
    from_date: date
    to_date: date
    reason: str
    status: str
    reviewed_by: Optional[int] = None
    remarks: Optional[str] = None
    applied_at: datetime
    updated_at: datetime

    model_config = {"from_attributes": True}


# ── Timetable ─────────────────────────────────────────────────────────────────

class TimetableCreate(BaseModel):
    class_id: int
    subject_id: int
    teacher_id: int
    day_of_week: str  # Monday … Sunday
    start_time: str   # HH:MM
    end_time: str
    room: Optional[str] = None


class TimetableOut(BaseModel):
    id: int
    class_id: int
    subject_id: int
    teacher_id: int
    day_of_week: str
    start_time: str
    end_time: str
    room: Optional[str] = None

    model_config = {"from_attributes": True}


# ── Fees ──────────────────────────────────────────────────────────────────────

class FeeCreate(BaseModel):
    student_id: int
    amount: float
    description: Optional[str] = None
    due_date: date


class FeePayment(BaseModel):
    payment_reference: Optional[str] = None


class FeeOut(BaseModel):
    id: int
    student_id: int
    amount: float
    description: Optional[str] = None
    due_date: date
    is_paid: bool
    paid_at: Optional[datetime] = None
    payment_reference: Optional[str] = None
    created_at: datetime

    model_config = {"from_attributes": True}


# ── Events / Notices ──────────────────────────────────────────────────────────

class NoticeCreate(BaseModel):
    title: str
    content: str
    target_role: Optional[str] = "all"  # all | parent | student | teacher


class NoticeOut(BaseModel):
    id: int
    title: str
    content: str
    author_id: int
    target_role: Optional[str] = None
    is_active: bool
    created_at: datetime

    model_config = {"from_attributes": True}


# ── Parent-Student Linking ────────────────────────────────────────────────────

class LinkStudentRequest(BaseModel):
    admission_no: str
    verification_code: str


class LinkedStudentOut(BaseModel):
    id: int
    name: str
    admission_no: Optional[str] = None
    class_name: Optional[str] = None
    section: Optional[str] = None
    roll_no: Optional[str] = None

    model_config = {"from_attributes": True}


# ── Generic response ──────────────────────────────────────────────────────────

class MessageResponse(BaseModel):
    success: bool
    message: str
