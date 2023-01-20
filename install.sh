#!/bin/zsh
# 设定基础变量
APP_NAME=CemuLaunch
PROJECT_NAME=CemuLaunch
ICON_NAME=shortcut
# 下载默认配置文件到 Cemu 根目录 ｜ 请手动修改 USER_ID 用户ID & RENION 游戏区域
echo "安装配置文件"
curl -# -o "${HOME}/Library/Application Support/Cemu/cemu.config" "https://raw.githubusercontent.com/kailous/${PROJECT_NAME}/main/cemu.config"
# 在 Applications 构建 启动器 APP
echo "安装应用"
mkdir -p "/Applications/${APP_NAME}.app/"
mkdir -p "/Applications/${APP_NAME}.app/Contents"
mkdir -p "/Applications/${APP_NAME}.app/Contents/MacOS"
mkdir -p "/Applications/${APP_NAME}.app/Contents/Resources"
curl -# -o "/Applications/${APP_NAME}.app/Contents/Info.plist" "https://raw.githubusercontent.com/kailous/${PROJECT_NAME}/main/${APP_NAME}.app/Contents/Info.plist"
curl -# -o "/Applications/${APP_NAME}.app/Contents/Resources/${ICON_NAME}.icns" "https://raw.githubusercontent.com/kailous/${PROJECT_NAME}/main/${APP_NAME}.app/Contents/Resources/${ICON_NAME}.icns"
curl -# -o "/Applications/${APP_NAME}.app/Contents/MacOS/run.sh" "https://raw.githubusercontent.com/kailous/${PROJECT_NAME}/main/${APP_NAME}.app/Contents/MacOS/run.sh"
curl -# -o "/Applications/${APP_NAME}.app/Contents/Resources/transferable.tar.gz" "https://raw.githubusercontent.com/kailous/${PROJECT_NAME}/main/${APP_NAME}.app/Contents/Resources/transferable.tar.gz"
# 修复应用权限
chmod -R 777 "/Applications/${APP_NAME}.app"