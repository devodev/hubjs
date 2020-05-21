# inspired by: https://gist.github.com/mpneuried/0594963ad38e68917ef189b4e6a269db

# import config.
# You can change the default config with `make cnf="config_special.env" build`
cnf ?= config.env
include $(cnf)
export $(shell sed 's/=.*//' $(cnf))

# Set TLS Certificate config
CERT_PATH := ./config/tls
CERT_NAME := server
CERT_SUBJ := /C=CA/ST=Quebec/L=Montreal/O=Hitachi Systems Security Inc./CN=localhost

# Main
.PHONY: help

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

# TASKS
build: ## Build the container
	docker build -t $(APP_NAME) .

build-nc: ## Build the container without caching
	docker build --no-cache -t $(APP_NAME) .

run: ## Run container on port configured in `config.env`
	docker run -i -t --rm --env-file=./config.env -p=$(PORT):$(PORT) -p=$(ADMIN_PORT):$(ADMIN_PORT) --name="$(APP_NAME)" $(APP_NAME)

run-bg: ## Run container on port configured in `config.env` in the background
	docker run -d --env-file=./config.env -p=$(PORT):$(PORT) -p=$(ADMIN_PORT):$(ADMIN_PORT) --name="$(APP_NAME)" $(APP_NAME)

status: ## Get container status
	docker ps -f name="$(APP_NAME)"

stop: ## Stop a running container
	docker stop $(APP_NAME)

rm: ## Remove a container
	docker rm $(APP_NAME)

gencerts: ## Generate self-signed certificate and key
	openssl req \
       -subj '$(CERT_SUBJ)' \
       -newkey rsa:2048 -nodes -keyout $(CERT_PATH)/$(CERT_NAME).key \
       -x509 -days 365 -out $(CERT_PATH)/$(CERT_NAME).pem

# AGGREGATE COMMANDS
up: build run ## Run container on port configured in `config.env` (Alias to run)
up-bg: build run-bg status ## Run container in the background on port configured in `config.env` (Alias to run)
nuke: stop rm ## Stop and rm a running container
