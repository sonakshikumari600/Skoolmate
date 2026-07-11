import enum
from datetime import datetime
from sqlalchemy import (
    Column, Integer, String, Boolean, Float, Text,
    DateTime, Date, ForeignKey, Enum, Table
)
from sqlalchemy.orm import relationship
from app.database.session import Base


class UserRole(str, enum.Enum):
    admin = "admin"
    teacher = "teacher"
    student = "student"
    parent = "parent"


class AttendanceStatus(str, enum.Enum):
    present = "present"
    absent = "absent"
    late = "late"


class LeaveStatus(str, enum.Enum):
    pending = "pending"
    approved = "approved"
    rejected = "rejected"


# ── Association table: parent ↔ student ────────────────────────────────────────
parent_student = Table(
    "parent_student",
    Base.metadata,
    Column("parent_id", Integer, ForeignKey("users.id"), primary_key=True),
    Column("student_id", Integer, ForeignKey("users.id"), primary_key=True),
)


class User(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String(120), nullable=False)
    email = Column(String(255), unique=True, index=True, nullable=False)
    hashed_password = Column(String(255), nullable=False)
    role = Column(Enum(UserRole), nullable=False)
    phone = Column(String(20))
    is_active = Column(Boolean, default=True)
    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)

    # Student-specific
    admission_no = Column(String(50), unique=True, nullable=True)
    verification_code = Column(String(50), nullable=True)
    dob = Column(Date, nullable=True)
    class_name = Column(String(50), nullable=True)
    section = Column(String(10), nullable=True)
    roll_no = Column(String(20), nullable=True)

    # Teacher-specific
    subject = Column(String(100), nullable=True)
    employee_id = Column(String(50), nullable=True)

    # Relationships
    children = relationship(
        "User",
        secondary=parent_student,
        primaryjoin=id == parent_student.c.parent_id,
        secondaryjoin=id == parent_student.c.student_id,
        backref="parents",
    )
    attendance_records = relationship("Attendance", back_populates="student", foreign_keys="Attendance.student_id")
    homework_assigned = relationship("Homework", back_populates="teacher", foreign_keys="Homework.teacher_id")
    notifications = relationship("Notification", back_populates="user")
    sent_messages = relationship("Message", back_populates="sender", foreign_keys="Message.sender_id")
    received_messages = relationship("Message", back_populates="receiver", foreign_keys="Message.receiver_id")
    leave_applications = relationship("LeaveApplication", back_populates="student")
    fee_records = relationship("Fee", back_populates="student")
    results = relationship("Result", back_populates="student")
    refresh_tokens = relationship("RefreshToken", back_populates="user")


class Class(Base):
    __tablename__ = "classes"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String(50), nullable=False)
    section = Column(String(10))
    teacher_id = Column(Integer, ForeignKey("users.id"), nullable=True)
    created_at = Column(DateTime, default=datetime.utcnow)

    teacher = relationship("User", foreign_keys=[teacher_id])
    timetable_entries = relationship("Timetable", back_populates="class_")
    homework_list = relationship("Homework", back_populates="class_")
    attendance_records = relationship("Attendance", back_populates="class_")


class Subject(Base):
    __tablename__ = "subjects"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String(100), nullable=False)
    code = Column(String(20), unique=True)
    class_id = Column(Integer, ForeignKey("classes.id"))
    teacher_id = Column(Integer, ForeignKey("users.id"))

    class_ = relationship("Class", foreign_keys=[class_id])
    teacher = relationship("User", foreign_keys=[teacher_id])
    timetable_entries = relationship("Timetable", back_populates="subject")
    results = relationship("Result", back_populates="subject")


class Timetable(Base):
    __tablename__ = "timetables"

    id = Column(Integer, primary_key=True, index=True)
    class_id = Column(Integer, ForeignKey("classes.id"), nullable=False)
    subject_id = Column(Integer, ForeignKey("subjects.id"), nullable=False)
    teacher_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    day_of_week = Column(String(10), nullable=False)  # Monday, Tuesday...
    start_time = Column(String(10), nullable=False)   # HH:MM
    end_time = Column(String(10), nullable=False)
    room = Column(String(20))
    created_at = Column(DateTime, default=datetime.utcnow)

    class_ = relationship("Class", back_populates="timetable_entries")
    subject = relationship("Subject", back_populates="timetable_entries")
    teacher = relationship("User", foreign_keys=[teacher_id])


class Attendance(Base):
    __tablename__ = "attendance"

    id = Column(Integer, primary_key=True, index=True)
    student_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    class_id = Column(Integer, ForeignKey("classes.id"), nullable=False)
    date = Column(Date, nullable=False)
    status = Column(Enum(AttendanceStatus), nullable=False)
    marked_by = Column(Integer, ForeignKey("users.id"))
    remarks = Column(String(255))
    created_at = Column(DateTime, default=datetime.utcnow)

    student = relationship("User", back_populates="attendance_records", foreign_keys=[student_id])
    class_ = relationship("Class", back_populates="attendance_records")
    teacher = relationship("User", foreign_keys=[marked_by])


