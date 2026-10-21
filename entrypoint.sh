#!/bin/sh
# Build NUQ_RABBITMQ_URL and PLAYWRIGHT_MICROSERVICE_URL from the *_HOST
# values the Blueprint provides via fromService.host. Both upstream env
# vars expect fully-qualified URLs with scheme prefixes, which render.yaml
# can't construct directly.
#
# Why we hardcode the ports here instead of using fromService.hostport:
# Render's pserv port-detection picks whichever port HTTP-responds first
# inside the container. The rabbitmq:3-management image opens five ports
# (5672 AMQP, 15672 mgmt UI, 15692 prometheus, 25672 erldist, 4369 epmd)
# and Render lands on 15672 — the management HTTP UI, not AMQP. The
# Playwright image opens 3000 but multi-process variants can confuse the
# scanner. Hardcoding the well-known ports here is robust because they
# are baked into the upstream images.
set -eu

if [ -n "${NUQ_RABBITMQ_HOST:-}" ] && [ -z "${NUQ_RABBITMQ_URL:-}" ]; then
  export NUQ_RABBITMQ_URL="amqp://${NUQ_RABBITMQ_HOST}:5672"
  echo "entrypoint: NUQ_RABBITMQ_URL=${NUQ_RABBITMQ_URL}"
fi

if [ -n "${PLAYWRIGHT_HOST:-}" ] && [ -z "${PLAYWRIGHT_MICROSERVICE_URL:-}" ]; then
  export PLAYWRIGHT_MICROSERVICE_URL="http://${PLAYWRIGHT_HOST}:3000/scrape"
  echo "entrypoint: PLAYWRIGHT_MICROSERVICE_URL=${PLAYWRIGHT_MICROSERVICE_URL}"
fi

exec "$@"
