# Use the latest Ubuntu base image
FROM ubuntu:latest 

# Update and install required dependencies
RUN apt-get update -y && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends gcc libffi-dev musl-dev ffmpeg aria2 python3-pip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy application files into the container
COPY . /app/

# Set the working directory
WORKDIR /app/

# Install Python dependencies from requirements.txt
# Ensure requirements.txt exists in the copied files
RUN pip3 install --no-cache-dir --upgrade --requirement installer

# Specify the command to run the application
CMD ["gunicorn", "app:modules"] & ["python3", "main.py"]
