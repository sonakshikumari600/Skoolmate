from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from app.database.session import get_db
from app.auth.jwt import get_current_user
from app.models.models import User
from app.schemas.schemas import (
    RegisterRequest, LoginRequest, TokenResponse,
    RefreshRequest, ChangePasswordRequest, ResetPasswordRequest,
    UserOut, MessageResponse,
)
from app.services import auth_service

router = APIRouter(prefix="/auth", tags=["Auth"])


@router.post("/register", response_model=UserOut, status_code=201)
def register(data: RegisterRequest, db: Session = Depends(get_db)):
    return auth_service.register_user(db, data)


@router.post("/login", response_model=TokenResponse)
def login(data: LoginRequest, db: Session = Depends(get_db)):
    return auth_service.login_user(db, data)


@router.post("/refresh", response_model=TokenResponse)
def refresh(data: RefreshRequest, db: Session = Depends(get_db)):
    return auth_service.refresh_tokens(db, data.refresh_token)


@router.post("/logout", response_model=MessageResponse)
def logout(data: RefreshRequest, db: Session = Depends(get_db)):
    auth_service.logout_user(db, data.refresh_token)
    return {"success": True, "message": "Logged out successfully"}


@router.post("/change-password", response_model=MessageResponse)
def change_password(
    data: ChangePasswordRequest,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    auth_service.change_password(db, current_user, data)
    return {"success": True, "message": "Password changed successfully"}


@router.post("/reset-password/request", response_model=MessageResponse)
def reset_password_request(data: ResetPasswordRequest, db: Session = Depends(get_db)):
    # In production the token is emailed; here we return the message only
    auth_service.request_password_reset(db, data.email)
    return {"success": True, "message": "If that email is registered, a reset link has been sent."}


@router.post("/reset-password/confirm", response_model=MessageResponse)
def reset_password_confirm(token: str, new_password: str, db: Session = Depends(get_db)):
    auth_service.confirm_password_reset(db, token, new_password)
    return {"success": True, "message": "Password reset successfully"}


@router.get("/me", response_model=UserOut)
def get_me(current_user: User = Depends(get_current_user)):
    return current_user