class Homework(Base):
    __tablename__ = "homework"

    id = Column(Integer, primary_key=True, index=True)
    title = Column(String(200), nullable=False)
    description = Column(Text)
    class_id = Column(Integer, ForeignKey("classes.id"), nullable=False)
    subject_id = Column(Integer, ForeignKey("subjects.id"))
    teacher_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    due_date = Column(Date, nullable=False)
    is_active = Column(Boolean, default=True)
    created_at = Column(DateTime, default=datetime.utcnow)

    class_ = relationship("Class", back_populates="homework_list")
    teacher = relationship("User", back_populates="homework_assigned", foreign_keys=[teacher_id])
    subject = relationship("Subject", foreign_keys=[subject_id])
    submissions = relationship("HomeworkSubmission", back_populates="homework")


class HomeworkSubmission(Base):
    __tablename__ = "homework_submissions"

    id = Column(Integer, primary_key=True, index=True)
    homework_id = Column(Integer, ForeignKey("homework.id"), nullable=False)
    student_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    content = Column(Text)
    file_url = Column(String(500))
    submitted_at = Column(DateTime, default=datetime.utcnow)
    grade = Column(String(10))
    feedback = Column(Text)

    homework = relationship("Homework", back_populates="submissions")
    student = relationship("User", foreign_keys=[student_id])


class Result(Base):
    __tablename__ = "results"

    id = Column(Integer, primary_key=True, index=True)
    student_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    subject_id = Column(Integer, ForeignKey("subjects.id"), nullable=False)
    exam_name = Column(String(100), nullable=False)
    marks_obtained = Column(Float, nullable=False)
    total_marks = Column(Float, nullable=False)
    grade = Column(String(5))
    exam_date = Column(Date)
    created_at = Column(DateTime, default=datetime.utcnow)

    student = relationship("User", back_populates="results")
    subject = relationship("Subject", back_populates="results")


class Notice(Base):
    __tablename__ = "notices"

    id = Column(Integer, primary_key=True, index=True)
    title = Column(String(200), nullable=False)
    content = Column(Text, nullable=False)
    author_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    target_role = Column(String(20))  # all, parent, student, teacher
    is_active = Column(Boolean, default=True)
    created_at = Column(DateTime, default=datetime.utcnow)

    author = relationship("User", foreign_keys=[author_id])


class Message(Base):
    __tablename__ = "messages"

    id = Column(Integer, primary_key=True, index=True)
    sender_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    receiver_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    content = Column(Text, nullable=False)
    is_read = Column(Boolean, default=False)
    sent_at = Column(DateTime, default=datetime.utcnow)

    sender = relationship("User", back_populates="sent_messages", foreign_keys=[sender_id])
    receiver = relationship("User", back_populates="received_messages", foreign_keys=[receiver_id])


class Notification(Base):
    __tablename__ = "notifications"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    title = Column(String(200), nullable=False)
    body = Column(Text)
    is_read = Column(Boolean, default=False)
    created_at = Column(DateTime, default=datetime.utcnow)

    user = relationship("User", back_populates="notifications")


class LeaveApplication(Base):
    __tablename__ = "leave_applications"

    id = Column(Integer, primary_key=True, index=True)
    student_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    from_date = Column(Date, nullable=False)
    to_date = Column(Date, nullable=False)
    reason = Column(Text, nullable=False)
    status = Column(Enum(LeaveStatus), default=LeaveStatus.pending)
    reviewed_by = Column(Integer, ForeignKey("users.id"), nullable=True)
    remarks = Column(Text)
    applied_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)

    student = relationship("User", back_populates="leave_applications", foreign_keys=[student_id])
    reviewer = relationship("User", foreign_keys=[reviewed_by])


class Fee(Base):
    __tablename__ = "fees"

    id = Column(Integer, primary_key=True, index=True)
    student_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    amount = Column(Float, nullable=False)
    description = Column(String(200))
    due_date = Column(Date, nullable=False)
    is_paid = Column(Boolean, default=False)
    paid_at = Column(DateTime, nullable=True)
    payment_reference = Column(String(100))
    created_at = Column(DateTime, default=datetime.utcnow)

    student = relationship("User", back_populates="fee_records")


class SubstituteLecture(Base):
    __tablename__ = "substitute_lectures"

    id = Column(Integer, primary_key=True, index=True)
    original_teacher_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    substitute_teacher_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    timetable_id = Column(Integer, ForeignKey("timetables.id"), nullable=False)
    date = Column(Date, nullable=False)
    reason = Column(Text)
    created_at = Column(DateTime, default=datetime.utcnow)

    original_teacher = relationship("User", foreign_keys=[original_teacher_id])
    substitute_teacher = relationship("User", foreign_keys=[substitute_teacher_id])
    timetable = relationship("Timetable", foreign_keys=[timetable_id])


class RefreshToken(Base):
    __tablename__ = "refresh_tokens"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    token = Column(String(500), unique=True, nullable=False)
    expires_at = Column(DateTime, nullable=False)
    is_revoked = Column(Boolean, default=False)
    created_at = Column(DateTime, default=datetime.utcnow)

    user = relationship("User", back_populates="refresh_tokens")
