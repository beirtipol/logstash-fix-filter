docker build -t logstash-build-base .
docker run -it --rm -v %cd%:/logstash-fix-filter logstash-build-base /bin/bash -c "cd /logstash-fix-filter && ./gradlew gem"
