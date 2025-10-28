## Generic logger that works across all modules
log() {
  local level=$1
  shift
  
  # Build context from function stack
  # funcstack[2] = calling function (e.g., "nudges::check_staleness")
  local caller=${funcstack[2]:-unknown}
  
  # Extract module and function name
  # "nudges::check_staleness" -> module="nudges", func="check_staleness"
  local module=${caller%%::*}
  local func=${caller#*::}
  
  # Try increasingly specific contexts
  local context=":${module}:${func}"
  
  # Check if debug is enabled (checks hierarchy automatically)
  if ! zstyle -t "$context" debug; then
    return 0
  fi
  
  # Get minimum log level
  local min_level
  zstyle -s "$context" log-level min_level || min_level='info'
  
  local level_num=$(_log::level_to_num $level)
  local min_num=$(_log::level_to_num $min_level)
  
  [[ $level_num -lt $min_num ]] && return 0
  
  # Output the log
  echo "[$(date +%T)] [$module:$func] ${level:u}: $*" >&2
}

_log::level_to_num() {
  case $1 in
    trace) echo 0 ;;
    debug) echo 1 ;;
    info)  echo 2 ;;
    warn)  echo 3 ;;
    error) echo 4 ;;
    *)     echo 2 ;;
  esac
}

# Convenience wrappers
log::trace() { log trace "$@" }
log::debug() { log debug "$@" }
log::info()  { log info "$@" }
log::warn()  { log warn "$@" }
log::error() { log error "$@" } 
