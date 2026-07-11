from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from app.database.session import get_db
from app.auth.jwt import get_current_user, require_role
from app.models.models import User
from app.schemas.schemas import ClassCreate, ClassOut, SubjectCreate, SubjectOut
from app.services import class_service

router = APIRouter(prefix="/classes", tags=["Classes"])


@router.post("/", response_model=ClassOut, status_code=201)
def create_class(
    data: ClassCreate,
    db: Session = Depends(get_db),
    _: User = Depends(require_role("admin")),
):
    return class_service.create_class(db, data)


@router.get("/", response_model=list[ClassOut])
def list_classes(
    db: Session = Depends(get_db),
    _: User = Depends(get_current_user),
):
    return class_service.get_all_classes(db)


@router.get("/my", response_model=list[ClassOut])
def get_my_classes(
    db: Session = Depends(get_db),
    current_user: User = Depends(require_role("teacher")),
):
    return class_service.get_teacher_classes(db, current_user.id)


@router.get("/{class_id}", response_model=ClassOut)
def get_class(
    class_id: int,
    db: Session = Depends(get_db),
    _: User = Depends(get_current_user),
):
    return class_service.get_class_by_id(db, class_id)


@router.post("/{class_id}/subjects", response_model=SubjectOut, status_code=201)
def create_subject(
    class_id: int,
    data: SubjectCreate,
    db: Session = Depends(get_db),
    _: User = Depends(require_role("admin")),
):
    data.class_id = class_id
    return class_service.create_subject(db, data)


@router.get("/{class_id}/subjects", response_model=list[SubjectOut])
def list_subjects(
    class_id: int,
    db: Session = Depends(get_db),
    _: User = Depends(get_current_user),
):
    return class_service.get_class_subjects(db, class_id)
