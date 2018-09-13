FROM java:8

MAINTAINER mehdi.elkouhen@softeam.fr

WORKDIR /apps/skills-api

COPY build/libs/skills-api.jar /apps/skills-api/skills-api.jar

EXPOSE 8080

CMD java -jar skills-api.jar