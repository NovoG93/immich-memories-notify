# Immich Memories Notify
# Lightweight Python container for sending memory notifications

FROM python:3.11-alpine

# Install dependencies
COPY requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt && rm /tmp/requirements.txt

# Create app directory
WORKDIR /app

# Copy source files
COPY VERSION /app/VERSION
COPY notify/ /app/notify/

ENTRYPOINT ["python", "-m", "notify"]
CMD []
