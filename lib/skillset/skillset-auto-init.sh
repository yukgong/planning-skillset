#!/bin/bash

# ============================================================================
# 기획 스킬셋 자동 초기화 훅
# ============================================================================
# 용도: Claude Code SessionStart 시 자동 실행
# 목적: 첫 실행 시 필요한 폴더 및 메타데이터 자동 생성
# ============================================================================

# 기본 설정
SKILLSET_ID="planning-skillset"
SKILLSET_HOME="${HOME}/.claude/skillsets/${SKILLSET_ID}"
PROJECT_DIR="${PWD}"
SKILLSET_OUTPUT_DIR="${PROJECT_DIR}/skillset-output"

# 색상 정의 (선택사항)
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# ============================================================================
# 초기화 확인 및 실행
# ============================================================================

# 1. 메타데이터 디렉토리 확인
if [ ! -d "$SKILLSET_HOME" ]; then
  mkdir -p "$SKILLSET_HOME"
fi

# 2. 첫 실행 여부 확인
if [ ! -f "$SKILLSET_HOME/metadata.json" ]; then
  # 첫 실행: 자동 초기화 수행

  # 2-1. 산출물 폴더 생성
  mkdir -p "$SKILLSET_OUTPUT_DIR"/{research,analysis,ideation,structure,validation,user-centered,communication,strategy}

  # 2-2. 메타데이터 생성
  cat > "$SKILLSET_HOME/metadata.json" << 'EOF'
{
  "skillset_id": "planning-skillset",
  "version": "1.0.0",
  "initialized_at": "2026-01-21T00:00:00Z",
  "auto_initialized": true,
  "environment": "claude-code"
}
EOF

  # 2-3. 진행 상황 파일 생성
  cat > "$SKILLSET_HOME/progress.json" << 'EOF'
{
  "agents": {
    "research-agent": { "status": "pending", "started_at": null, "completed_at": null, "outputs": 0 },
    "analysis-agent": { "status": "pending", "started_at": null, "completed_at": null, "outputs": 0 },
    "ideation-agent": { "status": "pending", "started_at": null, "completed_at": null, "outputs": 0 },
    "structure-agent": { "status": "pending", "started_at": null, "completed_at": null, "outputs": 0 },
    "validation-agent": { "status": "pending", "started_at": null, "completed_at": null, "outputs": 0 },
    "user-centered-agent": { "status": "pending", "started_at": null, "completed_at": null, "outputs": 0 },
    "communication-agent": { "status": "pending", "started_at": null, "completed_at": null, "outputs": 0 },
    "strategy-agent": { "status": "pending", "started_at": null, "completed_at": null, "outputs": 0 }
  },
  "initialized": true
}
EOF

  # 환경 변수 설정 (다른 스크립트에서 사용 가능)
  export SKILLSET_INITIALIZED="true"
fi

# 3. 버전 체크 (향후 마이그레이션 지원용)
if [ -f "$SKILLSET_HOME/metadata.json" ]; then
  # 메타데이터가 이미 존재 - 그냥 통과
  export SKILLSET_INITIALIZED="true"
fi

# ============================================================================
# 끝 - 침입적이지 않게 조용히 실행됨
# ============================================================================
