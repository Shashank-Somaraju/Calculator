FROM openjdk:15-alpine
ADD target/*.jar .
ENTRYPOINT java -jar *.jar