ARG COPY_SOURCE=false

FROM python:3.11-alpine AS base

# Install dependencies
COPY requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt && rm /tmp/requirements.txt

# Create app directory
WORKDIR /app

# Stage 1a: Do not copy files (upstream / local development)
FROM base AS copy-false
# Source files are mounted as volume (not copied)
# This allows easy editing without rebuilding

# Stage 1b: Copy files (production build / CI/CD)
FROM base AS copy-true
COPY VERSION /app/VERSION
COPY notify/ /app/notify/

# Final stage
FROM copy-${COPY_SOURCE} AS final

ENTRYPOINT ["python", "-m", "notify"]
CMD []


