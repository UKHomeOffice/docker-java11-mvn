FROM quay.io/ukhomeofficedigital/openjdk11:v11.0.11_9-2

RUN yum clean all && \
    yum update -y && \
    yum install -y git && \
    yum clean all && \
    rpm --rebuilddb

ENV HOME=/root \
    MVN_VERSION=3.8.1 \
    ARTIFACTORY_USERNAME=user \
    ARTIFACTORY_PASSWORD=pass

RUN mkdir -p $HOME/.m2/ && \
    curl -sS \
    http://www.mirrorservice.org/sites/ftp.apache.org/maven/maven-3/${MVN_VERSION}/binaries/apache-maven-${MVN_VERSION}-bin.tar.gz \
    -o /tmp/apache-maven-${MVN_VERSION}-bin.tar.gz && \
    tar xvzf /tmp/apache-maven-${MVN_VERSION}-bin.tar.gz -C /tmp && \
    mv /tmp/apache-maven-${MVN_VERSION} /var/local/ && \
    rm -- /tmp/apache-maven-${MVN_VERSION}-bin.tar.gz && \
    ln -s /var/local/apache-maven-${MVN_VERSION}/bin/mvnyjp /usr/local/bin/mvnyjp && \
    ln -s /var/local/apache-maven-${MVN_VERSION}/bin/mvnDebug /usr/local/bin/mvnDebug && \
    ln -s /var/local/apache-maven-${MVN_VERSION}/bin/mvn /usr/local/bin/mvn

RUN mkdir /app

WORKDIR /app

COPY settings.xml $HOME/.m2/

ENTRYPOINT ["/bin/bash", "-c"]

CMD ["mvn -v"]
