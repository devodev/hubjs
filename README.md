# hubjs

The hub runs on `Node.js`, a JavaScript runtime built on Chrome's V8 JavaScript engine.

## Dependencies

The hub uses `express-gateway`, a microservices API gateway built on Express.js.

- node.js 14.2
- express-gateway 1.16.10

## Content

### Dockerfile

The Dockerfile setups a `node` environment, installs dependencies, wraps the server with `tiny` for signal handling, and runs the server as the node user.

### Makefile

The Makefile provides useful commands while in development.

### package.json

The package.json declares the project metadata, dependencies and helper scripts.

### server.js

This is the web server implementation.

## Usage

To get started, clone this repository and use the Makefile provided to start a container running hubjs:

```bash
git clone https://git-url/path/to/hubjs.git
cd hubjs
make up
```

Alternatively, one can use the docker-compose definition file provided. It will start a redis instance with persistence enabled to be used by the gateway.

> Note:</br>
> THP (Transparent Huge Pages) should be deactivated in the kernel of the linux VM running docker containers on your machine. More information [here](https://github.com/docker-library/redis/issues/55).</br>

Deactivate THP (only need to be executed once):

```text
$ docker run -it --rm --privileged --pid=host justincormack/nsenter1
/ # echo never > /sys/kernel/mm/transparent_hugepage/enabled
/ # echo never > /sys/kernel/mm/transparent_hugepage/defrag
```

Start the stack

```bash
docker-compose up
```

### Helpful Commands

> The following commands uses the Makefile provided by this repo.</br>
> Also, `config.env` is sourced by the Makefile to get app specific parameters.</br>
> This is not an exhaustive list of commands. Run `make help` to see all available commands.

Generate certs and build the image without using the build cache:

```bash
make init
```

Build the image, create a container from the image, run it (interactively or in the background) and display its status:

```bash
# interactive
make up
# background
make up-bg
```

Get container status:

```bash
make status
```

Stop the container

```bash
make stop
```

Stop and remove the container

```bash
make nuke
```
