FROM maven:3.6.0-jdk-11 as maven

MAINTAINER mehdi.elkouhen@softeam.fr

WORKDIR /apps/books

COPY pom.xml ./

RUN mvn dependency:go-offline

COPY src/ src/

RUN mvn package

FROM openjdk:11-jre-slim

COPY --from=maven /apps/books/target/books-api.jar /apps/books

EXPOSE 8080

CMD java -jar /apps/books/books-api.jar
