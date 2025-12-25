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

echo "Fix microsocks C99 build error"

PATCH_DIR="package/luci-app-passwall-packages/microsocks/patches"
mkdir -p $PATCH_DIR

cat > $PATCH_DIR/001-fix-c99-label-declaration.patch << 'EOF'
--- a/sockssrv.c
+++ b/sockssrv.c
@@ -502,7 +502,9 @@ handshake(int sock, struct sockaddr *sa)
 
 error:
-    int used_rule = 0;
+{
+    int used_rule = 0;
+
     if (acl)
         used_rule = acl->number;
 
@@ -515,6 +517,7 @@ error:
     if (rules)
         ruleslog(used_rule, addr, port, username, 0);
 
+}
     close(sock);
     return -1;
EOF
