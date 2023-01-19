# 获取当前目录
DIR=$(cd $(dirname $0) && pwd)
# 设定变量
# Cemu 目录
CEMU_DIR="${HOME}/Library/Application Support/Cemu"
CEMU_CACHES="${HOME}/Library/Caches/Cemu"
# 备份目录&文件名
NOW=$(date +'%Y_%m_%d_%H_%M_%S')
BACKUP_CACHES_DIR="${CEMU_DIR}/ConfigBackups/shaderCache"
BACKUP_SAVE_DIR="${CEMU_DIR}/ConfigBackups/save"
BACKUP_NAME="_backup_${NOW}.tar.gz"
# 启动器 Resources 目录
APP_DIR=${DIR//MacOS/}Resources/
# 读取配置文件
if [ -f "${CEMU_DIR}/cemu.config" ]; then
  for line in "${CEMU_DIR}/cemu.config"; do
    USER_ID=$(cat "${line}" | grep "USER_ID=" | sed "s/^.*=//")
    RENION=$(cat "${line}" | grep "RENION=" | sed "s/^.*=//")
    TARGET=$(cat "${line}" | grep "TARGET=" | sed "s/^.*=//")
    SAVE=$(cat "${line}" | grep "SAVE=" | sed "s/^.*=//")
    CACHES=$(cat "${line}" | grep "CACHES=" | sed "s/^.*=//")
  done
  # 清除 指定区域的 Botw 的用户着色器缓存以忽略错误
  rm "${CEMU_CACHES}/shaderCache/driver/vk/00050000${RENION}.bin"
  # 释放指定版本的 Botw 100%缓存文件到 cemu/shaderCache
  cd ${CEMU_CACHES}/shaderCache
  tar -xf ${APP_DIR}/transferable.tar.gz transferable/00050000${RENION}_shaders.bin
  tar -xf ${APP_DIR}/transferable.tar.gz transferable/00050000${RENION}_vkpipeline.bin
  # 现在开始备份
  # 创建备份目录
  mkdir -p "${BACKUP_CACHES_DIR}"
  mkdir -p "${BACKUP_SAVE_DIR}"
  # 判断是否备份 缓存文件
  if [ ${CACHES} = 1 ]; then
    # 备份缓存文件
    cd ${CEMU_CACHES}
    tar -czf "${BACKUP_CACHES_DIR}/shaderCache${BACKUP_NAME}" "./shaderCache"
  else
  fi
  # 判断是否备份 存档文件
  if [ ${SAVE} = 1 ]; then
    # 备份存档文件
    cd ${CEMU_DIR}/mlc01/usr/save/00050000/
    tar -czf "${BACKUP_SAVE_DIR}/botw_save${BACKUP_NAME}" "./${RENION}"
  else
  fi
else
  # 清除 所有的 Botw 的用户着色器缓存以忽略错误
  rm "$CEMU_CACHES/shaderCache/driver/vk/00050000101c9300.bin"
  rm "$CEMU_CACHES/shaderCache/driver/vk/00050000101c9400.bin"
  rm "$CEMU_CACHES/shaderCache/driver/vk/00050000101c9500.bin"
  # 释放所有的 Botw 100%着色器缓存 以加速游戏
  cd ${CEMU_CACHES}/shaderCache
  tar -xf ${APP_DIR}/transferable.tar.gz transferable/
fi
# 开启 Cemu
open /Applications/Cemu.app