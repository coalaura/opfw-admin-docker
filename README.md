Dockerized version of the [opfw-admin](https://github.com/coalaura/opfw-admin).

### Installation
1. Clone this repository
2. Run [`init.sh`](init.sh)
3. Update your FiveM server, database and discord auth in the created `.env` file
4. Run `docker compose up -d`
5. Epic

### Configuration

The `.env` is the regular [opfw-admin](https://github.com/coalaura/opfw-admin) config. It has 4 additional options:

**`DOCKER_PORT`**
*The port to host the panel on (default: 80).*

**`DOCKER_CLUSTER`**
*The cluster name (default: c1)*

**`DOCKER_INFLUX_PASSWORD`**
*The influx db password (auto-generated when using init.sh)*

**`DOCKER_INFLUX_TOKEN`**
*The influx db admin token (auto-generated when using init.sh)*