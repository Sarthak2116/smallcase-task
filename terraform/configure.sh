#!/bin/bash

curl -fsSL https://get.docker.com | sh

docker run -p 8000:8000 -d sarthak321321/sc-api:latest