pnpmreset() {
  rm -rf **/node_modules(N/)
  rm -rf pnpm-lock.yaml
  pnpm store prune
  pnpm install --no-frozen-lockfile
}

awake() {
  local current=$(pmset -g | grep -c "SleepDisabled.*1")
  local want

  case $1 in
    on)  want=1 ;;
    off) want=0 ;;
    *)   want=$(( current > 0 ? 0 : 1 )) ;;
  esac

  if [[ $current -eq $want ]]; then
    if [[ $want -eq 1 ]]; then
      echo "💡 이미 잠자기가 비활성화되어 있습니다"
    else
      echo "😴 이미 정상 상태입니다"
    fi
    return
  fi

  sudo pmset -a disablesleep "$want"
  if [[ $want -eq 1 ]]; then
    echo "💡 잠자기 비활성화 — 뚜껑을 닫아도 깨어 있습니다"
  else
    echo "😴 잠자기 복원 — 정상 동작으로 돌아갑니다"
  fi
}

killport() {
  if [[ $# -eq 0 ]]; then
    echo "Usage: killport <port> [port2] [port3] ..."
    echo "       killport 5173 5174 5175"
    return 1
  fi

  for port in "$@"; do
    local pids=$(lsof -ti :$port 2>/dev/null)
    if [[ -n "$pids" ]]; then
      echo "$pids" | xargs kill -9
      echo "Killed processes on port $port"
    else
      echo "No process on port $port"
    fi
  done
}
