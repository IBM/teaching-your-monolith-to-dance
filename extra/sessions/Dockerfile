FROM ibmcom/websphere-traditional:9.0.0.11

#Hardcode password for admin console

COPY PASSWORD /tmp/PASSWORD

COPY db2/ /opt/IBM/db2drivers/

COPY sessConfig.py /work/config/

COPY app-install.props  /work/config/app-install.props

COPY SessionSample-1.0.war /work/apps/SessionSample-1.0.war

RUN /work/configure.sh
