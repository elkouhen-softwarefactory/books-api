FROM java:8

MAINTAINER mehdi.elkouhen@softeam.fr

WORKDIR /apps/referentiel-personnes-api

COPY build/libs/referentiel-personnes-api.jar /apps/referentiel-personnes-api/referentiel-personnes-api.jar

EXPOSE 8080

CMD java -jar referentiel-personnes-api.jar