---
description: "기획 스킬셋 초기화 및 환경 설정"
argument-hint: "[--reset] [--verbose]"
type: utility
allowed-tools: Bash, Write, Read, Glob
model: inherit
---

## 🎯 명령어 목적

기획 스킬셋을 처음 사용할 때 필요한 초기 설정을 자동으로 수행합니다.

- 산출물 폴더 구조 생성 (8개 하위 폴더)
- 메타데이터 초기화
- 진행 상황 추적 시스템 설정
- 첫 실행 여부 확인

## 📋 실행 단계

### Step 1: 환경 확인
```bash
# 현재 프로젝트 디렉토리 확인
pwd

# skillset-output/ 폴더 존재 여부 확인
test -d skillset-output && echo "폴더 존재" || echo "폴더 없음"

# 필요한 폴더 목록
- skillset-output/research/
- skillset-output/analysis/
- skillset-output/ideation/
- skillset-output/structure/
- skillset-output/validation/
- skillset-output/user-centered/
- skillset-output/communication/
- skillset-output/strategy/
```

### Step 2: 폴더 구조 생성

필요한 경우 다음 폴더를 생성합니다:

```
skillset-output/
├── research/           # 리서치 에이전트 산출물
├── analysis/           # 분석 에이전트 산출물
├── ideation/           # 아이데이션 에이전트 산출물
├── structure/          # 구조화 에이전트 산출물
├── validation/         # 검증 에이전트 산출물
├── user-centered/      # 사용자중심 에이전트 산출물
├── communication/      # 커뮤니케이션 에이전트 산출물
└── strategy/           # 전략 에이전트 산출물
```

### Step 3: 메타데이터 초기화

`~/.claude/skillsets/planning-skillset/` 에 다음 파일 생성:

```json
// metadata.json
{
  "skillset_id": "planning-skillset",
  "version": "1.0.0",
  "initialized_at": "2026-01-21T12:00:00Z",
  "initialized_by": "system",
  "project_path": "/Users/kkh/Desktop/code/skillSet_build"
}

// progress.json
{
  "agents": {
    "research-agent": { "status": "pending", "started_at": null, "completed_at": null },
    "analysis-agent": { "status": "pending", "started_at": null, "completed_at": null },
    "ideation-agent": { "status": "pending", "started_at": null, "completed_at": null },
    "structure-agent": { "status": "pending", "started_at": null, "completed_at": null },
    "validation-agent": { "status": "pending", "started_at": null, "completed_at": null },
    "user-centered-agent": { "status": "pending", "started_at": null, "completed_at": null },
    "communication-agent": { "status": "pending", "started_at": null, "completed_at": null },
    "strategy-agent": { "status": "pending", "started_at": null, "completed_at": null }
  },
  "last_updated": "2026-01-21T12:00:00Z"
}
```

### Step 4: 완료 메시지

초기화 완료 후 다음 정보 표시:

```
╔════════════════════════════════════════════════════════════════╗
║  ✅ 기획 스킬셋이 초기화되었습니다!                           ║
╚════════════════════════════════════════════════════════════════╝

📁 생성된 폴더:
  ✓ skillset-output/research/
  ✓ skillset-output/analysis/
  ✓ skillset-output/ideation/
  ✓ skillset-output/structure/
  ✓ skillset-output/validation/
  ✓ skillset-output/user-centered/
  ✓ skillset-output/communication/
  ✓ skillset-output/strategy/

📋 설치된 에이전트 (8개):
  1. 🔍 리서치 에이전트
  2. 📊 분석 에이전트
  3. 💡 아이데이션 에이전트
  4. 🏗️ 구조화 에이전트
  5. ✔️ 검증 에이전트
  6. 👥 사용자중심 에이전트
  7. 📢 커뮤니케이션 에이전트
  8. 🎯 전략 에이전트

🚀 다음 단계:
  1. /skillset:list 로 에이전트 목록 확인
  2. /skillset:run research 로 첫 에이전트 시작
  3. /skillset:guide research 로 상세 가이드 보기

💡 팁:
  - 각 에이전트는 독립적으로 실행 가능합니다
  - 진행 상황은 /skillset:list 로 확인할 수 있습니다
  - 언제든지 /skillset:run <agent-name> 으로 특정 에이전트를 재실행할 수 있습니다
```

## 🔧 옵션

| 옵션 | 설명 |
|------|------|
| `--reset` | 기존 설정 초기화 및 재설정 |
| `--verbose` | 상세 로그 출력 |

## ⚠️ 주의사항

- **첫 실행만**: 첫 실행 시에만 폴더를 생성합니다 (이미 존재하면 스킵)
- **초기 메타데이터**: 처음 한 번만 메타데이터를 생성합니다
- **--reset 옵션**: 기존 진행 상황이 초기화됩니다 (신중하게 사용)

## 🎯 성공 기준

- [x] 모든 8개 산출물 폴더 생성 완료
- [x] 메타데이터 파일 생성 완료
- [x] 진행 상황 추적 파일 초기화 완료
- [x] 초기화 확인 메시지 표시

---

**명령어 예시:**
```bash
/skillset:init           # 표준 초기화
/skillset:init --reset   # 초기화 재설정
/skillset:init --verbose # 상세 로그 출력
```
