# 🎯 Claude Code용 기획 스킬셋

**AI 기반 웹 애플리케이션 기획 시스템 - 8개의 전문화된 에이전트**

[![라이선스: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Claude Code](https://img.shields.io/badge/Claude%20Code-Compatible-blue)](https://claude.com/claude-code)
[![버전](https://img.shields.io/badge/Version-1.0.0-green)](#)
[![상태](https://img.shields.io/badge/Status-Production-success)](#)

**Languages** | 언어
--- | ---
[English](README.md) | [한국어 (Korean)](README.ko.md)

---

## 📋 개요

**기획 스킬셋**은 Claude Code와 통합된 포괄적인 AI 기반 기획 시스템입니다. 초기 리서치부터 전략 수립까지 웹 애플리케이션 기획 전체 과정을 안내하는 8개의 전문화된 에이전트를 제공합니다.

### 🎯 무엇을 할 수 있나요?

- 🔍 **리서치** - 시장 조사 및 데이터 수집
- 📊 **분석** - 수집된 데이터에서 인사이트 도출
- 💡 **아이데이션** - 인사이트 기반 창의적 솔루션 생성
- 🏗️ **구조화** - 제품 명세서 및 아키텍처 정의
- ✔️ **검증** - 종합적인 계획 검증
- 👥 **사용자중심** - 사용자 경험(UX) 최적화
- 📢 **커뮤니케이션** - 이해관계자 소통 전략 개발
- 🎯 **전략수립** - 장기 비즈니스 전략 수립

---

## 🚀 빠른 시작

### 1️⃣ 설치

#### 옵션 A: Bash 스크립트 (권장)
```bash
./install.sh
```

#### 옵션 B: 수동 설치
자세한 내용은 [INSTALLATION.md](INSTALLATION.md)를 참조하세요.

### 2️⃣ 초기화
```bash
/skillset:init
```

### 3️⃣ 첫 번째 에이전트 실행
```bash
/skillset:run research
```

### 4️⃣ 진행 상황 확인
```bash
/skillset:list --status
```

---

## 📚 핵심 에이전트

| 에이전트 | 아이콘 | 목적 | 소요시간 | 난이도 |
|---------|--------|------|---------|--------|
| 리서치 | 🔍 | 시장 정보 수집 | 6-8시간 | 중간 |
| 분석 | 📊 | 데이터 분석 및 인사이트 | 5-7시간 | 중간 |
| 아이데이션 | 💡 | 창의적 아이디어 생성 | 6-8시간 | 중간 |
| 구조화 | 🏗️ | 제품 정의 | 7-9시간 | 높음 |
| 검증 | ✔️ | 종합 검증 | 4-6시간 | 중간 |
| 사용자중심 | 👥 | UX 최적화 | 6-8시간 | 중간 |
| 커뮤니케이션 | 📢 | 이해관계자 소통 | 5-7시간 | 중간 |
| 전략 | 🎯 | 비즈니스 전략 | 5-7시간 | 높음 |

---

## 📋 명령어 참조

### `/skillset:init` - 초기화
첫 실행 시 스킬셋을 설정합니다.
```bash
/skillset:init              # 표준 초기화
/skillset:init --reset      # 메타데이터 초기화
/skillset:init --verbose    # 상세 로그 표시
```

### `/skillset:run` - 에이전트 실행
특정 기획 에이전트를 실행합니다.
```bash
/skillset:run research              # 리서치 에이전트 실행
/skillset:run analysis --guide      # 가이드와 함께 실행
/skillset:run --continue            # 마지막 에이전트부터 계속
```

### `/skillset:list` - 진행 상황 보기
에이전트와 현재 진행 상황을 표시합니다.
```bash
/skillset:list              # 모든 에이전트 표시
/skillset:list --status     # 진행 상황 요약
/skillset:list --details    # 상세 정보
/skillset:list --json       # JSON 형식 출력
```

### `/skillset:guide` - 가이드 보기
에이전트별 가이드를 표시합니다.
```bash
/skillset:guide research          # 전체 가이드
/skillset:guide research --short  # 빠른 요약
/skillset:guide research --full   # 완전한 가이드
/skillset:guide research --print  # 인쇄용 형식
```

---

## 📁 프로젝트 구조

```
planning-skillset/
├── agents/                    # 8개 에이전트 YAML 정의
│   ├── research-agent.yaml
│   ├── analysis-agent.yaml
│   └── ...
├── guides/                    # 에이전트 가이드 및 문서
│   ├── research-guide.md
│   ├── analysis-guide.md
│   └── ...
├── commands/                  # Claude Code 명령어
│   ├── init.md
│   ├── run.md
│   ├── list.md
│   └── guide.md
├── lib/skillset/              # 유틸리티 스크립트
│   ├── skillset-utils.sh
│   └── skillset-auto-init.sh
├── docs/                      # 상세 문서
│   ├── ARCHITECTURE.md
│   ├── API.md
│   ├── EXAMPLES.md
│   └── TROUBLESHOOTING.md
├── tests/                     # 테스트 스크립트
├── install.sh                 # 설치 스크립트
├── uninstall.sh               # 제거 스크립트
├── verify.sh                  # 검증 스크립트
├── manifest.yaml              # Claude Code 매니페스트
├── package.json               # 패키지 메타데이터
├── README.md                  # 이 파일 (영어)
├── README.ko.md               # 한글 버전
├── INSTALLATION.md            # 설치 가이드
├── CONTRIBUTING.md            # 기여 가이드
├── CHANGELOG.md               # 버전 히스토리
└── LICENSE                    # MIT 라이선스
```

---

## 💡 사용 시나리오

### 시나리오 1: 전체 기획 워크플로우
```bash
# 초기화
/skillset:init

# 에이전트를 순서대로 실행
/skillset:run research
/skillset:run analysis
/skillset:run ideation
/skillset:run structure
/skillset:run validation
/skillset:run user-centered
/skillset:run communication
/skillset:run strategy

# 최종 진행 상황 보기
/skillset:list --status
```

### 시나리오 2: 특정 에이전트만 다시 실행
```bash
# 이미 리서치, 분석 완료
# 아이데이션만 다시 하기
/skillset:run ideation --guide
```

### 시나리오 3: 도움 받기
```bash
# 시작하기 전 빠른 가이드 보기
/skillset:guide research --short

# 완전한 가이드 보기
/skillset:guide research --full

# 나중에 참고할 수 있게 저장
/skillset:guide research --full --print > research-guide.txt
```

---

## 📊 주요 특징

✅ **8개 전문화된 에이전트** - 각 기획 단계에 특화된 에이전트
✅ **점진적 정보 공개** - 단계별 정보 공개로 더 나은 사용자 경험
✅ **실시간 추적** - 모든 에이전트의 진행 상황 모니터링
✅ **자동 초기화** - 첫 실행 시 자동 설정
✅ **크로스 플랫폼** - macOS, Linux, Windows WSL 지원
✅ **포괄적 가이드** - 각 에이전트별 상세 문서
✅ **오류 복구** - 내장된 오류 처리 및 복구
✅ **메타데이터 관리** - JSON 기반 진행 상황 추적

---

## 🔧 요구사항

- **Claude Code** v1.0.0 이상
- **Bash** 4.0 이상
- **jq** (선택사항, JSON 처리용)
- **macOS**, **Linux**, 또는 **Windows WSL**

---

## 📖 문서

- [설치 가이드](INSTALLATION.md) - 설정 방법
- [아키텍처](docs/ARCHITECTURE.md) - 시스템 설계 개요
- [API 레퍼런스](docs/API.md) - 명령어 및 유틸리티 문서
- [예제](docs/EXAMPLES.md) - 실제 사용 예제
- [문제 해결](docs/TROUBLESHOOTING.md) - 일반적인 문제와 해결책
- [기여하기](CONTRIBUTING.md) - 기여 방법
- [변경 이력](CHANGELOG.md) - 버전 히스토리

---

## 🎓 워크플로우

```
시작
  ↓
[단계 1] /skillset:init (초기화)
  ↓
[단계 2] /skillset:run research (리서치)
  ↓
[단계 3] /skillset:run analysis (분석)
  ↓
[단계 4] /skillset:run ideation (아이데이션)
  ↓
[단계 5] /skillset:run structure (구조화)
  ↓
┌─────────────────┬─────────────────┐
│                 │                 │
[단계 6]      [단계 6]          [단계 6]
검증           사용자중심         (하나 또는 둘 다 선택)
│               │
├───────────┬───┘
│           │
[단계 7] 커뮤니케이션
│
[단계 8] 전략
│
끝
```

---

## 🛠️ 설치 방법

### 방법 1: 자동 설치 (권장)
```bash
./install.sh
```

### 방법 2: npm 사용
```bash
npm install -g planning-skillset
```

### 방법 3: 수동 설치
[INSTALLATION.md](INSTALLATION.md)에서 단계별 지시사항을 참조하세요.

---

## ✅ 검증

설치 후 모든 것이 제대로 작동하는지 확인하세요:

```bash
./verify.sh
```

다음을 확인합니다:
- ✓ Claude Code 호환성
- ✓ 스킬셋 파일이 올바른 위치에 있음
- ✓ 명령어가 올바르게 등록됨
- ✓ 메타데이터 초기화됨
- ✓ 모든 에이전트 접근 가능

---

## 🤝 기여하기

기여를 환영합니다! [CONTRIBUTING.md](CONTRIBUTING.md)에서 다음 내용을 참조하세요:
- 버그 보고
- 기능 요청
- Pull Request 제출
- 코드 표준

---

## 📝 라이선스

이 프로젝트는 MIT 라이선스에 따라 라이선스가 부여됩니다. [LICENSE](LICENSE) 파일을 참조하세요.

---

## 🔗 링크

- **저장소**: https://github.com/anthropics/planning-skillset
- **이슈**: https://github.com/anthropics/planning-skillset/issues
- **토론**: https://github.com/anthropics/planning-skillset/discussions
- **Claude Code**: https://claude.com/claude-code

---

## 📞 지원

### 문서
- 📖 [전체 문서](docs/)
- 🎓 [에이전트 가이드](guides/)
- 💡 [예제](docs/EXAMPLES.md)

### 도움 받기
- 🐛 [이슈 보고](https://github.com/anthropics/planning-skillset/issues)
- 💬 [토론](https://github.com/anthropics/planning-skillset/discussions)
- 📧 support@planning-skillset.com

### 문제 해결
- 🔧 [문제 해결 가이드](docs/TROUBLESHOOTING.md)
- ❓ [FAQ](docs/TROUBLESHOOTING.md#faq)

---

## 🎉 시작하기

기획을 시작할 준비가 되었나요? 다음 단계를 따르세요:

1. **설치** - `./install.sh` 실행
2. **초기화** - `/skillset:init` 실행
3. **시작** - `/skillset:run research` 실행
4. **학습** - `/skillset:guide research --short` 실행
5. **진행 상황 확인** - `/skillset:list --status` 실행

행운을 빕니다! 🚀

---

**마지막 업데이트**: 2026-01-21 | **버전**: 1.0.0
