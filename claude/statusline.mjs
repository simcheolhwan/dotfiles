#!/usr/bin/env node

// Claude Code 상태 표시줄

import { readFileSync } from "node:fs"
import { execFileSync } from "node:child_process"
import { basename } from "node:path"

// 색상
const RESET = "\x1b[0m"
const GRAY = "\x1b[90m"
const WHITE = "\x1b[97m"
const RED = "\x1b[31m"
const GREEN = "\x1b[32m"
const YELLOW = "\x1b[33m"
const BLUE = "\x1b[34m"
const MAGENTA = "\x1b[35m"
const LIGHT_GRAY = "\x1b[38;5;237m"

// 유틸리티
function formatTokens(tokens) {
  return tokens >= 1000 ? `${Math.floor(tokens / 1000)}K` : String(tokens)
}

function git(dir, ...args) {
  try {
    return execFileSync("git", ["-C", dir, ...args], {
      encoding: "utf8",
      stdio: ["pipe", "pipe", "pipe"],
    }).trim()
  } catch {
    return ""
  }
}

// 표준 입력에서 JSON 페이로드 읽기
const stdin = readFileSync(0, "utf8")
const data = JSON.parse(stdin)

// 1. 모델
function renderModel() {
  const modelName = data.model?.display_name || ""
  const color = modelName.includes("Opus") ? GREEN : modelName.includes("Sonnet") ? YELLOW : RED
  return `${color}${modelName}${RESET}`
}

// 2. 폴더
function renderFolder() {
  const dir = data.workspace?.current_dir || ""
  return `${BLUE}${basename(dir)}${RESET}`
}

// 3. Git 브랜치 및 상태
function renderBranch() {
  const dir = data.workspace?.current_dir || ""
  const branch = git(dir, "branch", "--show-current")
  if (!branch) return ""
  const dirty = git(dir, "status", "--porcelain") ? "*" : ""
  const color = branch === "main" || branch === "develop" ? MAGENTA : GRAY
  return `${color}${branch}${dirty}${RESET}`
}

// 4. 컨텍스트 윈도우 사용량
function renderContext() {
  const cw = data.context_window || {}
  const contextSize = cw.context_window_size || 0
  if (contextSize === 0) return ""

  // used_percentage is pre-calculated from input tokens only
  const cu = cw.current_usage || {}
  const ratio =
    cw.used_percentage != null
      ? cw.used_percentage / 100
      : contextSize > 0
        ? ((cu.input_tokens || 0) + (cu.cache_creation_input_tokens || 0) + (cu.cache_read_input_tokens || 0)) / contextSize
        : 0
  const totalUsed = Math.round(ratio * contextSize)

  const barLen = 10
  const filled = Math.round(ratio * barLen)
  const filledColor = ratio < 0.2 ? GREEN : ratio < 0.8 ? YELLOW : RED
  const bar = `${filledColor}\u2501`.repeat(filled) + `${LIGHT_GRAY}\u2501`.repeat(barLen - filled)
  return `${WHITE}${formatTokens(totalUsed)}/${formatTokens(contextSize)} ${bar}${RESET}`
}

// 포맷된 상태 표시줄을 표준 출력에 쓰기
const parts = [renderModel(), renderFolder(), renderBranch(), renderContext()].filter(Boolean)
process.stdout.write(parts.join(" "))
