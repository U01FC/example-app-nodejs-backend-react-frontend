FROM ubuntu:20.04
EXPOSE 3000
WORKDIR /var/www/example
COPY . ./

ENV DEBIAN_FRONTEND=noninteractive \
    NVM_DIR=/root/.nvm

RUN apt-get update && apt-get install -yq \
    curl \
    apt-utils \
    >/dev/null 2>&1

RUN bash -c " \
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash && \
    . $NVM_DIR/nvm.sh && \
    nvm install 12 \
"

RUN bash -c " \
    . $NVM_DIR/nvm.sh && \
    npm install && \
    npm run build \
"

CMD ["bash", "-c", ". /root/.nvm/nvm.sh && npm start"]
