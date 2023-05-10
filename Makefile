NAME=$(shell basename $(shell pwd))
ORG=$(shell basename $(shell dirname $(shell pwd)))

all: build

build:
	docker build $(OPTS) -t $(NAME) .

pull:
	docker pull ghcr.io/$(ORG)/$(NAME):latest

run:
	docker run $(OPTS) -it --rm -u vscode -w /home/vscode $(NAME) bash -l

test:
	trivy image --severity HIGH,CRITICAL $(NAME)
