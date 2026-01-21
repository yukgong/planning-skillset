#!/bin/bash

# ============================================================================
# Planning Skillset Verification Script
# ============================================================================
# Version: 1.0.0
# Purpose: Verify Planning Skillset Installation
# ============================================================================

# Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

VERBOSE="${VERBOSE:-false}"
PASSED=0
FAILED=0

# ============================================================================
# Functions
# ============================================================================

print_header() {
  echo -e "\n${BLUE}╔════════════════════════════════════════════════════════════════╗${NC}"
  printf "${BLUE}║  %-60s  ║${NC}\n" "$1"
  echo -e "${BLUE}╚════════════════════════════════════════════════════════════════╝${NC}\n"
}

print_pass() {
  echo -e "${GREEN}✓ $1${NC}"
  PASSED=$((PASSED + 1))
}

print_fail() {
  echo -e "${RED}✗ $1${NC}"
  FAILED=$((FAILED + 1))
}

print_warn() {
  echo -e "${YELLOW}⚠ $1${NC}"
}

print_info() {
  echo -e "${CYAN}ℹ $1${NC}"
}

verbose() {
  if [ "$VERBOSE" = "true" ]; then
    echo -e "${CYAN}[DEBUG] $1${NC}"
  fi
}

# Find Claude Code
find_claude_home() {
  if [ -d "$HOME/.claude" ]; then
    echo "$HOME/.claude"
  elif [ -d "$HOME/Library/Application Support/Claude Code" ]; then
    echo "$HOME/Library/Application Support/Claude Code"
  elif [ -d "$HOME/.config/claude-code" ]; then
    echo "$HOME/.config/claude-code"
  fi
}

# ============================================================================
# Verification Checks
# ============================================================================

print_header "🎯 Planning Skillset Verification v1.0.0"

echo "System Information:"
echo "  OS: $(uname -s)"
echo "  User: $(whoami)"
echo "  Shell: $SHELL"
echo ""

# Check 1: Claude Code Installation
print_info "Checking Claude Code installation..."
CLAUDE_HOME=$(find_claude_home)
if [ -n "$CLAUDE_HOME" ]; then
  print_pass "Claude Code found: $CLAUDE_HOME"
  verbose "CLAUDE_HOME=$CLAUDE_HOME"
else
  print_fail "Claude Code not found"
  exit 1
fi
echo ""

# Check 2: Skillset Directories
print_info "Checking skillset directories..."

checks_passed=0
checks_total=4

