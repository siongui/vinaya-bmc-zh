# cannot use relative path in GOROOT, otherwise 6g not found. For example,
#   export GOROOT=../go  (=> 6g not found)
# it is also not allowed to use relative path in GOPATH
PRJDIR=$(CURDIR)/../

GODIR=$(CURDIR)/../../
ifdef GITLAB_CI
export GODIR=$(PRJDIR)
endif
ifndef GOROOT
export GOROOT=$(realpath $(GODIR)/go)
export PATH := $(GOROOT)/bin:$(PATH)
endif

WEBSITE_DIR=$(CURDIR)/output

OFFLINE_LINUX=$(GOROOT)/bin/offline-linux-arm64
OFFLINE_WINDOWS=$(GOROOT)/bin/offline-windows-amd64.exe
OFFLINE_MAC=$(GOROOT)/bin/offline-darwin-amd64
OFFLINE_MAC_M=$(GOROOT)/bin/offline-darwin-arm64


###############################
# Build Single Offline Binary #
###############################
offline:
	@echo "\033[92mBuild single offline website binary ...\033[0m"
	# build binary for linux
	go build -o $(OFFLINE_LINUX)
	# build binary for windows
	GOOS=windows GOARCH=amd64 go build -o $(OFFLINE_WINDOWS)
	# build binary for Mac OS X (intel chip)
	GOOS=darwin GOARCH=amd64 go build -o $(OFFLINE_MAC)
	# build binary for Mac OS X (Apple M series chip)
	GOOS=darwin GOARCH=arm64 go build -o $(OFFLINE_MAC_M)

run-offline: offline
	$(OFFLINE_LINUX)

######################################
# End of Build Single Offline Binary #
######################################

fmt:
	go fmt offline.go

modinit:
	go mod init offline

modtidy:
	go mod tidy
