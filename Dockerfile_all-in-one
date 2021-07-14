FROM openkbs/jdk-mvn-py3

MAINTAINER DrSnowbird "DrSnowbird@openkbs.org"

#### ------------------------------------------------------------------------
#### ---- User setup so we don't use root as user ----
#### ------------------------------------------------------------------------
ARG USER_ID=${USER_ID:-1000}
ENV USER_ID=${USER_ID}

ARG GROUP_ID=${GROUP_ID:-1000}
ENV GROUP_ID=${GROUP_ID}
    
ARG USER=${USER:-developer}
ENV USER=${USER}

ENV HOME=/home/${USER}
ENV JETTY_BASE=${HOME}/jetty_base
ENV WORKSPACE=${HOME}/workspace

#### ------------------------------------------------------------------------
#### ---- Install Jetty  ----
#### ------------------------------------------------------------------------
ENV JETTY_VERSION=9.4.30.v20200611

#RUN useradd -ms /bin/bash ${USER} && \
#    export uid=${USER_ID} gid=${GROUP_ID} && \
#    mkdir -p /home/${USER} && \
#    mkdir -p /home/${USER}/workspace && \
#    mkdir -p /etc/sudoers.d && \
#    echo "${USER}:x:${USER_ID}:${GROUP_ID}:${USER},,,:/home/${USER}:/bin/bash" >> /etc/passwd && \
#    echo "${USER}:x:${USER_ID}:" >> /etc/group && \
#    echo "${USER} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${USER} && \
#    chmod 0440 /etc/sudoers.d/${USER} && \
#    chown ${USER}:${USER} -R /home/${USER}

#### ---- Copy "jetty_base" as customized "webapps" directory ---
#ADD jetty_base ${JETTY_BASE}

#### ------------------------------------------------------------------------
#### ---- Jetty environment vars ----
#### ------------------------------------------------------------------------
# https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-distribution/9.4.30.v20200611/jetty-distribution-9.4.30.v20200611.tar.gz
ARG JETTY_DOWNLOAD=${JETTY_DOWNLOAD:-https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-distribution/${JETTY_VERSION}/jetty-distribution-${JETTY_VERSION}.tar.gz}

ENV JETTY_DISTRIBUTION=jetty-distribution-${JETTY_VERSION}
ARG JETTY_TAR_FILE=${JETTY_DISTRIBUTION}.tar.gz

ENV JETTY_HOME=${HOME}/${JETTY_DISTRIBUTION}
ENV JETTY_WEBAPPS=${JETTY_HOME}/webapps

WORKDIR ${HOME}

#### ------------------------------------------------------------------------
#### ---- Entrypoint setup -----
#### ------------------------------------------------------------------------
COPY entrypoint.sh /
RUN sudo chmod +x /entrypoint.sh 

#### ------------------------------------------------------------------------
#### ---- Jetty setup ----
#### ------------------------------------------------------------------------

#### ---- !! Remember to uncomment wget below when deployed ----
## -- Deploy mode --
RUN wget -q -c --no-check-certificate ${JETTY_DOWNLOAD} 

RUN tar xvf ${JETTY_TAR_FILE} && \
    rm ${JETTY_TAR_FILE} && \
    mkdir -p ${JETTY_WEBAPPS}/$(basename ${JETTY_BASE}) && \
    ln -s ${JETTY_WEBAPPS}/$(basename ${JETTY_BASE}) ${JETTY_BASE} && \
    mkdir -p ${WORKSPACE}  && \
    sudo chown -R ${USER}:${USER} ${JETTY_BASE} 

#### ------------------------------------------------------------------------
#### ---- Change to user mode ----
#### ------------------------------------------------------------------------
USER ${USER}

#### ----- jetty_base: for user's webapp directory for Jetty as FTP file server ----   
VOLUME ${JETTY_BASE} 
VOLUME ${WORKSPACE} 

USER ${USER}
WORKDIR ${JETTY_HOME}
EXPOSE 8080

#### ---- Run/Start Jetty Server now ----
ENTRYPOINT ["/entrypoint.sh"]
#CMD "/usr/java/bin/java" "-jar" "$JETTY_HOME/start.jar"
CMD "${JAVA_HOME}/bin/java" "-jar" "$JETTY_HOME/start.jar"