# 2.1: Agents
if [ -d "$CLAUDE_HOME/skillsets/planning-skillset/agents" ]; then
  agent_count=$(ls "$CLAUDE_HOME/skillsets/planning-skillset/agents"/*.yaml 2>/dev/null | wc -l)
  if [ "$agent_count" -eq 8 ]; then
    print_pass "Agents: 8 files found"
    checks_passed=$((checks_passed + 1))
  else
    print_warn "Agents: found $agent_count files (expected 8)"
  fi
else
  print_fail "Agents directory not found"
fi

# 2.2: Guides
if [ -d "$CLAUDE_HOME/skillsets/planning-skillset/guides" ]; then
  guide_count=$(ls "$CLAUDE_HOME/skillsets/planning-skillset/guides"/*.md 2>/dev/null | wc -l)
  if [ "$guide_count" -eq 8 ]; then
    print_pass "Guides: 8 files found"
    checks_passed=$((checks_passed + 1))
  else
    print_warn "Guides: found $guide_count files (expected 8)"
  fi
else
  print_fail "Guides directory not found"
fi

# 2.3: Commands
if [ -d "$CLAUDE_HOME/commands/skillset" ]; then
  cmd_count=$(ls "$CLAUDE_HOME/commands/skillset"/*.md 2>/dev/null | wc -l)
  if [ "$cmd_count" -eq 4 ]; then
    print_pass "Commands: 4 files found (init, run, list, guide)"
    checks_passed=$((checks_passed + 1))
  else
    print_warn "Commands: found $cmd_count files (expected 4)"
  fi
else
  print_fail "Commands directory not found"
fi

# 2.4: Utilities
if [ -d "$CLAUDE_HOME/lib/skillset" ]; then
  util_count=$(ls "$CLAUDE_HOME/lib/skillset"/*.sh 2>/dev/null | wc -l)
  if [ "$util_count" -ge 2 ]; then
    print_pass "Utilities: $util_count files found"
    checks_passed=$((checks_passed + 1))
  else
    print_warn "Utilities: found $util_count files (expected 2+)"
  fi
else
  print_fail "Utilities directory not found"
fi

echo ""
verbose "Directory checks: $checks_passed/$checks_total passed"
echo ""

# Check 3: Metadata Files
print_info "Checking metadata..."

meta_checks_passed=0
meta_checks_total=2

if [ -f "$HOME/.claude/skillsets/planning-skillset/metadata.json" ]; then
  print_pass "metadata.json found"
  meta_checks_passed=$((meta_checks_passed + 1))
else
  print_fail "metadata.json not found"
fi

if [ -f "$HOME/.claude/skillsets/planning-skillset/progress.json" ]; then
  print_pass "progress.json found"
  meta_checks_passed=$((meta_checks_passed + 1))
else
  print_fail "progress.json not found"
fi

echo ""
verbose "Metadata checks: $meta_checks_passed/$meta_checks_total passed"
echo ""

# Check 4: File Permissions
print_info "Checking file permissions..."

perm_checks_passed=0
perm_checks_total=3

# Commands executable
if [ -d "$CLAUDE_HOME/commands/skillset" ]; then
  if [ -r "$CLAUDE_HOME/commands/skillset/init.md" ]; then
    print_pass "Commands readable"
    perm_checks_passed=$((perm_checks_passed + 1))
  else
    print_warn "Commands not readable"
  fi
fi

# Utilities executable
if [ -d "$CLAUDE_HOME/lib/skillset" ]; then
  if [ -x "$CLAUDE_HOME/lib/skillset/skillset-utils.sh" 2>/dev/null ] || [ -r "$CLAUDE_HOME/lib/skillset/skillset-utils.sh" ]; then
    print_pass "Utilities accessible"
    perm_checks_passed=$((perm_checks_passed + 1))
  else
    print_warn "Utilities not accessible"
  fi
fi

# Output directory
if [ -d "./skillset-output" ]; then
  if [ -w "./skillset-output" ]; then
    print_pass "Output directory writable"
    perm_checks_passed=$((perm_checks_passed + 1))
  else
    print_warn "Output directory not writable"
  fi
fi

echo ""
verbose "Permission checks: $perm_checks_passed/$perm_checks_total passed"
echo ""

# Check 5: Feature Verification
print_info "Checking features..."

feat_checks_passed=0
feat_checks_total=4

# Check for key functions in utils
if grep -q "print_header" "$CLAUDE_HOME/lib/skillset/skillset-utils.sh" 2>/dev/null; then
  print_pass "Utility functions present"
  feat_checks_passed=$((feat_checks_passed + 1))
else
  print_warn "Utility functions verification failed"
fi

# Check for agent metadata
if grep -q "research-agent" "$CLAUDE_HOME/skillsets/planning-skillset/agents"/*.yaml 2>/dev/null; then
  print_pass "Agent definitions found"
  feat_checks_passed=$((feat_checks_passed + 1))
else
  print_warn "Agent definitions not found"
fi

# Check for guides
if grep -q "리서치 에이전트" "$CLAUDE_HOME/skillsets/planning-skillset/guides"/*.md 2>/dev/null; then
  print_pass "Guide content verified"
  feat_checks_passed=$((feat_checks_passed + 1))
else
  print_warn "Guide content verification failed"
fi

# Check hooks
if [ -f "$CLAUDE_HOME/hooks/skillset-auto-init.sh" ]; then
  print_pass "Auto-init hook installed"
  feat_checks_passed=$((feat_checks_passed + 1))
else
  print_warn "Auto-init hook not found"
fi

echo ""
verbose "Feature checks: $feat_checks_passed/$feat_checks_total passed"
echo ""

# ============================================================================
# Summary
# ============================================================================

print_header "Verification Summary"

TOTAL_CHECKS=$((checks_passed + meta_checks_passed + perm_checks_passed + feat_checks_passed))
TOTAL_POSSIBLE=15

echo "Results:"
echo "  Directory Checks: $checks_passed/4"
echo "  Metadata Checks: $meta_checks_passed/2"
echo "  Permission Checks: $perm_checks_passed/3"
echo "  Feature Checks: $feat_checks_passed/4"
echo ""
echo "  Total: $TOTAL_CHECKS/$TOTAL_POSSIBLE checks passed"
echo ""

if [ "$TOTAL_CHECKS" -ge 12 ]; then
  echo -e "${GREEN}✓ Installation verification PASSED${NC}"
  echo ""
  echo "Next steps:"
  echo "  1. Run: /skillset:init"
  echo "  2. View: /skillset:list"
  echo "  3. Start: /skillset:run research"
  exit 0
elif [ "$TOTAL_CHECKS" -ge 9 ]; then
  echo -e "${YELLOW}⚠ Installation verification PARTIAL${NC}"
  echo ""
  echo "Some components are missing or not properly configured."
  echo "Please run ./install.sh again or see INSTALLATION.md for help."
  exit 1
else
  echo -e "${RED}✗ Installation verification FAILED${NC}"
  echo ""
  echo "Critical components are missing."
  echo "Please reinstall using: ./install.sh"
  exit 1
fi
