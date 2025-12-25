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

echo "==> Revert microsocks socks5 forwarding rules commit"

MICROSOCKS_DIR="package/luci-app-passwall-packages/microsocks"
BAD_COMMIT="ee784243479b7f10cf197c0246cddaa456a0801d"

if [ -d "$MICROSOCKS_DIR/.git" ]; then
    cd "$MICROSOCKS_DIR"

    if git cat-file -e ${BAD_COMMIT}^{commit} 2>/dev/null; then
        echo "Found bad commit ${BAD_COMMIT}, reverting..."
        git revert --no-edit ${BAD_COMMIT}
    else
        echo "Commit ${BAD_COMMIT} not found, skip revert"
    fi

    cd -
else
    echo "microsocks git repo not found, skip revert"
fi
