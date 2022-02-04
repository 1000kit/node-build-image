FROM ghcr.io/lorislab/samo:3.0.0 as samo

FROM node:16

RUN apt-get update && apt-get install -y jq chromium 

COPY --from=samo /usr/bin/samo /usr/local/bin/samo

ENV CHROMIUM_FLAGS="--no-sandbox"
ENV CHROME_BIN=/usr/bin/chromium
