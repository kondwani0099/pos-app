# Use the official Python image
FROM python:3.11-slim

# Set the working directory in the container
WORKDIR /app

# Copy the application code into the container
COPY . /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    libpq-dev \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Run database migrations
RUN python manage.py migrate

# Expose the port the app runs on
EXPOSE 8000

# Set the default command to run the Django development server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
