FROM ibmcom/websphere-traditional:9.0.5.0-ubi

COPY config/PASSWORD /tmp/PASSWORD

COPY resources/db2/ /opt/IBM/db2drivers/

COPY config/cosConfig.py /work/config/

COPY config/app-update.props  /work/config/app-update.props

COPY app/CustomerOrderServicesApp-0.1.0-SNAPSHOT.ear /work/apps/CustomerOrderServicesApp.ear

RUN /work/configure.sh