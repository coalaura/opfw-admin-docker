Dockerized version of the [opfw-admin](https://github.com/coalaura/opfw-admin).

### Installation
1. Clone this repository
2. Copy the [`.example.env`](.example.env) to `.env` and update it
3. Run `docker compose up -d`
4. Epic

### Configuration

The `.env` is the regular [opfw-admin](https://github.com/coalaura/opfw-admin) config. It has 2 additional options:

|`DOCKER_PORT`|`DOCKER_CLUSTER`|
|-|-|
|The port to host the panel on (default: 80).|The cluster (optional, default: c1)|