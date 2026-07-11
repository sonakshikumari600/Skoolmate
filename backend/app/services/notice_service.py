from sqlalchemy.orm import Session
from fastapi import HTTPException

from app.models.models import Notice
from app.schemas.schemas import NoticeCreate


def create_notice(db: Session, data: NoticeCreate, author_id: int) -> Notice:
    notice = Notice(
        title=data.title,
        content=data.content,
        author_id=author_id,
        target_role=data.target_role,
    )
    db.add(notice)
    db.commit()
    db.refresh(notice)
    return notice


def get_all_notices(db: Session, role: str | None = None) -> list[Notice]:
    q = db.query(Notice).filter(Notice.is_active == True)
    if role:
        q = q.filter(
            (Notice.target_role == "all") | (Notice.target_role == role)
        )
    return q.order_by(Notice.created_at.desc()).all()


def deactivate_notice(db: Session, notice_id: int, author_id: int) -> None:
    notice = db.query(Notice).filter(Notice.id == notice_id).first()
    if not notice:
        raise HTTPException(status_code=404, detail="Notice not found")
    if notice.author_id != author_id:
        raise HTTPException(status_code=403, detail="Not your notice")
    notice.is_active = False
    db.commit()
