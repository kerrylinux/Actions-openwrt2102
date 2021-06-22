#
# Copyright (C) 2019 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk

PKG_NAME:=parted
PKG_VERSION:=3.4
PKG_RELEASE:=1

PKG_BUILD_DIR:=$(BUILD_DIR)/parted-$(PKG_VERSION)
PKG_SOURCE:=parted-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=@GNU/parted
PKG_MD5SUM:=357d19387c6e7bc4a8a90fe2d015fe80

include $(INCLUDE_DIR)/package.mk
define Package/parted
	SECTION:=utils
	CATEGORY:=Utilities
	SUBMENU:=Disc
	TITLE:=parted Partition editor
	URL:=http://ftp.gnu.org/gnu/parted
	DEPENDS:= +libuuid +libreadline +libncurses +libblkid
endef

define Package/parted/description
	parted Partition editor
	http://ftp.gnu.org/gnu/parted
endef

define Build/Configure
	$(call Build/Configure/Default, \
		--without-readline \
		--disable-device-mapper \
		--disable-nls \
	)
endef

define Package/parted/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_DIR) $(1)/usr/lib
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/libparted/.libs/*.so* $(1)/usr/lib/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/libparted/fs/.libs/*.so* $(1)/usr/lib/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/parted/.libs/parted $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/partprobe/.libs/partprobe $(1)/usr/sbin/
endef

$(eval $(call BuildPackage,parted))
