# hubjs

## Dependencies

The hub uses `Node.js`, a Javascript runtime built on `Chrome's V8 Javascript engine`, and `express.js` as its web framework.

- node.js 14.2
- express 4.17.1
- winston 3.2.1

## Content

### Dockerfile

The Dockerfile setups a `node` environment, installs dependencies, wraps the server with `tiny` for signal handling, and runs the server as the node user.

### Makefile

The Makefile provides helper commands while in development.

### package.json

The package.json declares the project metadata, dependencies and helper scripts.

### server.js

This is the web server implementation.

## Usage

> config.env is used by Makefile to get app specific parameters

Build the image without using the build cache:

```bash
make build-nc
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
