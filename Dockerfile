FROM openjdk:11

RUN apt update && apt install git curl ruby -y

ENV LOGSTASH_SOURCE=1
ENV LOGSTASH_PATH=/logstash-source

RUN git clone https://github.com/elastic/logstash.git /logstash-source
RUN cd /logstash-source && rake bootstrap