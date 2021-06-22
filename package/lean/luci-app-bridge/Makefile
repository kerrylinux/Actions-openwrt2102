
# Copyright (C) 2016 Openwrt.org
#
# This is free software, licensed under the Apache License, Version 2.0 .
#

include $(TOPDIR)/rules.mk

LUCI_TITLE:=Luci for support bridge
LUCI_DEPENDS:=+ip-bridge +kmod-nft-bridge
LUCI_PKGARCH:=all
PKG_VERSION:=1.0
PKG_RELEASE:=1

define Package/luci-app-bridge/conffiles
/etc/bridge/network
/etc/bridge/firewall
endef

include $(TOPDIR)/feeds/luci/luci.mk

# call BuildPackage - OpenWrt buildroot signature
