FROM openjdk:8-slim

COPY target/discovery_server*.jar /discovery_server.jar

CMD java -jar /discovery_server.jar

