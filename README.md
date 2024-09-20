# GymRats Image Server

This repository contains an image server built with Python and Flask Rest X. The server allows for image storage and management using two storage modes: **LOCAL_STORAGE** or **B2_STORAGE**.

## Requirements

- **Docker**: Make sure Docker is installed on your system. If you don't have it yet, follow the installation instructions from the [official Docker page](https://docs.docker.com/get-docker/).

## Configuration

### 1. Environment file `.env`

You need to copy the `.env.template` file and rename it to `.env`. This file will contain the necessary environment variables to configure the storage system.

```bash
cp .env.template .env
```


> **NOTE**: Do not forget to fill it.



## Usage

### 1. docker-compose command

For starting the service, run:

```
docker-compose up --build
```

For running it in background, run:

```
docker-compose up -d --build
```


### 2. Access to Swagger doc

Go to next link and you must see the Swagger documention of the project:

[localhost:5003](http://localhost:5003)
