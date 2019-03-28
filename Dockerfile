FROM datadog/agent:latest

RUN apt-get update && apt-get install -y \
  busybox \
  && rm -rf /var/lib/apt/lists/*
RUN mkdir -p /httpd
COPY httpd/ /httpd/

COPY entrypoint.sh /
RUN chmod a+rx entrypoint.sh
COPY datadog.yaml /etc/datadog-agent/
RUN mkdir -p /myconfig/conf.d/
COPY conf.d/ /myconfig/conf.d/

EXPOSE 8080
ENTRYPOINT ["/entrypoint.sh"]
CMD ["agent", "-c", "/etc/datadog-agent/", "run"]
