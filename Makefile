NAME=$(shell basename $(shell pwd))
ORG=$(shell basename $(shell dirname $(shell pwd)))

ifdef http_proxy
BLD_OPTS=--build-arg http_proxy=$$http_proxy --build-arg https_proxy=$$https_proxy --build-arg no_proxy=$$no_proxy
RUN_OPTS=-e http_proxy=$$http_proxy -e https_proxy=$$https_proxy -e no_proxy=$$no_proxy
endif

all: build

build:
	docker build $(BLD_OPTS) $(OPTS) -t $(NAME) .

pull:
	docker pull ghcr.io/$(ORG)/$(NAME):latest

run:
	docker run $(OPTS) $(RUN_OPTS) -it --rm $(NAME) bash
 