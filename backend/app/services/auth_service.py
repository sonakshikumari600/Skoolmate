from datetime import datetime, timedelta
from sqlalchemy.orm import Session
from fastapi import HTTPException, status

from app.models.models import User, UserRole, RefreshToken
from app.schemas.schemas import RegisterRequest, LoginRequest, ChangePasswordRequest
from app.auth.jwt import (
    hash_password, verify_password,
    create_access_token, create_refresh_token, decode_token,
)
from app.core.config import settings


def register_user(db: Session, data: RegisterRequest) -> User:
    if db.query(User).filter(User.email == data.email).first():
        raise HTTPException(status_code=400, detail="Email already registered")

    if data.admission_no and db.query(User).filter(
        User.admission_no == data.admission_no
    ).first():
        raise HTTPException(status_code=400, detail="Admission number already exists")

    user = User(
        name=data.name,
        email=data.email,
        hashed_password=hash_password(data.password),
        role=UserRole(data.role),
        phone=data.phone,
        admission_no=data.admission_no,
        dob=data.dob,
        class_name=data.class_name,
        section=data.section,
        roll_no=data.roll_no,
        subject=data.subject,
        employee_id=data.employee_id,
    )
    db.add(user)
    db.commit()
    db.refresh(user)
    return user


def login_user(db: Session, data: LoginRequest) -> dict:
    user = db.query(User).filter(User.email == data.email).first()
    if not user or not verify_password(data.password, user.hashed_password):
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid email or password",
        )
    if not user.is_active:
        raise HTTPException(status_code=403, detail="Account is deactivated")

    return _issue_tokens(db, user)


def refresh_tokens(db: Session, refresh_token: str) -> dict:
    payload = decode_token(refresh_token)
    if payload.get("type") != "refresh":
        raise HTTPException(status_code=401, detail="Invalid token type")

    stored = db.query(RefreshToken).filter(
        RefreshToken.token == refresh_token,
        RefreshToken.is_revoked == False,
    ).first()
    if not stored or stored.expires_at < datetime.utcnow():
        raise HTTPException(status_code=401, detail="Refresh token expired or revoked")

    stored.is_revoked = True
    db.commit()

    user = db.query(User).filter(User.id == int(payload["sub"])).first()
    if not user or not user.is_active:
        raise HTTPException(status_code=401, detail="User not found")

    return _issue_tokens(db, user)


def logout_user(db: Session, refresh_token: str) -> None:
    stored = db.query(RefreshToken).filter(
        RefreshToken.token == refresh_token
    ).first()
    if stored:
        stored.is_revoked = True
        db.commit()


def change_password(db: Session, user: User, data: ChangePasswordRequest) -> None:
    if not verify_password(data.current_password, user.hashed_password):
        raise HTTPException(status_code=400, detail="Current password is incorrect")
    user.hashed_password = hash_password(data.new_password)
    user.updated_at = datetime.utcnow()
    db.commit()


def request_password_reset(db: Session, email: str) -> str:
    """
    Returns a reset token. In production, email this token to the user.
    The token is a short-lived JWT with type='reset'.
    """
    user = db.query(User).filter(User.email == email).first()
    if not user:
        # Don't reveal whether email exists
        return "If that email is registered, a reset link has been sent."

    token = create_access_token(
        {"sub": str(user.id), "type": "reset"},
        expires_delta=timedelta(minutes=30),
    )
    # TODO: send token via email (integrate SMTP / SendGrid here)
    return token


def confirm_password_reset(db: Session, token: str, new_password: str) -> None:
    payload = decode_token(token)
    if payload.get("type") != "reset":
        raise HTTPException(status_code=400, detail="Invalid reset token")
    user = db.query(User).filter(User.id == int(payload["sub"])).first()
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    user.hashed_password = hash_password(new_password)
    user.updated_at = datetime.utcnow()
    db.commit()


# ── helpers ───────────────────────────────────────────────────────────────────

def _issue_tokens(db: Session, user: User) -> dict:
    access = create_access_token({"sub": str(user.id), "role": user.role.value})
    refresh = create_refresh_token({"sub": str(user.id)})

    expires_at = datetime.utcnow() + timedelta(days=settings.REFRESH_TOKEN_EXPIRE_DAYS)
    db.add(RefreshToken(user_id=user.id, token=refresh, expires_at=expires_at))
    db.commit()

    return {"access_token": access, "refresh_token": refresh, "token_type": "bearer"}
