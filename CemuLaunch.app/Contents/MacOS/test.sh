if [ -d "${HOME}/Library/Application Support/Cemu/Game" ]; then
  echo "找到游戏目录"
  if [ -d "${HOME}/Library/Application Support/Cemu/Game/Breath of the Wild" ]; then
      echo "找到游戏"
      else
      echo "未找到游戏，将直接启动 Cemu"
  fi
  else
  echo "未找到游戏目录，将直接启动 Cemu"
fi