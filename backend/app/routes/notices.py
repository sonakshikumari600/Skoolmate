from fastapi import APIRouter, Depends, Query
from sqlalchemy.orm import Session
from typing import Optional

from app.database.session import get_db
from app.auth.jwt import get_current_user, require_role
from app.models.models import User
from app.schemas.schemas import NoticeCreate, NoticeOut, MessageResponse
from app.services import notice_service

router = APIRouter(prefix="/notices", tags=["Notices"])


@router.post("/", response_model=NoticeOut, status_code=201)
def create_notice(
    data: NoticeCreate,
    db: Session = Depends(get_db),
    current_user: User = Depends(require_role("admin", "teacher")),
):
    return notice_service.create_notice(db, data, current_user.id)


@router.get("/", response_model=list[NoticeOut])
def list_notices(
    role: Optional[str] = Query(None, description="Filter by target role"),
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    # Default: filter by the caller's own role so each user sees relevant notices
    filter_role = role or current_user.role.value
    return notice_service.get_all_notices(db, filter_role)


@router.delete("/{notice_id}", response_model=MessageResponse)
def deactivate_notice(
    notice_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(require_role("admin", "teacher")),
):
    notice_service.deactivate_notice(db, notice_id, current_user.id)
    return {"success": True, "message": "Notice removed"}
