FROM maven:3.6.1-jdk-12

MAINTAINER melkouhen@ippon.fr

WORKDIR /apps/books

COPY pom.xml ./

RUN mvn dependency:go-offline

COPY src/ src/

RUN mvn clean package

EXPOSE 8080

EXPOSE 5005

ENV JAVA_OPTS -agentlib:jdwp=transport=dt_socket,server=y,address=5005,suspend=n

CMD java $JAVA_OPTS -jar /apps/books/target/books-api.jar
