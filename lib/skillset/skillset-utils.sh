#!/bin/bash

# ============================================================================
# 기획 스킬셋 유틸리티 함수
# ============================================================================
# 용도: /skillset: 명령어들이 사용하는 공용 함수들
# 버전: 1.0.0
# ============================================================================

set -e  # 오류 발생 시 중단

# ============================================================================
# 색상 정의
# ============================================================================

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
NC='\033[0m'  # No Color

# ============================================================================
# 기본 변수 설정
# ============================================================================

SKILLSET_ID="planning-skillset"
SKILLSET_VERSION="1.0.0"
SKILLSET_HOME="${HOME}/.claude/skillsets/${SKILLSET_ID}"
PROJECT_DIR="${PWD}"
SKILLSET_OUTPUT_DIR="${PROJECT_DIR}/skillset-output"
SKILLSET_METADATA_DIR="${SKILLSET_HOME}"

# 에이전트 목록
AGENTS=(
  "research-agent"
  "analysis-agent"
  "ideation-agent"
  "structure-agent"
  "validation-agent"
  "user-centered-agent"
  "communication-agent"
  "strategy-agent"
)

# 에이전트 메타데이터 (이름, 아이콘, 순서)
declare -A AGENT_NAMES=(
  ["research-agent"]="리서치 에이전트"
  ["analysis-agent"]="분석 에이전트"
  ["ideation-agent"]="아이데이션 에이전트"
  ["structure-agent"]="구조화 에이전트"
  ["validation-agent"]="검증 에이전트"
  ["user-centered-agent"]="사용자중심 에이전트"
  ["communication-agent"]="커뮤니케이션 에이전트"
  ["strategy-agent"]="전략 에이전트"
)

declare -A AGENT_ICONS=(
  ["research-agent"]="🔍"
  ["analysis-agent"]="📊"
  ["ideation-agent"]="💡"
  ["structure-agent"]="🏗️"
  ["validation-agent"]="✔️"
  ["user-centered-agent"]="👥"
  ["communication-agent"]="📢"
  ["strategy-agent"]="🎯"
)

declare -A AGENT_DESCRIPTIONS=(
  ["research-agent"]="시장 정보 수집 및 분석 기초 제공"
  ["analysis-agent"]="수집된 데이터 분석 및 인사이트 도출"
  ["ideation-agent"]="분석 기반 창의적 아이디어 생성"
  ["structure-agent"]="아이디어를 구체적인 제품 개요로 구조화"
  ["validation-agent"]="제품 계획의 체계적 검증"
  ["user-centered-agent"]="사용자 경험(UX) 최적화"
  ["communication-agent"]="이해관계자와의 효과적인 소통"
  ["strategy-agent"]="장기 사업 전략 수립"
)

# ============================================================================
# 출력 함수들
# ============================================================================

print_header() {
  local title="$1"
  echo -e "${BLUE}"
  echo "╔════════════════════════════════════════════════════════════════╗"
  printf "║  %-60s  ║\n" "🎯 $title"
  echo "╚════════════════════════════════════════════════════════════════╝"
  echo -e "${NC}"
}

print_success() {
  echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
  echo -e "${RED}✗ $1${NC}"
}

print_warning() {
  echo -e "${YELLOW}⚠ $1${NC}"
}

print_info() {
  echo -e "${CYAN}ℹ $1${NC}"
}

# ============================================================================
# 메타데이터 관리 함수들
# ============================================================================

