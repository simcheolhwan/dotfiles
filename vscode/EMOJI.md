# VS Code 터미널 이모지 렌더링

VS Code 터미널(xterm.js)에서 이모지가 렌더링되는 방식과, 폰트 체인 설정이 ANSI 색상에 미치는 영향을 정리한다.

## Unicode Emoji_Presentation 속성

Unicode는 각 문자에 기본 표현 방식(presentation)을 지정한다.

| 속성                     | 기본 표현 | 예시                   |
| ------------------------ | --------- | ---------------------- |
| `Emoji_Presentation=Yes` | 이모지    | U+1F680 🚀, U+1F916 🤖 |
| `Emoji_Presentation=No`  | 텍스트    | U+23FA ⏺, U+2615 ☕    |

- `Emoji_Presentation=Yes`: 별도 지시 없이도 컬러 이모지로 렌더링된다.
- `Emoji_Presentation=No`: 기본은 텍스트(모노크롬) 표현이며, Variation Selector 16(U+FE0F)을 붙여야 이모지로 렌더링된다.

## xterm.js의 이모지 감지 및 폰트 폴백

VS Code 터미널은 xterm.js를 사용한다. xterm.js는 문자의 Unicode 속성을 기반으로 폭(narrow/wide)과 표현 방식을 결정한다.

1. `Emoji_Presentation=Yes`인 문자(U+1Fxxx 대부분): wide(2셀)로 처리하고, 시스템 이모지 폰트로 폴백한다.
2. `Emoji_Presentation=No`인 문자(U+2xxx 대부분): narrow(1셀)로 처리하고, 지정된 폰트 체인에서 글리프를 찾는다.

핵심: U+1Fxxx 이모지는 폰트 체인과 무관하게 시스템 이모지 폰트(Apple Color Emoji)로 렌더링되지만, U+2xxx 문자는 폰트 체인의 영향을 직접 받는다.

## U+1Fxxx vs U+2xxx 렌더링 차이

### U+1Fxxx (🚀, 🤖 등)

- `Emoji_Presentation=Yes`이므로 어떤 폰트 체인이든 시스템 이모지 폰트로 자동 폴백한다.
- 폰트 체인에 Apple Color Emoji가 없어도 정상적으로 컬러 이모지로 표시된다.

### U+2xxx (⏺ U+23FA, ☕ U+2615 등)

- `Emoji_Presentation=No`이므로 폰트 체인에 따라 렌더링이 달라진다.
- 폰트 체인에 이모지 폰트가 없으면: 텍스트 글리프(모노크롬)로 렌더링되어 ANSI 색상이 적용된다.
- 폰트 체인에 Apple Color Emoji가 있으면: 해당 폰트에서 컬러 글리프를 찾아 이모지로 렌더링하며, ANSI 색상이 무시된다.

## 문제: Apple Color Emoji와 ⏺(U+23FA)

Claude Code는 ⏺를 ANSI 색상(초록/빨강/흰색)으로 구분하여 상태를 표시한다.

```
"terminal.integrated.fontFamily": "Geist Mono, Apple Color Emoji"
```

이 설정에서는 ⏺가 Apple Color Emoji의 컬러 글리프로 렌더링되어 ANSI escape 코드가 무시된다. 모든 ⏺가 동일한 파란색 원으로 표시되어 상태 구분이 불가능하다.

```
"terminal.integrated.fontFamily": "Geist Mono"
```

Apple Color Emoji를 제거하면 ⏺는 Geist Mono(또는 시스템 폴백 텍스트 폰트)의 모노크롬 글리프로 렌더링되어 ANSI 색상이 정상 적용된다.

## 주요 폰트의 U+23FA(⏺) 글리프 포함 여부

| 폰트              | U+23FA 포함 | 비고                     |
| ----------------- | ----------- | ------------------------ |
| Geist Mono        | No          | 시스템 폴백에 위임       |
| Menlo             | No          | macOS 기본 모노스페이스  |
| SF Mono           | No          | Apple 터미널 기본 폰트   |
| Apple Symbols     | Yes         | 텍스트 글리프 (모노크롬) |
| Apple Color Emoji | Yes         | 컬러 글리프 (ANSI 무시)  |
| LastResort        | Yes         | 최종 폴백 폰트           |

Geist Mono, Menlo, SF Mono 등 일반 모노스페이스 폰트에는 ⏺ 글리프가 없다. macOS의 폰트 폴백 체인에서 Apple Symbols가 텍스트 글리프를 제공하며, 이 경우 ANSI 색상이 정상 적용된다.

## 주요 폰트의 U+2615(☕) 글리프 포함 여부

