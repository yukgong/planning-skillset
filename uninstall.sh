#!/bin/bash

# ============================================================================
# Planning Skillset Uninstallation Script
# ============================================================================
# Version: 1.0.0
# Purpose: Uninstall Planning Skillset from Claude Code
# ============================================================================

set -e

# Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# ============================================================================
# Functions
# ============================================================================

print_header() {
  echo -e "\n${BLUE}╔════════════════════════════════════════════════════════════════╗${NC}"
  printf "${BLUE}║  %-60s  ║${NC}\n" "$1"
  echo -e "${BLUE}╚════════════════════════════════════════════════════════════════╝${NC}\n"
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

confirm() {
  local prompt="$1"
  local response
  
  read -p "$(echo -e ${YELLOW})$prompt (y/N): $(echo -e ${NC})" response
  
  if [[ "$response" =~ ^[Yy]$ ]]; then
    return 0
  else
    return 1
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
# Main Uninstallation
# ============================================================================

print_header "🎯 Planning Skillset Uninstaller"

# Find Claude Code
CLAUDE_HOME=$(find_claude_home)
if [ -z "$CLAUDE_HOME" ]; then
  print_error "Claude Code not found"
  exit 1
fi

print_info "Claude Code location: $CLAUDE_HOME"
echo ""

# Check if skillset is installed
if [ ! -d "$CLAUDE_HOME/skillsets/planning-skillset" ] && [ ! -d "$CLAUDE_HOME/commands/skillset" ]; then
  print_warning "Planning Skillset does not appear to be installed"
  exit 0
fi

print_warning "This will remove the Planning Skillset installation"
echo ""
echo "The following will be removed:"
echo "  • Skillset files: $CLAUDE_HOME/skillsets/planning-skillset/"
echo "  • Commands: $CLAUDE_HOME/commands/skillset/"
echo "  • Utilities: $CLAUDE_HOME/lib/skillset/"
echo "  • Hooks: $CLAUDE_HOME/hooks/skillset-auto-init.sh"
echo ""
echo "Local output files (skillset-output/) will NOT be deleted"
echo ""

# Confirm
if ! confirm "Proceed with uninstallation?"; then
  print_info "Uninstallation cancelled"
  exit 0
fi

echo ""
print_info "Uninstalling..."
echo ""

# Remove directories
if [ -d "$CLAUDE_HOME/skillsets/planning-skillset" ]; then
  rm -rf "$CLAUDE_HOME/skillsets/planning-skillset"
  print_success "Removed: $CLAUDE_HOME/skillsets/planning-skillset/"
fi

if [ -d "$CLAUDE_HOME/commands/skillset" ]; then
  rm -rf "$CLAUDE_HOME/commands/skillset"
  print_success "Removed: $CLAUDE_HOME/commands/skillset/"
fi

if [ -d "$CLAUDE_HOME/lib/skillset" ]; then
  rm -rf "$CLAUDE_HOME/lib/skillset"
  print_success "Removed: $CLAUDE_HOME/lib/skillset/"
fi

# Remove hooks
if [ -f "$CLAUDE_HOME/hooks/skillset-auto-init.sh" ]; then
  rm -f "$CLAUDE_HOME/hooks/skillset-auto-init.sh"
  print_success "Removed: $CLAUDE_HOME/hooks/skillset-auto-init.sh"
fi

# Remove global metadata
if [ -d "$HOME/.claude/skillsets/planning-skillset" ]; then
  rm -rf "$HOME/.claude/skillsets/planning-skillset"
  print_success "Removed: $HOME/.claude/skillsets/planning-skillset/"
fi

echo ""
print_header "Uninstallation Complete! ✅"

echo "The Planning Skillset has been successfully uninstalled."
echo ""
echo "To reinstall later, run:"
echo "  ./install.sh"
echo ""

exit 0
