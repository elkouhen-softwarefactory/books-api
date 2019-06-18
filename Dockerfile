FROM maven:3.6.0-jdk-8

ARG SONAR_TOKEN

MAINTAINER melkouhen@ippon.fr

WORKDIR /apps/books

COPY pom.xml ./

RUN mvn dependency:go-offline

COPY src/ src/

RUN mvn clean package

EXPOSE 8080

CMD java -jar /apps/books/target/books-api.jar
