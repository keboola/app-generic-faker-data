# Generic Faker Data

[![Build Status](https://travis-ci.org/keboola/app-generic-faker-data.svg?branch=master)](https://travis-ci.org/keboola/app-generic-faker-data)

Repository contains data for fake JSON responses for [Mock server](https://github.com/keboola/ex-generic-mock-server). Repository contents are generated using
[Generic Faker](https://github.com/keboola/app-generic-faker) KBC component. 

## Workflow
When something is pushed into this reposiotry, a Travis job builds a docker image with the mock server and data from this repository using 
[`script` in `.travis.yml`](https://github.com/keboola/app-generic-faker-data/blob/master/.travis.yml#L7):

- clone mock server
- replace sample data with the contents of this repository
- build the image

And then deploys the image using [`deploy.sh`](https://github.com/keboola/app-generic-faker-data/blob/master/deploy.sh)

- push image to quay
- register new AWS ECR task definition (otherwise the service won't restart the task)
- update AWS ECR service with new task revision

## Configuration
The following environment variables are required:

- `QUAY_PASSWORD`
- `QUAY_USERNAME`
- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `AWS_DEFAULT_REGION`
- `AWS_CLUSTER`
