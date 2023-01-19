#!/bin/bash
# 获取当前目录
# shellcheck disable=SC2046
DIR=$(cd $(dirname "$0") && pwd)
echo -e "当前目录：\n${DIR}"
# 设定变量
# Cemu 目录
CEMU_DIR="${HOME}/Library/Application Support/Cemu"
CEMU_CACHES="${HOME}/Library/Caches/Cemu"
CEMU_CONFIG="${CEMU_DIR}/cemu.config"
# 备份目录&文件名
NOW=$(date +'%Y_%m_%d_%H_%M_%S')
BACKUP_CACHES_DIR="${CEMU_DIR}/ConfigBackups/shaderCache"
BACKUP_SAVE_DIR="${CEMU_DIR}/ConfigBackups/save"
BACKUP_NAME="_backup_${NOW}.tar.gz"
# 启动器 Resources 目录
APP_DIR=${DIR//MacOS/}Resources/
# 读取配置文件
if [ -f "${CEMU_CONFIG}" ]; then
  echo "配置文件存在"
  # shellcheck disable=SC2066
  for line in "${CEMU_CONFIG}"; do
    # shellcheck disable=SC2002
    USER_ID=$(cat "${line}" | grep "USER_ID=" | sed "s/^.*=//")
    # shellcheck disable=SC2002
    RENION=$(cat "${line}" | grep "RENION=" | sed "s/^.*=//")
    # shellcheck disable=SC2002
    SAVE=$(cat "${line}" | grep "SAVE=" | sed "s/^.*=//")
    # shellcheck disable=SC2002
    CACHES=$(cat "${line}" | grep "CACHES=" | sed "s/^.*=//")
    # shellcheck disable=SC2034
    # shellcheck disable=SC2002
    GAME_DIR=$(cat "${line}" | grep "GAME_DIR=" | sed "s/^.*=//")
  done
  echo -e "检测到设置信息：\nUSER_ID=${USER_ID}\nRENION=${RENION}\nSAVE=${SAVE}\nCACHES=${CACHES}\nGAME_DIR=${GAME_DIR}"
  # 清除 指定区域的 Botw 的用户着色器缓存以忽略错误
  if [ -f "${CEMU_CACHES}/shaderCache/driver/vk/00050000${RENION}.bin" ]; then
    rm "${CEMU_CACHES}/shaderCache/driver/vk/00050000${RENION}.bin"
    echo "缓存已清空"
    else
    echo "缓存已清空"
  fi

  # 释放指定版本的 Botw 100%缓存文件到 cemu/shaderCache
  cd "${CEMU_CACHES}/shaderCache" || exit
  tar -xf "${APP_DIR}/transferable.tar.gz" "transferable/00050000${RENION}_shaders.bin"
  tar -xf "${APP_DIR}/transferable.tar.gz" "transferable/00050000${RENION}_vkpipeline.bin"
  echo "释放缓存文件完成"
  # 现在开始备份
  # 创建备份目录
  mkdir -p "${BACKUP_CACHES_DIR}"
  mkdir -p "${BACKUP_SAVE_DIR}"
  # 判断是否备份 缓存文件
  if [ "${CACHES}" = 0 ]; then
    # 备份缓存文件
    cd "${CEMU_CACHES}" || exit
    tar -czf "${BACKUP_CACHES_DIR}/shaderCache${BACKUP_NAME}" "./shaderCache"
    echo "缓存文件备份完成"
  else
    echo "跳过缓存文件备份"
  fi
  # 判断是否备份 存档文件
  if [ "${SAVE}" = 0 ]; then
    # 备份存档文件
    cd "${CEMU_DIR}/mlc01/usr/save/00050000" || exit
    tar -czf "${BACKUP_SAVE_DIR}/botw_save${BACKUP_NAME}" "./${RENION}"
    echo "缓存存档备份完成"
  else
        echo "跳过存档文件备份"
  fi
else
  # 清除 所有的 Botw 的用户着色器缓存以忽略错误
  echo "配置文件不存在，启动默认设置，重置所有 botw 缓存。"
  if [ -f "${CEMU_CACHES}/shaderCache/driver/vk/00050000101c9300.bin" ]; then
      rm "${CEMU_CACHES}/shaderCache/driver/vk/00050000101c9300.bin"
      echo "清除了日版 botw 用户缓存"
      else
      if [ -f "${CEMU_CACHES}/shaderCache/driver/vk/00050000101c9400.bin" ]; then
            rm "${CEMU_CACHES}/shaderCache/driver/vk/00050000101c9400.bin"
            echo "清除了美版 botw 用户缓存"
      else
        if [ -f "${CEMU_CACHES}/shaderCache/driver/vk/00050000101c9500.bin" ]; then
              rm "${CEMU_CACHES}/shaderCache/driver/vk/00050000101c9500.bin"
              echo "清除了欧版 botw 用户缓存"
              else
              echo "所有 botw 用户缓存已清空"
          fi
      fi
  fi
  echo "所有 botw 用户缓存已清空"
  # 释放所有的 Botw 100%着色器缓存 以加速游戏
  cd "${CEMU_CACHES}/shaderCache" || exit
  tar -xf "${APP_DIR}/transferable.tar.gz transferable/"
  echo "所有 botw 100%着色器缓存已释放"
fi

# 开启 Cemu
/Applications/Cemu.app/Contents/MacOS/Cemu -g "${CEMU_DIR}/${GAME_DIR}"