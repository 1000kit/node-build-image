FROM ghcr.io/lorislab/samo:3.0.0 as samo

FROM node:16

RUN apt-get update && apt-get install -y jq chromium 
RUN apt-get update \
    && apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common curl ca-certificates lsb-release \
    && curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - \
    && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" \
    && apt-get update \
    && apt-get install -y docker-ce

COPY --from=samo /usr/bin/samo /usr/local/bin/samo
COPY --from=samo /usr/bin/helm /usr/bin/helm

ENV CHROMIUM_FLAGS="--no-sandbox"
ENV CHROME_BIN=/usr/bin/chromium
