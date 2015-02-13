CURRENT_DIRECTORY := $(shell pwd)

build:
	@docker build --tag=iiiepe/nginx-moodle $(CURRENT_DIRECTORY)

build-no-cache:
	@docker build --no-cache --tag=iiiepe/nginx-moodle $(CURRENT_DIRECTORY)

.PHONY: build