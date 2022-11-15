NAME=$(shell basename $(shell pwd))
ORG=$(shell basename $(shell dirname $(shell pwd)))

all: build
	echo $(ORG)/$(NAME)

build:
	docker build $(OPTS) -t $(NAME) .

pull:
	docker pull ghcr.io/$(ORG)/$(NAME):latest

run:
	docker run -it --rm $(NAME) bash
 