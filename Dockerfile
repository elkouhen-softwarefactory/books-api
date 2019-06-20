FROM maven:3.6.1-jdk-12

MAINTAINER melkouhen@ippon.fr

WORKDIR /apps/books

COPY pom.xml ./

RUN mvn dependency:go-offline

COPY src/ src/

RUN mvn clean package

EXPOSE 8080

CMD java -jar /apps/books/target/books-api.jar
