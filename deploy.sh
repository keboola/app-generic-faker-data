#!/bin/bash
set -e

# deploy to Quay public repository
docker login -u="$QUAY_USERNAME" -p="$QUAY_PASSWORD" quay.io
docker tag mock-server quay.io/keboola/app-generic-faker:${TRAVIS_TAG}
docker tag mock-server quay.io/keboola/app-generic-faker:latest
docker images
docker push quay.io/keboola/app-generic-faker:${TRAVIS_TAG}
docker push quay.io/keboola/app-generic-faker:latest
