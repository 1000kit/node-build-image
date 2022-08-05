FROM ghcr.io/lorislab/samo:3.0.0 as samo

FROM node:16
ARG VERSION=v4.25.3
ARG BINARY=yq_linux_amd64
RUN apt-get update && apt-get install -y jq chromium git
RUN apt-get update \
    && apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common curl ca-certificates lsb-release \
    libgtk2.0-0 libgtk-3-0 libgbm-dev libnotify-dev libgconf-2-4 libnss3 libxss1 libasound2 libxtst6 xauth xvfb \
    && curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - \
    && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" \
    && apt-get update \
    && apt-get install -y docker-ce \
    && wget https://github.com/mikefarah/yq/releases/download/${VERSION}/${BINARY} -O /usr/bin/yq &&\
    chmod +x /usr/bin/yq

COPY --from=samo /usr/bin/samo /usr/local/bin/samo
COPY --from=samo /usr/bin/helm /usr/bin/helm

LABEL org.opencontainers.image.source https://github.com/1000kit/node-build-image

ENV CHROMIUM_FLAGS="--no-sandbox"
ENV CHROME_BIN=/usr/bin/chromium
