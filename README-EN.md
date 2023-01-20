# BotwLaunch / The Legend of Zelda: Breath of the Wild for Cemu Launcher

[简体中文](./README.md) | [English](./README-EN.md)

Cemu has a bug with shader cache that can cause [The Legend of Zelda: Breath of the Wild] to crash when it is launched for the second time. You need to manually delete the file /shaderCache/driver/vk/00050000101c9xxx.bin in order to launch the game again. The launcher will automatically delete the file and launch Cemu.

The launcher is a script that automatically performs these tedious operations and starts the game.

---

### Features

- Delete VK user cache to fix the BUG of game crashing on the second launch.
- Release 100% transferable cache to speed up caching in the game, eliminating caching during gameplay and improving performance.
- According to the [cemu.config] configuration file setting, decide to create a backup or not, backup the Botw game save files, and separate the user caches.
- If your game files are stored in the [Game] directory of the Cemu root directory, you can launch the game directly. If your game files are stored in any other place, you need to right-click the launcher App > Show Package Contents > MacOS > [run.sh:75](http://run.sh:75/) and replace the address of your game files in "*CEMUIR*/{GAME_DIR}".

---

### Install APP

I accidentally discovered a launcher App for Steam games, which is just a basic .app folder wrapping a shell script. With this, as long as the App is given permission, the script can be run directly, and it also has a beautiful custom icon. After uploading the entire App to Github, the source code can be viewed online, which is secure and transparent. Lovely.

Copy the following script and run it in [Terminal.app] to download the default [cemu.config] file to the Cemu root directory, download the App to the [Applications] folder, and give it a 777 permission.

```
#!/bin/zsh
# 设定基础变量
APP_NAME=BotwLaunch
PROJECT_NAME=BotwLaunch
ICON_NAME=BotwLaunch
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
```

---

### Launcher Improvements

The Launcher includes 100% shaders cache, and automatically releases the corresponding cache file to `~/Library/Caches/Cemu` after loading the configuration file. If you use `cemu.config`, then only the regional version cache set by you will be released. If your game files are placed in the Game folder under the root directory of Cemu, you can directly launch "The Legend of Zelda: Breath of the Wild". If you don't have `cemu.config`, then all caches will be released and only Cemu will be started.

### Configuration File Description

The following is the default content of the configuration file.

```ini
Cemu config
[User ID] # Check in Cemu > General Settings > Account, usually 8000000x.
USER_ID = 80000002
[Game Renion] # Game region codes: JPN (Japan) - 101c9300 | USA (United States) - 101c9400 | EUA (Europe) - 101c9500
RENION = 101c9300
[Game Path] # If your game files are stored in the [Game] directory of the Cemu root directory, you can launch the game directly. If your game files are stored in any other place, you need to right-click the launcher App > Show Package Contents > MacOS > run.sh:75 and replace the address of your game files in "CEMUIR/{GAME_DIR}".
GAME_DIR = Game/Breath of the Wild
[on/off Backup] # If your game files are stored in the [Game] directory of the Cemu root directory, you can launch the game directly. If your game files are stored in any other place, you need to right-click the launcher App > Show Package Contents > MacOS > [run.sh:75](http://run.sh:75/) and replace the address of your game files in "*CEMUIR*/{GAME_DIR}".
SAVE = 1
CACHES = 1
```
