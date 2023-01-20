# BotwLaunch / 塞尔达传说：旷野之息 for Cemu 启动器

[Goto Github](https://github.com/kailous/BotwLaunch)

----

[简体中文](./README.md) | [English](./README-EN.md)

Cemu 因为着色器缓存的 Bug 会导致 [ 塞尔达传说：旷野之息 ] 第二次启动出现闪退。需要手动删除 /shaderCache/driver/vk/00050000101c9xxx.bin
文件才能再次启动游戏，直接使用启动器会自动删除文件并开启 Cemu。

启动器就是一段脚本自动将这些繁琐的操作执行一遍，并开启游戏。

----

### 功能点

- 删除 VK 用户缓存，解决第二次启动游戏闪退的 BUG 。
- 释放 完成度 100% transferable 缓存，加速游戏缓存，游戏中不再缓存，运行更加流畅。
- 根据 [ cemu.config ] 配置文件的设定，决定是否建立备份，将 Botw 的游戏保存文件，和用户缓存分开备份。
- 如果你的游戏文件存放在 Cemu 根目录的 [ Game ] ，可以直接启动游戏，如果你的游戏文件在其他任何地方，需要在启动器 App 右键 > 显示包内容 > MacOS > run.sh:75 将你的游戏文件地址替换在 "${CEMU_DIR}/${GAME_DIR}" 。

----

### 安装 APP / Source code

偶然间发现 steam 游戏的启动器 App，就是基础的 .app 文件夹包裹了一个 shell 脚本。这样只要给 App 一个权限，就可以直接运行脚本了，还能有一个漂亮的自定义 icon ，整个 App 上传到 Github 后源代码可以在线查看，安全透明。美滋滋。

复制下面这段脚本，在 [ 终端.app ] 运行，下载默认的 [ cemu.config ] 文件到 Cemu 根目录，将 App 下载到 [ 应用程序 ] 文件夹，并给一个 777 权限。

```zsh
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

----

### 启动器改进

启动器包含 100% 着色器缓存，加载配置文件后自动释放对应的缓存文件到 [ ～/Library/Caches/Cemu ]
如果你使用 [ cemu.config ] ，那么仅会释放你设定好的地区版本缓存，如果你的 游戏文件 放在 Cemu 根目录 Game 文件夹下，可以直接启动 塞尔达传说：旷野之息。 如果你没有 [ cemu.config ]
，那么会释放所有的缓存，并仅仅启动 Cemu。

### 配置文件说明

以下是配置文件的默认内容

```ini
Cemu 配置文件
[用户ID] # 在 Cemu > 通用设置 > 账户 中查看 通常为 8000000x
USER_ID = 80000002
[游戏区域] # 游戏区域的编号：JPN 日版为 101c9300｜USA 美版为 101c9400｜EUA 欧版为 101c9500
RENION = 101c9300
[游戏目录] # 游戏目录 建议放到 Cemu 根目录，如果不想放 Cemu 根目录，可以手动在启动器右键显示包内容，用文本工具打开 run.sh:76 行，"${CEMU_DIR}/${GAME_DIR}" 替换为 "Botw 游戏目录"。否则无法直接启动游戏，仅会启动 Cemu。
GAME_DIR = Game/Breath of the Wild
[开启备份] # 根据需求自定义自动备份的内容，1为开启，0为关闭。SAVE是存档文件，CACHES是缓存文件。
SAVE = 1
CACHES = 1
```