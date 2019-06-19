FROM maven:3.6.1-jdk-12

ARG SONAR_TOKEN

MAINTAINER melkouhen@ippon.fr

WORKDIR /apps/books

COPY pom.xml ./

RUN mvn dependency:go-offline

COPY src/ src/

RUN mvn clean package

EXPOSE 8080

EXPOSE 5005

CMD java -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005 -jar /apps/books/target/books-api.jar
