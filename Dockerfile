FROM datamgtcloud/basejava

# consul scripts
# Set up consul as a runit service
COPY config-consul.json /etc/consul.d/
COPY start.sh /usr/runit/consul/run.sh
RUN \
  mkdir -p /etc/service/consul && \
  ln -s /usr/runit/consul/run.sh /etc/service/consul/run

ADD boot.sh /sbin/boot


# java scripts
COPY startContainer.sh /usr/bin/.
COPY docker/consul.d/ /etc/consul.d/

# Copy application code.
COPY . /app/
WORKDIR /app
RUN ./assembleService.sh

CMD ["/sbin/boot"]
