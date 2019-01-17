#/usr/bin/env bash

docker build --tag adamhepner/silenteight .
docker-compose -f selenium.yml up -d
docker run --rm -ti --network host --volume "$PWD/tests":/home/robot/tests --volume "$PWD/results":/home/robot/results adamhepner/silenteight tests
docker-compose -f selenium.yml stop