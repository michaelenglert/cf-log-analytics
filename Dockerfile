# DOC:Downloads the Analytics Agent (latest) from AppD. Needs java and logs folder as volumes when running the container.

FROM debian:jessie
MAINTAINER Michael Englert <michi.eng@gmail.com>

ARG HOST_NAME
ARG ACCESS_KEY
ARG USER
ARG PASSWORD
ARG BASEURL
ARG VERSION
ARG EVENTS_PORT
ARG GLOBAL_NAME

ENV APPDYNAMICS_CONTROLLER_HOST_NAME=$HOST_NAME \
    APPDYNAMICS_AGENT_ACCOUNT_ACCESS_KEY=$ACCESS_KEY \
    PATH="$PATH:/java/bin" \
    JAVA_HOME="/java" \
    APPDYNAMICS_AGENT_BASE_DIR="/"

VOLUME /java

RUN apt-get update \
    && apt-get install -q -y vim curl unzip \
    && curl --referer http://www.appdynamics.com -c cookies.txt -d "username=$USER&password=$PASSWORD" https://login.appdynamics.com/sso/login/ \
    && curl -L -o /analytics-agent.zip -b ./cookies.txt $BASEURL/analytics/$VERSION/analytics-agent-$VERSION.zip \
    && unzip /analytics-agent.zip \
    && rm -rf /analytics-agent.zip /cookies.txt /index.html \
    && sed -i -e "s/<enabled>false<\/enabled>/<enabled>true<\/enabled>/g" /analytics-agent/monitor.xml \
    && sed -i -e "s/localhost:9080/$HOST_NAME:$EVENTS_PORT/g" /analytics-agent/conf/analytics-agent.properties \
    && sed -i -e "s/analytics-customer1/$GLOBAL_NAME/g" /analytics-agent/conf/analytics-agent.properties \
    && sed -i -e "s/your-account-access-key/$ACCESS_KEY/g" /analytics-agent/conf/analytics-agent.properties \
    && apt-get remove --purge -q -y curl unzip \
    && apt-get autoremove -q -y \
    && apt-get clean -q -y \
    && rm -rf /tmp/*

ADD cf.job /analytics-agent/conf/job/

CMD /analytics-agent/bin/analytics-agent.sh start
