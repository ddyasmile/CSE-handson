FROM weaveworksdemos/msd-java:jre-latest

WORKDIR /usr/src/app
COPY Artifact-ddya-1.0-SNAPSHOT.jar ./app.jar
COPY a.sh ./a.sh

RUN	chown -R ${SERVICE_USER}:${SERVICE_GROUP} ./app.jar

USER ${SERVICE_USER}

ENTRYPOINT ["/usr/local/bin/java.sh","-jar","./app.jar", "172.18.0.2:2181", "/orders", "/etc/hosts", "/bin/sh", "./a.sh"]
