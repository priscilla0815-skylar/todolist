FROM python:3.12-alpine

ENV HOST=0.0.0.0 \
    PORT=3000 \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

RUN addgroup -S app && adduser -S -G app app

COPY --chown=app:app index.html server.py ./

USER app

EXPOSE 3000

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget -q -O - "http://127.0.0.1:${PORT}/healthz" >/dev/null || exit 1

CMD ["python3", "server.py"]
