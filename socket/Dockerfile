FROM oven/bun:latest

WORKDIR /usr/src/app

RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*
RUN git clone --depth 1 --branch master https://github.com/coalaura/admin-panel-socket.git .

RUN bun install

COPY entry.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entry.sh

ENTRYPOINT ["entry.sh"]

CMD [ "bun", "main.js" ]