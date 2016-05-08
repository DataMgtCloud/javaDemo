FROM datamgtcloud/baseos

#executables
RUN mkdir -p /opt/datamgt/bin/

# data directory
RUN mkdir -p /opt/datamgt/config/srv/consul

RUN \
  curl -s https://releases.hashicorp.com/consul/0.6.4/consul_0.6.4_linux_amd64.zip -o consul.zip && \
  unzip consul.zip && \
  rm consul.zip && \
  mv consul /opt/datamgt/bin/


# Set up consul as a runit service
COPY config-consul.json /etc/consul.d/
COPY start.sh /usr/runit/consul/run.sh
RUN \
  mkdir -p /etc/service/consul && \
  ln -s /usr/runit/consul/run.sh /etc/service/consul/run

# Build user, group, and home dir for services
RUN \
  mkdir /home/svc && \
  groupadd -g 616 svc && \
  useradd -u 616 -g svc -d /home/svc -s /sbin/nologin -c "Service user" svc && \
  chown -R svc:svc /home/svc

# expose Consul client agent ports
EXPOSE 8301 8301/udp

ADD boot.sh /sbin/boot


RUN \
  apt-get update && \
  apt-get -y install aptitude openjdk-8-jdk gradle && \
  apt-get clean

COPY startContainer.sh /usr/bin/

COPY docker/consul.d/ /etc/consul.d/

RUN \
  curl -s http://120.52.73.80/central.maven.org/maven2/org/aspectj/aspectjweaver/1.8.6/aspectjweaver-1.8.6.jar -o aspectjweaver-1.8.6.jar && \
  mkdir /opt/jars/ && \
  mv aspectjweaver-1.8.6.jar /opt/jars/

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/jre

RUN ln -s $JAVA_HOME /opt/java


# Copy application code.
COPY . /app/
WORKDIR /app
RUN ./assembleService.sh


CMD ["/sbin/boot"]
