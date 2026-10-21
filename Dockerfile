# Thin wrapper around the upstream Firecrawl image.
#
# Why this exists: render.yaml's `fromService` can return internal hostnames
# (suffixed slugs like firecrawl-postgres-ab12) but cannot string-concat them
# into URLs that need `amqp://` or `http://` prefixes. This entrypoint builds
# those URLs at container start from `*_HOSTPORT` env vars the Blueprint
# wires via `fromService.property: hostport`.
#
# Pin the upstream tag in render.yaml's build arg; do not edit the FROM line.
ARG FIRECRAWL_IMAGE=ghcr.io/firecrawl/firecrawl:latest
FROM ${FIRECRAWL_IMAGE}

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["node", "dist/src/harness.js", "--start-docker"]
