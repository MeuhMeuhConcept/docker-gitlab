.PHONY: help install start stop
.DEFAULT_GOAL := help

install: docker-compose.yml gitlab.env postgresql.env smtp.env ## Install

docker-compose.yml:
	cp docker-compose.yml.dist $@

gitlab.env:
	cp gitlab.env.dist $@

postgresql.env:
	cp postgresql.env.dist $@

smtp.env:
	cp smtp.env.dist $@

start: install ## Run with docker stack
	docker stack deploy --compose-file docker-compose.yml gitlab

stop: install ## Stop service
	docker stack rm gitlab

help:
	@grep -E '^[a-zA-Z_-.]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
