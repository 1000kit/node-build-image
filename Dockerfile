FROM ghcr.io/lorislab/samo:3.0.0 as samo

FROM node:14

RUN apt-get update && apt-get install -y jq chromium git

COPY --from=samo /usr/bin/samo /usr/local/bin/samo

LABEL org.opencontainers.image.source https://github.com/1000kit/node-build-image

ENV CHROMIUM_FLAGS="--no-sandbox"
ENV CHROME_BIN=/usr/bin/chromium
