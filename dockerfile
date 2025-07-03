# Stage 1: Python Flask app
FROM python:3.9-slim AS flask-app
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
EXPOSE 5000
CMD ["python", "app.py"]

# Stage 2: Lightweight Jenkins agent (with nc)
FROM alpine:latest AS jenkins-agent
RUN apk add --no-cache netcat-openbsd curl