NAME=$(shell basename $(shell pwd))

all: build

build:
	docker build -t $(NAME) .
