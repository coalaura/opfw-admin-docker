FROM oven/bun:latest

WORKDIR /usr/src/app

RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*
RUN git clone --depth 1 --branch master https://github.com/coalaura/admin-panel-socket.git .

RUN bun install

EXPOSE 3000
CMD [ "bun", "run", "start" ]