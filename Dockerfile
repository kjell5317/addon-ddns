ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

COPY run.sh /
RUN chmod +x /run.sh

CMD [ "/run.sh" ]
