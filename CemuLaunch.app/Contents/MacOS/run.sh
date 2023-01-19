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
for line in "${CEMU_DIR}/cemu.config"; do
  USER_ID=$(cat "${line}" | grep "USER_ID=" | sed "s/^.*=//")
  RENION=$(cat "${line}" | grep "RENION=" | sed "s/^.*=//")
  TARGET=$(cat "${line}" | grep "TARGET=" | sed "s/^.*=//")
  SAVE=$(cat "${line}" | grep "SAVE=" | sed "s/^.*=//")
  CACHES=$(cat "${line}" | grep "CACHES=" | sed "s/^.*=//")
done
# 释放缓存文件到 cemu/shaderCache
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
open /Applications/Cemu.app