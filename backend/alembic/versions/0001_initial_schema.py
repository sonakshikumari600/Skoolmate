"""initial schema

Revision ID: 0001
Revises:
Create Date: 2024-01-01 00:00:00.000000

"""
from typing import Sequence, Union
import sqlalchemy as sa
from alembic import op

revision: str = "0001"
down_revision: Union[str, None] = None
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    # ── users ─────────────────────────────────────────────────────────────────
    op.create_table(
        "users",
        sa.Column("id", sa.Integer(), primary_key=True, index=True),
        sa.Column("name", sa.String(120), nullable=False),
        sa.Column("email", sa.String(255), unique=True, index=True, nullable=False),
        sa.Column("hashed_password", sa.String(255), nullable=False),
        sa.Column("role", sa.Enum("admin", "teacher", "student", "parent", name="userrole"), nullable=False),
        sa.Column("phone", sa.String(20), nullable=True),
        sa.Column("is_active", sa.Boolean(), default=True, nullable=False),
        sa.Column("created_at", sa.DateTime(), nullable=True),
        sa.Column("updated_at", sa.DateTime(), nullable=True),
        # student fields
        sa.Column("admission_no", sa.String(50), unique=True, nullable=True),
        sa.Column("verification_code", sa.String(50), nullable=True),
        sa.Column("dob", sa.Date(), nullable=True),
        sa.Column("class_name", sa.String(50), nullable=True),
        sa.Column("section", sa.String(10), nullable=True),
        sa.Column("roll_no", sa.String(20), nullable=True),
        # teacher fields
        sa.Column("subject", sa.String(100), nullable=True),
        sa.Column("employee_id", sa.String(50), nullable=True),
    )

    # ── parent_student (association) ──────────────────────────────────────────
    op.create_table(
        "parent_student",
        sa.Column("parent_id", sa.Integer(), sa.ForeignKey("users.id"), primary_key=True),
        sa.Column("student_id", sa.Integer(), sa.ForeignKey("users.id"), primary_key=True),
    )

    # ── classes ───────────────────────────────────────────────────────────────
    op.create_table(
        "classes",
        sa.Column("id", sa.Integer(), primary_key=True, index=True),
        sa.Column("name", sa.String(50), nullable=False),
        sa.Column("section", sa.String(10), nullable=True),
        sa.Column("teacher_id", sa.Integer(), sa.ForeignKey("users.id"), nullable=True),
        sa.Column("created_at", sa.DateTime(), nullable=True),
    )

    # ── subjects ──────────────────────────────────────────────────────────────
    op.create_table(
        "subjects",
        sa.Column("id", sa.Integer(), primary_key=True, index=True),
        sa.Column("name", sa.String(100), nullable=False),
        sa.Column("code", sa.String(20), unique=True, nullable=True),
        sa.Column("class_id", sa.Integer(), sa.ForeignKey("classes.id"), nullable=True),
        sa.Column("teacher_id", sa.Integer(), sa.ForeignKey("users.id"), nullable=True),
    )

    # ── timetables ────────────────────────────────────────────────────────────
    op.create_table(
        "timetables",
        sa.Column("id", sa.Integer(), primary_key=True, index=True),
        sa.Column("class_id", sa.Integer(), sa.ForeignKey("classes.id"), nullable=False),
        sa.Column("subject_id", sa.Integer(), sa.ForeignKey("subjects.id"), nullable=False),
        sa.Column("teacher_id", sa.Integer(), sa.ForeignKey("users.id"), nullable=False),
        sa.Column("day_of_week", sa.String(10), nullable=False),
        sa.Column("start_time", sa.String(10), nullable=False),
        sa.Column("end_time", sa.String(10), nullable=False),
        sa.Column("room", sa.String(20), nullable=True),
        sa.Column("created_at", sa.DateTime(), nullable=True),
    )

    # ── attendance ────────────────────────────────────────────────────────────
    op.create_table(
        "attendance",
        sa.Column("id", sa.Integer(), primary_key=True, index=True),
        sa.Column("student_id", sa.Integer(), sa.ForeignKey("users.id"), nullable=False),
        sa.Column("class_id", sa.Integer(), sa.ForeignKey("classes.id"), nullable=False),
        sa.Column("date", sa.Date(), nullable=False),
        sa.Column("status", sa.Enum("present", "absent", "late", name="attendancestatus"), nullable=False),
        sa.Column("marked_by", sa.Integer(), sa.ForeignKey("users.id"), nullable=True),
        sa.Column("remarks", sa.String(255), nullable=True),
        sa.Column("created_at", sa.DateTime(), nullable=True),
    )

    # ── homework ──────────────────────────────────────────────────────────────
    op.create_table(
        "homework",
        sa.Column("id", sa.Integer(), primary_key=True, index=True),
        sa.Column("title", sa.String(200), nullable=False),
        sa.Column("description", sa.Text(), nullable=True),
        sa.Column("class_id", sa.Integer(), sa.ForeignKey("classes.id"), nullable=False),
        sa.Column("subject_id", sa.Integer(), sa.ForeignKey("subjects.id"), nullable=True),
        sa.Column("teacher_id", sa.Integer(), sa.ForeignKey("users.id"), nullable=False),
        sa.Column("due_date", sa.Date(), nullable=False),
        sa.Column("is_active", sa.Boolean(), default=True, nullable=False),
        sa.Column("created_at", sa.DateTime(), nullable=True),
    )

    # ── homework_submissions ──────────────────────────────────────────────────
    op.create_table(
        "homework_submissions",
        sa.Column("id", sa.Integer(), primary_key=True, index=True),
        sa.Column("homework_id", sa.Integer(), sa.ForeignKey("homework.id"), nullable=False),
        sa.Column("student_id", sa.Integer(), sa.ForeignKey("users.id"), nullable=False),
        sa.Column("content", sa.Text(), nullable=True),
        sa.Column("file_url", sa.String(500), nullable=True),
        sa.Column("submitted_at", sa.DateTime(), nullable=True),
        sa.Column("grade", sa.String(10), nullable=True),
        sa.Column("feedback", sa.Text(), nullable=True),
    )

    # ── results ───────────────────────────────────────────────────────────────
    op.create_table(
        "results",
        sa.Column("id", sa.Integer(), primary_key=True, index=True),
        sa.Column("student_id", sa.Integer(), sa.ForeignKey("users.id"), nullable=False),
        sa.Column("subject_id", sa.Integer(), sa.ForeignKey("subjects.id"), nullable=False),
        sa.Column("exam_name", sa.String(100), nullable=False),
        sa.Column("marks_obtained", sa.Float(), nullable=False),
        sa.Column("total_marks", sa.Float(), nullable=False),
        sa.Column("grade", sa.String(5), nullable=True),
        sa.Column("exam_date", sa.Date(), nullable=True),
        sa.Column("created_at", sa.DateTime(), nullable=True),
    )

    # ── notices ───────────────────────────────────────────────────────────────
    op.create_table(
        "notices",
        sa.Column("id", sa.Integer(), primary_key=True, index=True),
        sa.Column("title", sa.String(200), nullable=False),
        sa.Column("content", sa.Text(), nullable=False),
        sa.Column("author_id", sa.Integer(), sa.ForeignKey("users.id"), nullable=False),
        sa.Column("target_role", sa.String(20), nullable=True),
        sa.Column("is_active", sa.Boolean(), default=True, nullable=False),
        sa.Column("created_at", sa.DateTime(), nullable=True),
    )

    # ── messages ──────────────────────────────────────────────────────────────
    op.create_table(
        "messages",
        sa.Column("id", sa.Integer(), primary_key=True, index=True),
        sa.Column("sender_id", sa.Integer(), sa.ForeignKey("users.id"), nullable=False),
        sa.Column("receiver_id", sa.Integer(), sa.ForeignKey("users.id"), nullable=False),
        sa.Column("content", sa.Text(), nullable=False),
        sa.Column("is_read", sa.Boolean(), default=False, nullable=False),
        sa.Column("sent_at", sa.DateTime(), nullable=True),
    )

    # ── notifications ─────────────────────────────────────────────────────────
    op.create_table(
        "notifications",
        sa.Column("id", sa.Integer(), primary_key=True, index=True),
        sa.Column("user_id", sa.Integer(), sa.ForeignKey("users.id"), nullable=False),
        sa.Column("title", sa.String(200), nullable=False),
        sa.Column("body", sa.Text(), nullable=True),
        sa.Column("is_read", sa.Boolean(), default=False, nullable=False),
        sa.Column("created_at", sa.DateTime(), nullable=True),
    )

    # ── leave_applications ────────────────────────────────────────────────────
    op.create_table(
        "leave_applications",
        sa.Column("id", sa.Integer(), primary_key=True, index=True),
        sa.Column("student_id", sa.Integer(), sa.ForeignKey("users.id"), nullable=False),
        sa.Column("from_date", sa.Date(), nullable=False),
        sa.Column("to_date", sa.Date(), nullable=False),
        sa.Column("reason", sa.Text(), nullable=False),
        sa.Column("status", sa.Enum("pending", "approved", "rejected", name="leavestatus"), nullable=False),
        sa.Column("reviewed_by", sa.Integer(), sa.ForeignKey("users.id"), nullable=True),
        sa.Column("remarks", sa.Text(), nullable=True),
        sa.Column("applied_at", sa.DateTime(), nullable=True),
        sa.Column("updated_at", sa.DateTime(), nullable=True),
    )

    # ── fees ──────────────────────────────────────────────────────────────────
    op.create_table(
        "fees",
        sa.Column("id", sa.Integer(), primary_key=True, index=True),
        sa.Column("student_id", sa.Integer(), sa.ForeignKey("users.id"), nullable=False),
        sa.Column("amount", sa.Float(), nullable=False),
        sa.Column("description", sa.String(200), nullable=True),
        sa.Column("due_date", sa.Date(), nullable=False),
        sa.Column("is_paid", sa.Boolean(), default=False, nullable=False),
        sa.Column("paid_at", sa.DateTime(), nullable=True),
        sa.Column("payment_reference", sa.String(100), nullable=True),
        sa.Column("created_at", sa.DateTime(), nullable=True),
    )

    # ── substitute_lectures ───────────────────────────────────────────────────
    op.create_table(
        "substitute_lectures",
        sa.Column("id", sa.Integer(), primary_key=True, index=True),
        sa.Column("original_teacher_id", sa.Integer(), sa.ForeignKey("users.id"), nullable=False),
        sa.Column("substitute_teacher_id", sa.Integer(), sa.ForeignKey("users.id"), nullable=False),
        sa.Column("timetable_id", sa.Integer(), sa.ForeignKey("timetables.id"), nullable=False),
        sa.Column("date", sa.Date(), nullable=False),
        sa.Column("reason", sa.Text(), nullable=True),
        sa.Column("created_at", sa.DateTime(), nullable=True),
    )

    # ── refresh_tokens ────────────────────────────────────────────────────────
    op.create_table(
        "refresh_tokens",
        sa.Column("id", sa.Integer(), primary_key=True, index=True),
        sa.Column("user_id", sa.Integer(), sa.ForeignKey("users.id"), nullable=False),
        sa.Column("token", sa.String(500), unique=True, nullable=False),
        sa.Column("expires_at", sa.DateTime(), nullable=False),
        sa.Column("is_revoked", sa.Boolean(), default=False, nullable=False),
        sa.Column("created_at", sa.DateTime(), nullable=True),
    )


def downgrade() -> None:
    op.drop_table("refresh_tokens")
    op.drop_table("substitute_lectures")
    op.drop_table("fees")
    op.drop_table("leave_applications")
    op.drop_table("notifications")
    op.drop_table("messages")
    op.drop_table("notices")
    op.drop_table("results")
    op.drop_table("homework_submissions")
    op.drop_table("homework")
    op.drop_table("attendance")
    op.drop_table("timetables")
    op.drop_table("subjects")
    op.drop_table("classes")
    op.drop_table("parent_student")
    op.drop_table("users")
    op.execute("DROP TYPE IF EXISTS userrole")
    op.execute("DROP TYPE IF EXISTS attendancestatus")
    op.execute("DROP TYPE IF EXISTS leavestatus")
