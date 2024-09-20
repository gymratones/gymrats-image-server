FROM python:3.11-slim

RUN apt-get update -y && apt-get install -y gcc

WORKDIR /python-docker

COPY requirements.txt requirements.txt

RUN pip3 install -Ur requirements.txt

COPY . .

CMD exec flask --debug run --host=0.0.0.0 --port 5000