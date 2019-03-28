FROM datadog/agent:latest

# Remove default checks that fail in docker
COPY entrypoint.sh /
RUN chmod a+rx entrypoint.sh
COPY datadog.yaml /etc/datadog-agent/
RUN mkdir -p /myconfig/conf.d/
COPY conf.d/ /myconfig/conf.d/

ENTRYPOINT ["/entrypoint.sh"]
CMD ["agent", "-c", "/etc/datadog-agent/", "run"]