| 폰트              | U+2615 포함 | 비고                         |
| ----------------- | ----------- | ---------------------------- |
| Geist Mono        | No          | 시스템 폴백에 위임           |
| Menlo             | Yes         | 텍스트 글리프 (모노크롬)     |
| SF Mono           | No          | 시스템 폴백에 위임           |
| Apple Symbols     | Yes         | 텍스트 글리프 (모노크롬)     |
| Apple Color Emoji | Yes         | 컬러 글리프 (sbix, 9개 크기) |

U+23FA(⏺)와 달리 Menlo와 Apple Symbols에 텍스트 글리프가 존재한다. Apple Color Emoji를 폰트 체인에서 제거해도 시스템 폴백으로 모노크롬 텍스트가 정상 렌더링된다.

## 에디터(Monaco) vs 터미널(xterm.js) 렌더링

VS Code의 에디터와 터미널은 서로 다른 렌더링 엔진을 사용하며, 이모지 폰트 폴백 동작이 다르다.

| 구분           | 에디터 (Monaco)      | 터미널 (xterm.js)     |
| -------------- | -------------------- | --------------------- |
| 렌더링 방식    | Canvas 기반          | DOM 기반              |
| 폰트 폴백      | 제한적               | 시스템 폴백 정상 작동 |
| 컬러 폰트 지원 | SVG 컬러 폰트 불완전 | CSS font-family 폴백  |

### Source Code Pro에서 🚀만 정상 렌더링되는 이유

에디터 폰트 Source Code Pro는 약 13개의 SVG 컬러 이모지를 내장하고 있다.

| 문자       | Source Code Pro 글리프 | 렌더링 결과                             |
| ---------- | ---------------------- | --------------------------------------- |
| 🚀 U+1F680 | 없음                   | 시스템 Apple Color Emoji로 폴백 → 정상  |
| 🤖 U+1F916 | SVG 컬러 글리프 있음   | Canvas에서 SVG 렌더링 불완전 → 깨짐     |
| ☕ U+2615  | SVG 컬러 글리프 있음   | Canvas에서 SVG 렌더링 불완전 → 깨짐     |
| ⏺ U+23FA   | 없음                   | 시스템 폴백 시도 → Canvas 제한으로 실패 |

핵심 메커니즘:

1. **글리프가 없는 문자(🚀)**: 폰트에 글리프가 없으므로 Chromium이 시스템 이모지 폰트(Apple Color Emoji)로 폴백한다. `Emoji_Presentation=Yes`인 문자는 이 경로에서 정상 렌더링된다.
2. **불완전한 글리프가 있는 문자(🤖, ☕)**: Source Code Pro에 SVG 컬러 글리프가 존재하므로 Chromium은 폴백하지 않고 해당 글리프를 사용한다. 그러나 Canvas 렌더링 엔진의 SVG 컬러 폰트 지원이 불완전하여 글리프가 깨져 보인다.
3. **⏺**: Source Code Pro에 글리프가 없고, `Emoji_Presentation=No`이므로 시스템 이모지 폴백 대상이 아니다. Canvas의 일반 텍스트 폰트 폴백도 제한적이어서 렌더링에 실패한다.

참고: 터미널(xterm.js)은 DOM 기반이므로 CSS font-family의 정상적인 폴백 체인을 활용할 수 있어 이 문제가 발생하지 않는다.

## 앱별 폰트 설정

| 앱      | 위치    | 폰트            | 비고                               |
| ------- | ------- | --------------- | ---------------------------------- |
| VS Code | 에디터  | Source Code Pro | 익숙한 폰트 유지                   |
| VS Code | 터미널  | Geist Mono      | Apple Color Emoji 제거             |
| iTerm2  | Default | Geist Mono      | Non-ASCII 폰트 비활성화            |
| iTerm2  | tmux    | Geist Mono      | Non-ASCII 폰트 비활성화            |
| Fork    | —       | Geist Mono      | ⏺ ANSI 색상, ☕ 텍스트 글리프 정상 |

VS Code 에디터만 Source Code Pro를 사용하고, 나머지는 모두 Geist Mono로 통일했다.

## 결론

- `terminal.integrated.fontFamily`에서 Apple Color Emoji를 제거한다.
- U+1Fxxx 이모지(🚀, 🤖)는 시스템 폴백으로 정상 렌더링된다.
- U+2xxx 문자(⏺)는 Apple Symbols의 텍스트 글리프로 렌더링되어 ANSI 색상이 적용된다.
- ☕(U+2615)는 Menlo/Apple Symbols의 텍스트 글리프로 렌더링된다. 컬러 이모지가 필요한 곳은 U+1Fxxx 이모지로 대체한다.
