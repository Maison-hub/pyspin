#!/usr/bin/env python3
import os

def init_project():
    dockerfile = """\
FROM python:3.11-slim

# Définit le répertoire de travail dans le container
# Define the working directory inside the container
WORKDIR /app

# Copie les fichiers Python dans le container
# Copy the Python files into the container
COPY *.py .

# Optionnal : If you have a requirements.txt file
# COPY requirements.txt .
# RUN pip install --no-cache-dir -r requirements.txt

# Commande par défaut : shell interactif
CMD ["/bin/bash"]
"""
    compose = """\
services:
  python:
    build: .
    volumes:
      - .:/app
    working_dir: /app
    tty: true
    stdin_open: true
"""

    if not os.path.exists("Dockerfile"):
        with open("Dockerfile", "w") as f:
            f.write(dockerfile)
    if not os.path.exists("docker-compose.yml"):
        with open("docker-compose.yml", "w") as f:
            f.write(compose)

    print("✅ Dockerfile and compose.yml created !")
