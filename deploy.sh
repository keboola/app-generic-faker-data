#!/bin/bash
set -e

# deploy to Quay public repository
docker login -u="$QUAY_USERNAME" -p="$QUAY_PASSWORD" quay.io
#docker tag mock-server quay.io/keboola/app-generic-faker:${TRAVIS_TAG}
docker tag mock-server quay.io/keboola/app-generic-faker:latest
docker images
#docker push quay.io/keboola/app-generic-faker:${TRAVIS_TAG}
docker push quay.io/keboola/app-generic-faker:latest

pip install awscli --upgrade --user

#aws ecs run-task --cluster ${AWS_CLUSTER} --started-by TravisCI --task-definition generic_faker
COMMAND_RESULT=$(aws ecs register-task-definition --cli-input-json file://${TRAVIS_BUILD_DIR}/task-def.json)
REVISION=$(echo ${COMMAND_RESULT} | grep -o '"revision": [0-9]*' | grep -o '[0-9]*')
echo "Using revision ${REVISION}"
aws ecs update-service --cluster ${AWS_CLUSTER} --service generic_faker --task-definition generic_faker:${REVISION}
