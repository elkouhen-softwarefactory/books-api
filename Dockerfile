FROM maven:3.6.0-jdk-8

ARG SONAR_TOKEN

MAINTAINER mehdi.elkouhen@softeam.fr

WORKDIR /apps/books

COPY pom.xml ./

RUN mvn dependency:go-offline

COPY src/ src/

RUN mvn package

RUN mvn sonar:sonar -Dsonar.host.url=https://sonarqube.k8.wildwidewest.xyz -Dsonar.login=$SONAR_TOKEN

EXPOSE 8080

CMD java -jar /apps/books/target/books-api.jar
