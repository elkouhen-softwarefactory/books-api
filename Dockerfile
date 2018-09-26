FROM java:8

MAINTAINER mehdi.elkouhen@softeam.fr

WORKDIR /apps/helloworld-simple

COPY build/libs/helloworld-simple-*.jar /apps/helloworld-simple/helloworld-simple.jar

EXPOSE 8080

CMD java -jar helloworld-simple.jar