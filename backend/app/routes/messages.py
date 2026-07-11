from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from app.database.session import get_db
from app.auth.jwt import get_current_user
from app.models.models import User
from app.schemas.schemas import MessageCreate, MessageOut, MessageResponse
from app.services import message_service

router = APIRouter(prefix="/messages", tags=["Messages"])


@router.post("/", response_model=MessageOut, status_code=201)
def send_message(
    data: MessageCreate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    return message_service.send_message(db, current_user.id, data)


@router.get("/inbox", response_model=list[MessageOut])
def get_inbox(
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    return message_service.get_inbox(db, current_user.id)


@router.get("/conversation/{other_user_id}", response_model=list[MessageOut])
def get_conversation(
    other_user_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    return message_service.get_conversation(db, current_user.id, other_user_id)


@router.patch("/conversation/{sender_id}/read", response_model=MessageResponse)
def mark_conversation_read(
    sender_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    count = message_service.mark_messages_read(db, sender_id, current_user.id)
    return {"success": True, "message": f"{count} message(s) marked as read"}
