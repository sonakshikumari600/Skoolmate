from fastapi import APIRouter

from app.routes import (
    auth,
    users,
    attendance,
    homework,
    exams,
    messages,
    notifications,
    notices,
    leaves,
    timetables,
    fees,
    classes,
)

api_router = APIRouter(prefix="/api/v1")

api_router.include_router(auth.router)
api_router.include_router(users.router)
api_router.include_router(attendance.router)
api_router.include_router(homework.router)
api_router.include_router(exams.router)
api_router.include_router(messages.router)
api_router.include_router(notifications.router)
api_router.include_router(notices.router)
api_router.include_router(leaves.router)
api_router.include_router(timetables.router)
api_router.include_router(fees.router)
api_router.include_router(classes.router)
