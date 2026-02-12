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
