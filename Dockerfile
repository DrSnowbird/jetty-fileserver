FROM openkbs/jre-base

MAINTAINER DrSnowbird "DrSnowbird@openkbs.org"

#### ---- User setup ----
ARG USER_ID=${USER_ID:-1000}
ENV USER_ID=${USER_ID}

ARG GROUP_ID=${GROUP_ID:-1000}
ENV GROUP_ID=${GROUP_ID}
    
ARG USER_NAME=${USER_NAME:-developer}
ENV USER_NAME=${USER_NAME}

ENV HOME=/home/${USER_NAME}

RUN \
    useradd -ms /bin/bash ${USER_NAME} && \
    export uid=${USER_ID} gid=${GROUP_ID} && \
    mkdir -p /home/${USER_NAME} && \
    mkdir -p /home/${USER_NAME}/workspace && \
    mkdir -p /etc/sudoers.d && \
    echo "${USER_NAME}:x:${USER_ID}:${GROUP_ID}:${USER_NAME},,,:/home/${USER_NAME}:/bin/bash" >> /etc/passwd && \
    echo "${USER_NAME}:x:${USER_ID}:" >> /etc/group && \
    echo "${USER_NAME} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${USER_NAME} && \
    chmod 0440 /etc/sudoers.d/${USER_NAME} && \
    chown ${USER_NAME}:${USER_NAME} -R /home/${USER_NAME}

ENV JETTY_BASE=${HOME}/jetty_base

#### ---- Copy "jetty_base" as customized "webapps" directory ---
#ADD jetty_base ${JETTY_BASE}

#### ---- Jetty setup ----
ARG JETTY_DOWNLOAD=${JETTY_DOWNLOAD:-http://central.maven.org/maven2/org/eclipse/jetty/jetty-distribution/9.4.6.v20170531/jetty-distribution-9.4.6.v20170531.tar.gz}
ENV JETTY_DOWNLOAD=${JETTY_DOWNLOAD}

ENV JETTY_DISTRIBUTION=jetty-distribution-9.4.6.v20170531
ENV JETTY_TAR_FILE=${JETTY_DISTRIBUTION}.tar.gz

ENV JETTY_HOME=${HOME}/${JETTY_DISTRIBUTION}
ENV JETTY_WEBAPPS=${JETTY_HOME}/webapps

WORKDIR ${HOME}

#### ---- !! Remember to comment out the COPY below when deployed ----
## -- Local dev mode --
#COPY ${JETTY_TAR_FILE} ${HOME}/

#### ---- !! Remember to uncomment wget below when deployed ----
## -- Deploy mode --
RUN wget -c ${JETTY_DOWNLOAD} 

RUN tar xvf ${JETTY_TAR_FILE} && \
    rm ${JETTY_TAR_FILE} && \
    ln -s ${JETTY_WEBAPPS} /jetty_base  && \
    chown ${USER_NAME}:${USER_NAME} -R /home/${USER_NAME} && \
    chown ${USER_NAME}:${USER_NAME} /jetty_base

#RUN echo "----------- debug -----------" && \
#    ls -al $JETTY_HOME && \
#    ls -al $JETTY_HOME/start.jar && \
#    ls -al /home/developer/jetty-distribution-9.4.6.v20170531 && \
#    ls ${HOME}

#### ---- Change to user mode ----
USER ${USER_NAME}

#### ----- jetty_base: for user's webapp directory for Jetty as FTP file server ----   
VOLUME /jetty_base

WORKDIR ${JETTY_HOME}
EXPOSE 8080

#### ---- Run/Start Jetty Server now ----
#ENTRYPOINT "/usr/java/bin/java" "-jar" "$JETTY_HOME/start.jar"
copy entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
CMD "/usr/java/bin/java" "-jar" "$JETTY_HOME/start.jar"

