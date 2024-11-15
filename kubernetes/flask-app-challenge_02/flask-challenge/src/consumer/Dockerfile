# Use official Python slim image as base
FROM python:alpine

# Set working directory
WORKDIR /app

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Create a non-root user for security
RUN adduser --disabled-password --no-create-home appuser

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY consumer.py .

# Set proper permissions
RUN chown -R appuser:appuser /app
USER appuser

# Run the consumer script
CMD ["python", "consumer.py"]