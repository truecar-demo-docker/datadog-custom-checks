# HTTP active checks

## Overview

This directory contains active HTTP checks that will be copied into the datadog agent directory to run active checks for each environment. Currently, there is no good way to template these files so they are duplicated and hardcoded for now. If you have a better idea, please submit a PR.

The Dockerfile entrypoint script should copy only the files that are available for an environment (specified in SPACEPODS_ENV).

Example configuration section:

```YAML
init_config:

instances:
  - name: myservice
    url: https://myservice.qa.pod.tc/internal/health
    timeout: 2
    method: get
    content_match: 'IMOK'
    reverse_content_match: false
    http_response_status_code: (2|3)\d\d
    include_content: true
    collect_response_time: true
    disable_ssl_validation: false
    check_certificate_expiration: true
    days_warning: 45
    days_critical: 15
    check_hostname: true
    headers:
      X-User-Agent: Truecar Datadog Health Chequer 0.1
    skip_proxy: true
    allow_redirects: false
    stream: false
    include_default_headers: true
    tags:
      - service:myservice
      - escalate:false
```
