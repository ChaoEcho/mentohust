include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/package.mk

PKG_NAME:=mentohust
PKG_VERSION:=0.3.1
PKG_RELEASE:=2


PKG_FIXUP:=autoreconf

PKG_INSTALL:=1

CONFIGURE_ARGS += \
	--disable-encodepass \
	--disable-notify


define Package/mentohust
	SECTION:=net
	CATEGORY:=Network
	DEPENDS:=+libpcap
	TITLE:=MentoHUST for SYSU
	URL:=https://github.com/KumaTea/MentoHUST-SYSU-OpenWrt.git
	SUBMENU:=Ruijie
endef

define Package/mentohust/description
	MentoHUST for SYSU
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	$(CP) ./src/* $(PKG_BUILD_DIR)/
	$(SED) 's/dhclient/udhcpc -i/g' $(PKG_BUILD_DIR)/myconfig.c
endef


define Package/mentohust/conffiles
	/etc/mentohust.conf
endef

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) \
		$(TARGET_CONFIGURE_OPTS) \
		CC="$(TARGET_CC)" \
		CFLAGS="$(TARGET_CFLAGS) -I$(STAGING_DIR)/usr/include" \
		LDFLAGS="$(TARGET_LDFLAGS) -L$(STAGING_DIR)/usr/lib -lpcap -ldl" \
		all
endef

define Package/mentohust/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/mentohust $(1)/usr/sbin/
	$(INSTALL_DIR) $(1)/etc
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/mentohust.conf $(1)/etc/mentohust.conf
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
