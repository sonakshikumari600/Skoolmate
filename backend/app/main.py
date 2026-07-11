from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from app.api.router import api_router
from app.database.session import engine
from app.models import models  # noqa: F401 — ensures all models are registered


def create_app() -> FastAPI:
    application = FastAPI(
        title="Skoolmate API",
        version="1.0.0",
        description="REST backend replacing Firebase for the Skoolmate Flutter app",
        docs_url="/docs",
        redoc_url="/redoc",
    )

    # ── CORS ──────────────────────────────────────────────────────────────────
    application.add_middleware(
        CORSMiddleware,
        allow_origins=["*"],   # tighten in production
        allow_credentials=True,
        allow_methods=["*"],
        allow_headers=["*"],
    )

    # ── Routes ────────────────────────────────────────────────────────────────
    application.include_router(api_router)

    # ── Health check ─────────────────────────────────────────────────────────
    @application.get("/", tags=["Health"])
    def root():
        return {"status": "ok", "message": "Skoolmate API is running"}

    @application.get("/health", tags=["Health"])
    def health():
        return {"status": "ok"}

    return application


app = create_app()
