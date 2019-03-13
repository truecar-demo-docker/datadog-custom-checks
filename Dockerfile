FROM datadog/agent:latest

RUN mkdir -p /mychecks/http_check.d
COPY http_check.d/*.yml /mychecks/http_check.d

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/dogstatsd", "-c", "/etc/datadog-agent/", "start"]
