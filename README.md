# Datadog agent listener and active check runner

[BuildKite](https://buildkite.com/truecar/datadog-custom-checks)

## Overview

This docker image uses the datadog agent in a docker container to be able to ~listen for
metrics on the dstatsd port (UDP)~ and also to run any active checks that are required.

Currently the main use case is for active HTTP checks as defined in [/http_check.d/]
