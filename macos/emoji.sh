#!/bin/bash
# 터미널 이모지 렌더링 확인

green='\033[0;32m'
bold='\033[1m'
reset='\033[0m'

echo ""
echo -e "${bold}아이콘 렌더링 확인${reset}"
echo -e "  ${green}⏺${reset} ⏺  텍스트 기호로 보여야 합니다 (컬러 이모지 ✗). 초록/흰색 구분 필수"
echo -e "  🚀     항상 보여야 합니다"
echo -e "  🤖     터미널에서 보이면 OK. 에디터(Source Code Pro)에서는 안 보여도 정상"
echo -e "  ☕     안 보여도 정상입니다 (Geist Mono 폰트 폴백으로 보일 수 있음)"
