# Go parameters
GOCMD = go
BUILD = $(GOCMD) build
CLEAN = $(GOCMD) clean
TEST = $(GOCMD) test
GET = $(GOCMD) get
BINARY_NAME = binary
ARCH = amd64
TARGET = target

build:
	@$(BUILD) -o $(TARGET)/$(BINARY_NAME) -v

run: build
	@./$(TARGET)/$(BINARY_NAME) $(args)

test:
	@$(TEST) -v

clean:
	@$(CLEAN)
	@rm -rf $(TARGET)

deps:
	@$(GET) github.com/markbates/goth
	@$(GET) github.com/markbates/pop

build-linux:
	@CGO_ENABLED=0 GOOS=linux GOARCH=$(ARCH) $(BUILD) -ldflags '-s -w --extldflags "-static -fpic"' -o $(TARGET)/$(BINARY_NAME)-linux-$(ARCH) -v

build-windows:
	@CGO_ENABLED=0 GOOS=windows GOARCH=$(ARCH) $(BUILD) -ldflags '-s -w --extldflags "-static -fpic"' -o $(TARGET)/$(BINARY_NAME)-windows-$(ARCH) -v

build-darwin:
	@CGO_ENABLED=0 GOOS=darwin GOARCH=$(ARCH) $(BUILD) -ldflags '-s -w --extldflags "-static -fpic"' -o $(TARGET)/$(BINARY_NAME)-darwin-$(ARCH) -v

build-docker:
	@docker run --rm -it -v "$(GOPATH)":/go -w /go/src/bitbucket.org/rsohlich/makepost golang:latest go build -o "$(BINARY_NAME)" -v

build-all: build-linux build-windows build-darwin
