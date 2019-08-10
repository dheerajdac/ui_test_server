FROM openjdk:8-slim

COPY target/ui*.jar /server.jar

CMD java -jar /server.jar

