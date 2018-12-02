FROM maven:3.6.0-jdk-11

MAINTAINER mehdi.elkouhen@softeam.fr

WORKDIR /apps/books

COPY pom.xml ./

RUN mvn dependency:go-offline

COPY src/ src/

RUN mvn package

EXPOSE 8080

CMD java -jar /apps/books/target/books-api.jar
