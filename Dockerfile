# For more information, please refer to https://aka.ms/vscode-docker-python
FROM python:3.9-slim-buster

# Keeps Python from generating .pyc files in the container
#ENV PYTHONDONTWRITEBYTECODE=1

# Turns off buffering for easier container logging
#ENV PYTHONUNBUFFERED=1

#Install other necessary packages
RUN apt-get update && apt-get install procps grep -y

# Install pip requirements
RUN mkdir -p /opt/app
RUN mkdir -p /opt/app/pip_cache
RUN mkdir -p /opt/app/iotmsgprocessing

COPY requirements.txt /opt/app 
COPY iotmsgprocessing /opt/app/iotmsgprocessing

WORKDIR /opt/app
RUN python -m pip install -r requirements.txt --cache-dir /opt/app/pip_cache

RUN chown -R www-data:www-data /opt/app

# Creates a non-root user with an explicit UID and adds permission to access the /app folder
# For more info, please refer to https://aka.ms/vscode-docker-python-configure-containers
#RUN adduser -u 5678 --disabled-password --gecos "" appuser && chown -R appuser /app
#USER appuser

# During debugging, this entry point will be overridden. For more information, please refer to https://aka.ms/vscode-docker-python-debug
CMD ["python", "/opt/app/iotmsgprocessing/test.py"]
