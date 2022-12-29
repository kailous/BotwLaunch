#!/bin/zsh
# CemuLaunch / Cemu 启动器
# v1.2.0
# Refactored, dated backup directories, backup saves, no dir deletion or rotation
# BotW vk Caches - prefix 000500001010c 9400 is NA, 9300 is JP, 9500 is EU
# export MVK_CONFIG_USE_METAL_ARGUMENT_BUFFERS=1 # not used
CEMU_DIR="$HOME/Library/Application Support/Cemu"
CEMU_CACHES="$HOME/Library/Caches/Cemu"
# Colons allowed on macOS, but traditionally special for filenames
NOW=$(date +'%Y-%m-%d-%H-%M-%S')
BACKUP_DIR="$CEMU_DIR/ConfigBackups/${NOW}"
# echo $BACKUP_DIR
# Clean BotW Shader Caches ignoring errors. Automator has trouble with wildcards.
rm "$CEMU_CACHES/shaderCache/driver/vk/00050000101c9300.bin"
rm "$CEMU_CACHES/shaderCache/driver/vk/00050000101c9400.bin"
rm "$CEMU_CACHES/shaderCache/driver/vk/00050000101c9500.bin"
# Now make some backups
mkdir -p "$BACKUP_DIR"
cp -RL "$CEMU_CACHES/shaderCache" "$BACKUP_DIR"
cp -RL "$CEMU_DIR/mlc01/usr/save" "$BACKUP_DIR"
open "/Applications/Cemu.app"