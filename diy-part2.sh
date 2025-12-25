#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
sed -i 's/192.168.1.1/192.168.3.1/g' package/base-files/files/bin/config_generate

# Fix microsocks build error (Change c99 to gnu99 for gcc 8.4 compatibility)
sed -i '/include \$(INCLUDE_DIR)\/package.mk/a TARGET_CFLAGS += -fpermissive -std=gnu99' package/luci-app-passwall-packages/microsocks/Makefile
