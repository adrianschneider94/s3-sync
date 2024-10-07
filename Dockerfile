ARG MC_VERSION=latest
FROM minio/mc:${MC_VERSION}


COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]