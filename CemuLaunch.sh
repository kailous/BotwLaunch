#!/bin/zsh
# CemuLaunch / Cemu 启动器
# v1.3.0
# 自动备份缓存和存档
# BotW vk 缓存 - 前缀 000500001010c 9400 是 USA，9300 是 JPN，9500 是 EUA
# 环境变量 export MVK_CONFIG_USE_METAL_ARGUMENT_BUFFERS=1 未使用
CEMU_DIR="$HOME/Library/Application Support/Cemu"
CEMU_CACHES="$HOME/Library/Caches/Cemu"
# 冒号在 macOS 上允许使用，但一般主要用于文件名
NOW=$(date +'%Y-%m-%d-%H-%M-%S')
BACKUP_DIR="$CEMU_DIR/ConfigBackups/${NOW}"
# echo $BACKUP_DIR
# 清理 BotW 着色器缓存并忽略错误。 Automator 在使用通配符时遇到问题。
rm "$CEMU_CACHES/shaderCache/driver/vk/00050000101c9300.bin"
rm "$CEMU_CACHES/shaderCache/driver/vk/00050000101c9400.bin"
rm "$CEMU_CACHES/shaderCache/driver/vk/00050000101c9500.bin"
# 现在开始备份
mkdir -p "$BACKUP_DIR"
cp -RL "$CEMU_CACHES/shaderCache" "$BACKUP_DIR"
cp -RL "$CEMU_DIR/mlc01/usr/save" "$BACKUP_DIR"
open "/Applications/Cemu.app"