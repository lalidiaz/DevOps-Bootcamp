FROM python:alpine

WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    FLASK_APP=app.py

# Install build dependencies
RUN apk add --no-cache build-base

# Create a non-root user
RUN adduser --disabled-password --no-create-home appuser

# Copy requirements first to leverage Docker cache
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Set proper permissions
RUN chown -R appuser:appuser /app
USER appuser

EXPOSE 8000

CMD ["python", "app.py"]