# 메타데이터 초기화
init_metadata() {
  mkdir -p "$SKILLSET_METADATA_DIR"

  # metadata.json 생성
  cat > "$SKILLSET_METADATA_DIR/metadata.json" << EOF
{
  "skillset_id": "$SKILLSET_ID",
  "version": "$SKILLSET_VERSION",
  "initialized_at": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "project_path": "$PROJECT_DIR"
}
EOF

  # progress.json 생성
  cat > "$SKILLSET_METADATA_DIR/progress.json" << 'EOF'
{
  "agents": {
    "research-agent": {
      "status": "pending",
      "started_at": null,
      "completed_at": null,
      "outputs": 0
    },
    "analysis-agent": {
      "status": "pending",
      "started_at": null,
      "completed_at": null,
      "outputs": 0
    },
    "ideation-agent": {
      "status": "pending",
      "started_at": null,
      "completed_at": null,
      "outputs": 0
    },
    "structure-agent": {
      "status": "pending",
      "started_at": null,
      "completed_at": null,
      "outputs": 0
    },
    "validation-agent": {
      "status": "pending",
      "started_at": null,
      "completed_at": null,
      "outputs": 0
    },
    "user-centered-agent": {
      "status": "pending",
      "started_at": null,
      "completed_at": null,
      "outputs": 0
    },
    "communication-agent": {
      "status": "pending",
      "started_at": null,
      "completed_at": null,
      "outputs": 0
    },
    "strategy-agent": {
      "status": "pending",
      "started_at": null,
      "completed_at": null,
      "outputs": 0
    }
  },
  "last_updated": "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
}
EOF
}

# 진행 상황 스캔
scan_progress() {
  local total=0
  local completed=0
  local in_progress=0

  for agent in "${AGENTS[@]}"; do
    local agent_dir="$SKILLSET_OUTPUT_DIR/${agent%-agent}"
    total=$((total + 1))

    if [ -d "$agent_dir" ] && [ "$(ls -A "$agent_dir" 2>/dev/null)" ]; then
      # 폴더가 존재하고 파일이 있으면 완료
      if grep -q "\"${agent}\": {" "$SKILLSET_METADATA_DIR/progress.json" 2>/dev/null; then
        completed=$((completed + 1))
      fi
    fi
  done

  echo "$completed/$total"
}

# ============================================================================
# 폴더 관리 함수들
# ============================================================================

# 산출물 폴더 초기화
init_output_directories() {
  for agent in "${AGENTS[@]}"; do
    local agent_name="${agent%-agent}"
    mkdir -p "$SKILLSET_OUTPUT_DIR/$agent_name"
    print_success "폴더 생성: skillset-output/$agent_name/"
  done
}

# 폴더 존재 여부 확인
check_output_directories() {
  local all_exist=true

  for agent in "${AGENTS[@]}"; do
    local agent_name="${agent%-agent}"
    if [ ! -d "$SKILLSET_OUTPUT_DIR/$agent_name" ]; then
      all_exist=false
      print_warning "폴더 없음: skillset-output/$agent_name/"
    fi
  done

  return $([ "$all_exist" = true ] && echo 0 || echo 1)
}

# ============================================================================
# 에이전트 검증 함수들
# ============================================================================

# 에이전트 ID 유효성 검증
is_valid_agent() {
  local agent_id="$1"

  for agent in "${AGENTS[@]}"; do
    if [ "$agent" = "$agent_id" ]; then
      return 0
    fi
  done

  return 1
}

# 에이전트 이름으로 ID 찾기
get_agent_id() {
  local agent_short="$1"

  if is_valid_agent "${agent_short}-agent"; then
    echo "${agent_short}-agent"
    return 0
  fi

  return 1
}

# 선행 조건 확인
check_prerequisites() {
  local agent_id="$1"

  case "$agent_id" in
    "research-agent")
      # 선행 조건 없음
      return 0
      ;;
    "analysis-agent")
      # research-agent 필수
      [ -d "$SKILLSET_OUTPUT_DIR/research" ] && [ "$(ls -A "$SKILLSET_OUTPUT_DIR/research" 2>/dev/null)" ] && return 0
      return 1
      ;;
    "ideation-agent")
      # analysis-agent 필수
      [ -d "$SKILLSET_OUTPUT_DIR/analysis" ] && [ "$(ls -A "$SKILLSET_OUTPUT_DIR/analysis" 2>/dev/null)" ] && return 0
      return 1
      ;;
    "structure-agent")
      # ideation-agent 필수
      [ -d "$SKILLSET_OUTPUT_DIR/ideation" ] && [ "$(ls -A "$SKILLSET_OUTPUT_DIR/ideation" 2>/dev/null)" ] && return 0
      return 1
      ;;
    "validation-agent")
      # structure-agent 필수
      [ -d "$SKILLSET_OUTPUT_DIR/structure" ] && [ "$(ls -A "$SKILLSET_OUTPUT_DIR/structure" 2>/dev/null)" ] && return 0
      return 1
      ;;
    *)
      # 그 외: structure-agent 필수 (기본)
      [ -d "$SKILLSET_OUTPUT_DIR/structure" ] && [ "$(ls -A "$SKILLSET_OUTPUT_DIR/structure" 2>/dev/null)" ] && return 0
      return 1
      ;;
  esac
}

