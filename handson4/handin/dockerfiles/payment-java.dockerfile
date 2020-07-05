FROM weaveworksdemos/payment:0.4.3

USER root

RUN apk update \
     && apk add openjdk8-jre

USER myuser

WORKDIR /usr/src/app
COPY Artifact-ddya-1.0-SNAPSHOT.jar ./app.jar
COPY a.sh ./a.sh

ENTRYPOINT ["/usr/local/bin/java.sh","-jar","./app.jar", "172.18.0.2:2181", "/payment", "/etc/hosts", "/bin/sh", "./a.sh"]
