FROM java:8-alpine

WORKDIR /root

COPY script.sh .
RUN mkdir -p /opt \
    && cd /opt \
    && wget -q http://apache.mirrors.spacedump.net/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz \
    && tar -xf apache-maven-3.3.9-bin.tar.gz \
    && ln -s apache-maven-3.3.9 maven

ENV PATH=/opt/maven/bin:$PATH

ENTRYPOINT [ "/root/script.sh" ]