# ============================================================================
# UI/표시 함수들
# ============================================================================

# 에이전트 목록 표시
display_agent_list() {
  local show_status="$1"

  echo ""
  for i in "${!AGENTS[@]}"; do
    local agent="${AGENTS[$i]}"
    local index=$((i + 1))
    local icon="${AGENT_ICONS[$agent]}"
    local name="${AGENT_NAMES[$agent]}"
    local desc="${AGENT_DESCRIPTIONS[$agent]}"

    printf "[%d/8] %s %s\n" "$index" "$icon" "$name"
    printf "      %s\n" "$desc"

    if [ "$show_status" = "true" ]; then
      local agent_dir="$SKILLSET_OUTPUT_DIR/${agent%-agent}"
      if [ -d "$agent_dir" ] && [ "$(ls -A "$agent_dir" 2>/dev/null)" ]; then
        printf "      상태: %s 완료\n" "✅"
      else
        printf "      상태: %s 미작성\n" "🔲"
      fi
    fi
    echo ""
  done
}

# 진행 상황 막대 표시
display_progress_bar() {
  local completed="$1"
  local total="$2"
  local percentage=$((completed * 100 / total))
  local filled=$((percentage / 10))
  local empty=$((10 - filled))

  printf "["
  for ((i=0; i<filled; i++)); do printf "█"; done
  for ((i=0; i<empty; i++)); do printf "░"; done
  printf "] %d%% (%d/%d)\n" "$percentage" "$completed" "$total"
}

# ============================================================================
# 파일 관리 함수들
# ============================================================================

# 가이드 파일 읽기 (처음 N줄)
read_guide_short() {
  local agent_id="$1"
  local agent_short="${agent_id%-agent}"
  local guide_file="${PROJECT_DIR}/agents-skillset/guides/${agent_short}-guide.md"

  if [ -f "$guide_file" ]; then
    head -50 "$guide_file"
  else
    echo "가이드를 찾을 수 없습니다: $guide_file"
  fi
}

# 가이드 파일 읽기 (전체)
read_guide_full() {
  local agent_id="$1"
  local agent_short="${agent_id%-agent}"
  local guide_file="${PROJECT_DIR}/agents-skillset/guides/${agent_short}-guide.md"

  if [ -f "$guide_file" ]; then
    cat "$guide_file"
  else
    echo "가이드를 찾을 수 없습니다: $guide_file"
  fi
}

# ============================================================================
# 상태 체크 함수
# ============================================================================

# 초기화 여부 확인
is_initialized() {
  [ -f "$SKILLSET_METADATA_DIR/metadata.json" ] && [ -f "$SKILLSET_METADATA_DIR/progress.json" ]
}

# 프로젝트 확인
is_valid_project() {
  [ -d "$PROJECT_DIR/skillset-output" ]
}

# ============================================================================
# 내보내기 (다른 스크립트에서 사용 가능)
# ============================================================================

export -f print_header
export -f print_success
export -f print_error
export -f print_warning
export -f print_info
export -f init_metadata
export -f init_output_directories
export -f check_output_directories
export -f is_valid_agent
export -f get_agent_id
export -f check_prerequisites
export -f display_agent_list
export -f display_progress_bar
export -f is_initialized
export -f is_valid_project
export -f read_guide_short
export -f read_guide_full

# ============================================================================
# 끝
# ============================================================================
