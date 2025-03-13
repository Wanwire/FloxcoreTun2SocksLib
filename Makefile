
DESTDIR ?= build
PACKAGE ?= com.wanwire.libtun2socks

default: $(DESTDIR)/$(PACKAGE)

$(DESTDIR)/$(PACKAGE): export DESTDIR := $(CURDIR)/$(DESTDIR)
$(DESTDIR)/$(PACKAGE): $(DESTDIR)/$(PACKAGE).aar

$(DESTDIR)/$(PACKAGE).aar: export PLATFORM := $(PLATFORM)
$(DESTDIR)/$(PACKAGE).aar: export DESTDIR := $(CURDIR)/$(DESTDIR)
$(DESTDIR)/$(PACKAGE).aar:
	$(MAKE) -C thirdparty
	$(MAKE) -C lib

clean:
	$(MAKE) -C thirdparty clean
	$(MAKE) -C lib clean
	@rm -rf "$(DESTDIR)"

.PHONY: clean
