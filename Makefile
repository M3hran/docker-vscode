NAME = m3hran/code-server
VERSION = 0.1
C_NAME = code-server
DOCKERFILE_NAME = Dockerfile

.PHONY: all build test tag_latest release install clean

all: clean build install

build: 
	docker build -t $(NAME):$(VERSION) -f $(DOCKERFILE_NAME) . 

clean: 
	docker rm -vf $(C_NAME)
	
install:
	docker run -d -p 69:69/udp --name $(C_NAME) $(NAME):$(VERSION)

tag_latest:
	docker tag $(NAME):$(VERSION) $(NAME):latest

release: tag_latest
	@if ! docker images $(NAME) | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME) version $(VERSION) is not yet built. Please run 'make build'"; false; fi
	docker push $(NAME)
	@echo "*** Don't forget to create a tag. git tag rel-$(VERSION) && git push origin rel-$(VERSION)"

