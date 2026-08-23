
HEV = hev-socks5-tunnel-2.17.1

default: $(HEV)/patched

libhev: $(HEV)/patched

$(HEV)/patched:
	@for patchfile in patches/libhev*.patch; do \
		git apply --check $$patchfile; \
		if [ $$? == 0 ]; then \
			git apply --whitespace=fix $$patchfile || true; \
		fi; \
	done;
	touch $(HEV)/patched

clean:
	@git checkout $(HEV)
	@git clean -dxf $(HEV)

.PHONY: clean
