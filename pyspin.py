#!/usr/bin/env python3
import os

def main():
    dockerfile = """\
FROM python:3.12-slim
WORKDIR /app
COPY . /app
CMD ["python3"]
"""
    compose = """\
services:
  app:
    build: .
    volumes:
      - .:/app
    tty: true
"""

    if not os.path.exists("Dockerfile"):
        with open("Dockerfile", "w") as f:
            f.write(dockerfile)
    if not os.path.exists("docker-compose.yml"):
        with open("docker-compose.yml", "w") as f:
            f.write(compose)

    print("✅ Fichiers Dockerfile et docker-compose.yml créés dans le dossier courant !")

if __name__ == "__main__":
    main()
