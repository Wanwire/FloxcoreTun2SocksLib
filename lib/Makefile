HEV := hev-socks5-tunnel-d46a36fbf43
HEV_DIR := $(CURDIR)/../thirdparty/$(HEV)
CONFIGURATION_BUILD_DIR ?= $(CURDIR)/out
CONFIGURATION_TEMP_DIR ?= $(CURDIR)/.tmp
DESTDIR ?= $(CONFIGURATION_BUILD_DIR)
BUILDDIR ?= $(CONFIGURATION_TEMP_DIR)
PACKAGE := com.wanwire.libtun2socks
LIB_NAME := libtun2socks-android
JAVA_CLASS_DIR := classes
AAR_DIR := $(BUILDDIR)/libtun2socks-android
AAR_FILE := $(LIB_NAME).aar

ARCHS := arm64-v8a armeabi-v7a x86 x86_64
SO_FILES := $(patsubst %,$(AAR_DIR)/jni/%/$(LIB_NAME).so,$(ARCHS))

JAVAC := javac
JAR := jar
ZIP := zip

default: $(DESTDIR)/$(AAR_FILE)

# Rule to build .so files for all architectures
ndkbuild:
	@mkdir -p $(CONFIGURATION_TEMP_DIR)
	@cp -r $(HEV_DIR) $(CONFIGURATION_TEMP_DIR)/jni
	@cd $(CONFIGURATION_TEMP_DIR)/jni && ndk-build -j

# Rule to compile the Java file
$(AAR_DIR)/$(JAVA_CLASS_DIR)/$(subst .,/,$(PACKAGE))/Tun2Socks.class: src/Tun2Socks.java
	@mkdir -p $(@D)
	$(JAVAC) -d $(AAR_DIR)/$(JAVA_CLASS_DIR) $<

#Rule to create classes.jar
$(AAR_DIR)/classes.jar: $(AAR_DIR)/$(JAVA_CLASS_DIR)/$(subst .,/,$(PACKAGE))/Tun2Socks.class
	@mkdir -p $(@D)
	@cd $(AAR_DIR)/$(JAVA_CLASS_DIR) && $(JAR) cf $(AAR_DIR)/classes.jar com/wanwire/libtun2socks/Tun2Socks.class

# Rule to create AndroidManifest.xml
$(AAR_DIR)/AndroidManifest.xml:
	@mkdir -p $(@D)
	@printf '<manifest xmlns:android="http://schemas.android.com/apk/res/android" package="$(PACKAGE)">\n</manifest>' > $@

# Rule to build the .aar file
$(AAR_DIR)/$(AAR_FILE): ndkbuild $(AAR_DIR)/classes.jar $(AAR_DIR)/AndroidManifest.xml
	@mkdir -p $(AAR_DIR)/jni/arm64-v8a && cp $(CONFIGURATION_TEMP_DIR)/libs/arm64-v8a/libhev-socks5-tunnel.so $(AAR_DIR)/jni/arm64-v8a/$(LIB_NAME).so
	@mkdir -p $(AAR_DIR)/jni/armeabi-v7a && cp $(CONFIGURATION_TEMP_DIR)/libs/armeabi-v7a/libhev-socks5-tunnel.so $(AAR_DIR)/jni/armeabi-v7a/$(LIB_NAME).so
	@mkdir -p $(AAR_DIR)/jni/x86 && cp $(CONFIGURATION_TEMP_DIR)/libs/x86/libhev-socks5-tunnel.so $(AAR_DIR)/jni/x86/$(LIB_NAME).so
	@mkdir -p $(AAR_DIR)/jni/x86_64 && cp $(CONFIGURATION_TEMP_DIR)/libs/x86_64/libhev-socks5-tunnel.so $(AAR_DIR)/jni/x86_64/$(LIB_NAME).so
	@cd $(@D) && $(ZIP) -r $@ AndroidManifest.xml jni/ classes.jar

$(DESTDIR)/$(AAR_FILE): $(AAR_DIR)/$(AAR_FILE)
	@mkdir -p $(@D)
	@cp $< $@

clean:
	rm -rf $(AAR_DIR) $(JAVA_CLASS_DIR) $(AAR_FILE) $(LIB_NAME)-*.so $(LIB_NAME)-*.h $(CONFIGURATION_TEMP_DIR)

.PHONY: clean ndkbuild
