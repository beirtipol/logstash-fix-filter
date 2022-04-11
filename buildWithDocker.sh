#!/bin/bash
docker build -t logstash-build-base .
docker run -it --rm -v $(pwd):/logstash-fix-filter logstash-build-base /bin/bash -c "cd /logstash-fix-filter && chmod u+x ./gradlew && ./gradlew gem"
