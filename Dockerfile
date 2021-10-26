FROM ghcr.io/lorislab/samo:3.0.0 as samo

FROM node:12

RUN apt-get update && apt-get install -y jq 

COPY --from=samo /usr/bin/samo /usr/local/bin/samo

