FROM maven:3.6.0-jdk-11

MAINTAINER mehdi.elkouhen@softeam.fr

WORKDIR /apps/books

COPY pom.xml ./

RUN mvn dependency:go-offline -B

COPY src/ src/

RUN mvn package

# FROM openjdk:11-jre-slim

EXPOSE 8080

CMD java -jar target/books-api.jar
