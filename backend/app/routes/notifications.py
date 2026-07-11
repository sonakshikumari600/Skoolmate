from fastapi import APIRouter, Depends, Query
from sqlalchemy.orm import Session
from typing import List

from app.database.session import get_db
from app.auth.jwt import get_current_user, require_role
from app.models.models import User
from app.schemas.schemas import NotificationCreate, NotificationOut, MessageResponse
from app.services import notification_service

router = APIRouter(prefix="/notifications", tags=["Notifications"])


@router.get("/", response_model=list[NotificationOut])
def get_my_notifications(
    limit: int = Query(50, le=200),
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    return notification_service.get_user_notifications(db, current_user.id, limit)


@router.patch("/{notification_id}/read", response_model=NotificationOut)
def mark_notification_read(
    notification_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    return notification_service.mark_read(db, notification_id, current_user.id)


@router.patch("/read-all", response_model=MessageResponse)
def mark_all_read(
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    count = notification_service.mark_all_read(db, current_user.id)
    return {"success": True, "message": f"{count} notification(s) marked as read"}


@router.post("/", response_model=NotificationOut, status_code=201)
def create_notification(
    data: NotificationCreate,
    db: Session = Depends(get_db),
    _: User = Depends(require_role("admin", "teacher")),
):
    return notification_service.create_notification(db, data)


@router.post("/broadcast", response_model=MessageResponse, status_code=201)
def broadcast(
    title: str,
    body: str,
    user_ids: List[int],
    db: Session = Depends(get_db),
    _: User = Depends(require_role("admin")),
):
    count = notification_service.broadcast_notification(db, title, body, user_ids)
    return {"success": True, "message": f"Sent to {count} user(s)"}
