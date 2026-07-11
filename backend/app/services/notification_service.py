from sqlalchemy.orm import Session
from fastapi import HTTPException

from app.models.models import Notification
from app.schemas.schemas import NotificationCreate


def create_notification(db: Session, data: NotificationCreate) -> Notification:
    notif = Notification(
        user_id=data.user_id,
        title=data.title,
        body=data.body,
    )
    db.add(notif)
    db.commit()
    db.refresh(notif)
    return notif


def broadcast_notification(db: Session, title: str, body: str, user_ids: list[int]) -> int:
    """Create one notification per user in user_ids. Returns count created."""
    notifs = [Notification(user_id=uid, title=title, body=body) for uid in user_ids]
    db.add_all(notifs)
    db.commit()
    return len(notifs)


def get_user_notifications(db: Session, user_id: int, limit: int = 50) -> list[Notification]:
    return (
        db.query(Notification)
        .filter(Notification.user_id == user_id)
        .order_by(Notification.created_at.desc())
        .limit(limit)
        .all()
    )


def mark_read(db: Session, notification_id: int, user_id: int) -> Notification:
    notif = db.query(Notification).filter(
        Notification.id == notification_id,
        Notification.user_id == user_id,
    ).first()
    if not notif:
        raise HTTPException(status_code=404, detail="Notification not found")
    notif.is_read = True
    db.commit()
    db.refresh(notif)
    return notif


def mark_all_read(db: Session, user_id: int) -> int:
    updated = (
        db.query(Notification)
        .filter(Notification.user_id == user_id, Notification.is_read == False)
        .all()
    )
    for n in updated:
        n.is_read = True
    db.commit()
    return len(updated)
