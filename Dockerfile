FROM openliberty/open-liberty:full-java8-openj9-ubi
#FROM ol:kernel-ubi
#FROM openliberty/open-liberty:19.0.0.6-javaee7-ubi-min
USER root
COPY ./liberty/server.xml /config
COPY ./liberty/jvm.options /config

COPY ./CustomerOrderServicesApp/target/CustomerOrderServicesApp-0.1.0-SNAPSHOT.ear /config/apps/CustomerOrderServicesApp-0.1.0-SNAPSHOT.ear
COPY ./resources/ /opt/ol/wlp/usr/shared/resources/
RUN chown -R 1001.0 /config /opt/ol/wlp/usr/servers/defaultServer /opt/ol/wlp/usr/shared/resources && chmod -R g+rw /config /opt/ol/wlp/usr/servers/defaultServer  /opt/ol/wlp/usr/shared/resources

USER 1001
RUN configure.sh
