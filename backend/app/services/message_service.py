from sqlalchemy import or_, and_
from sqlalchemy.orm import Session
from fastapi import HTTPException

from app.models.models import Message
from app.schemas.schemas import MessageCreate


def send_message(db: Session, sender_id: int, data: MessageCreate) -> Message:
    if sender_id == data.receiver_id:
        raise HTTPException(status_code=400, detail="Cannot send message to yourself")
    msg = Message(
        sender_id=sender_id,
        receiver_id=data.receiver_id,
        content=data.content,
    )
    db.add(msg)
    db.commit()
    db.refresh(msg)
    return msg


def get_conversation(db: Session, user_a: int, user_b: int) -> list[Message]:
    """Returns all messages between two users, ordered oldest-first."""
    return (
        db.query(Message)
        .filter(
            or_(
                and_(Message.sender_id == user_a, Message.receiver_id == user_b),
                and_(Message.sender_id == user_b, Message.receiver_id == user_a),
            )
        )
        .order_by(Message.sent_at.asc())
        .all()
    )


def get_inbox(db: Session, user_id: int) -> list[Message]:
    """Latest message per conversation partner."""
    return (
        db.query(Message)
        .filter(
            or_(Message.sender_id == user_id, Message.receiver_id == user_id)
        )
        .order_by(Message.sent_at.desc())
        .all()
    )


def mark_messages_read(db: Session, sender_id: int, receiver_id: int) -> int:
    msgs = (
        db.query(Message)
        .filter(
            Message.sender_id == sender_id,
            Message.receiver_id == receiver_id,
            Message.is_read == False,
        )
        .all()
    )
    for m in msgs:
        m.is_read = True
    db.commit()
    return len(msgs)
