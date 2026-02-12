#!/bin/bash
# 파일 연결 설정 (duti)

echo "🔗 파일 연결 설정 중..."

VSCODE="com.microsoft.VSCode"

# 확장자 없는 파일
duti -s $VSCODE public.data all

# 웹 개발 확장자
EXTENSIONS=(
  # Markup
  .svg

  # Styles
  .css

  # JavaScript
  .js .jsx .mjs .cjs

  # TypeScript
  .ts .tsx

  # Data
  .json .yaml

  # Markdown
  .md

  # Shell
  .sh

  # Config
  .env
  .prettierrc

  # Text
  .txt .log .diff .patch
)

for ext in "${EXTENSIONS[@]}"; do
  duti -s $VSCODE "$ext" all
done

echo "✅ 파일 연결 설정 완료"
