FROM datadog/agent:latest

RUN apt-get update && yes | apt-get upgrade --with-new-pkgs -y  \
  awscli \
  busybox \
  wget \
  && rm -rf /var/lib/apt/lists/*
RUN mkdir -p /httpd
COPY httpd/ /httpd/

ADD https://raw.git.corp.tc/infra/universal-build-script/master/secrets.sh .
RUN chmod +rx ./secrets.sh

COPY entrypoint.sh /
RUN chmod a+rx entrypoint.sh
COPY datadog.yaml /etc/datadog-agent/
RUN mkdir -p /myconfig/conf.d/
COPY conf.d/ /myconfig/conf.d/

EXPOSE 8080
ENTRYPOINT ["/entrypoint.sh"]
CMD ["agent", "-c", "/etc/datadog-agent/", "run"]
