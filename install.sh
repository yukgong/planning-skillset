#!/bin/bash

# ============================================================================
# Planning Skillset Installation Script
# ============================================================================
# Version: 1.0.0
# Purpose: Install Planning Skillset for Claude Code
# Platforms: macOS, Linux, Windows WSL
# ============================================================================

set -e  # Exit on error

# Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'  # No Color

# ============================================================================
# Configuration
# ============================================================================

SKILLSET_NAME="planning-skillset"
SKILLSET_VERSION="1.0.0"
VERBOSE="${VERBOSE:-false}"
BACKUP="${BACKUP:-true}"
FORCE="${FORCE:-false}"

# Current directory (where script is located)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

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

verbose_log() {
  if [ "$VERBOSE" = "true" ]; then
    echo -e "${CYAN}[DEBUG] $1${NC}"
  fi
}

# Detect OS
detect_os() {
  case "$(uname -s)" in
    Darwin*)
      echo "macos"
      ;;
    Linux*)
      if grep -qi microsoft /proc/version 2>/dev/null; then
        echo "wsl"
      else
        echo "linux"
      fi
      ;;
    MINGW*|MSYS*)
      echo "windows"
      ;;
    *)
      echo "unknown"
      ;;
  esac
}

# Find Claude Code installation path
find_claude_home() {
  local os="$1"
  
  case "$os" in
    macos)
      if [ -d "$HOME/.claude" ]; then
        echo "$HOME/.claude"
      elif [ -d "$HOME/Library/Application Support/Claude Code" ]; then
        echo "$HOME/Library/Application Support/Claude Code"
      fi
      ;;
    linux|wsl)
      if [ -d "$HOME/.claude" ]; then
        echo "$HOME/.claude"
      elif [ -d "$HOME/.config/claude-code" ]; then
        echo "$HOME/.config/claude-code"
      fi
      ;;
    windows)
      if [ -d "$APPDATA/.claude" ]; then
        echo "$APPDATA/.claude"
      fi
      ;;
  esac
}

# Create backup
create_backup() {
  local claude_home="$1"
  local backup_dir="${SCRIPT_DIR}/.skillset-backup-$(date +%Y%m%d-%H%M%S)"
  
  if [ -d "$claude_home/skillsets" ] || [ -d "$claude_home/commands/skillset" ]; then
    print_info "Creating backup..."
    mkdir -p "$backup_dir"
    
    if [ -d "$claude_home/skillsets" ]; then
      cp -r "$claude_home/skillsets" "$backup_dir/" 2>/dev/null || true
    fi
    if [ -d "$claude_home/commands/skillset" ]; then
      cp -r "$claude_home/commands/skillset" "$backup_dir/" 2>/dev/null || true
    fi
    
    print_success "Backup created: $backup_dir"
    echo "$backup_dir"
  fi
}

# ============================================================================
# Main Installation
# ============================================================================

print_header "🎯 Planning Skillset Installer v${SKILLSET_VERSION}"

echo "Installation Options:"
echo "  OS Detection: $(detect_os)"
echo "  Verbose Mode: $VERBOSE"
echo "  Backup Before: $BACKUP"
echo ""

# Step 1: Detect OS
OS=$(detect_os)
if [ "$OS" = "unknown" ]; then
  print_error "Unsupported operating system"
  exit 1
fi
print_success "Operating System: $OS"

# Step 2: Find Claude Code
CLAUDE_HOME=$(find_claude_home "$OS")
if [ -z "$CLAUDE_HOME" ]; then
  print_error "Claude Code not found. Please install Claude Code first."
  exit 1
fi
print_success "Claude Code found: $CLAUDE_HOME"

# Step 3: Create backup if requested
BACKUP_DIR=""
if [ "$BACKUP" = "true" ]; then
  BACKUP_DIR=$(create_backup "$CLAUDE_HOME")
fi

# Step 4: Create directories
print_info "Creating directories..."
mkdir -p "$CLAUDE_HOME/skillsets/$SKILLSET_NAME"
mkdir -p "$CLAUDE_HOME/skillsets/$SKILLSET_NAME/agents"
mkdir -p "$CLAUDE_HOME/skillsets/$SKILLSET_NAME/guides"
mkdir -p "$CLAUDE_HOME/commands/skillset"
mkdir -p "$CLAUDE_HOME/lib/skillset"
mkdir -p "$CLAUDE_HOME/hooks"
print_success "Directories created"

# Step 5: Copy files
print_info "Installing files..."

# Copy agents
if [ -d "$SCRIPT_DIR/agents" ]; then
  cp "$SCRIPT_DIR/agents"/* "$CLAUDE_HOME/skillsets/$SKILLSET_NAME/agents/" 2>/dev/null || true
  print_success "Agents installed ($(ls "$CLAUDE_HOME/skillsets/$SKILLSET_NAME/agents" | wc -l) files)"
fi

# Copy guides
if [ -d "$SCRIPT_DIR/guides" ]; then
  mkdir -p "$CLAUDE_HOME/skillsets/$SKILLSET_NAME/guides"
  cp "$SCRIPT_DIR/guides"/* "$CLAUDE_HOME/skillsets/$SKILLSET_NAME/guides/" 2>/dev/null || true
  print_success "Guides installed ($(ls "$CLAUDE_HOME/skillsets/$SKILLSET_NAME/guides" 2>/dev/null | wc -l) files)"
fi

# Copy commands
if [ -d "$SCRIPT_DIR/commands" ]; then
  cp "$SCRIPT_DIR/commands"/* "$CLAUDE_HOME/commands/skillset/" 2>/dev/null || true
  print_success "Commands installed ($(ls "$CLAUDE_HOME/commands/skillset" | wc -l) files)"
fi

# Copy lib files
if [ -d "$SCRIPT_DIR/lib/skillset" ]; then
  cp "$SCRIPT_DIR/lib/skillset"/* "$CLAUDE_HOME/lib/skillset/" 2>/dev/null || true
  print_success "Utilities installed ($(ls "$CLAUDE_HOME/lib/skillset" | wc -l) files)"
fi

# Copy hooks
if [ -f "$SCRIPT_DIR/lib/skillset/skillset-auto-init.sh" ]; then
  cp "$SCRIPT_DIR/lib/skillset/skillset-auto-init.sh" "$CLAUDE_HOME/hooks/" 2>/dev/null || true
  print_success "Hooks installed"
fi

# Step 6: Set permissions
print_info "Setting permissions..."
chmod +x "$CLAUDE_HOME/commands/skillset"/*.md 2>/dev/null || true
chmod +x "$CLAUDE_HOME/lib/skillset"/*.sh 2>/dev/null || true
chmod +x "$CLAUDE_HOME/hooks"/*.sh 2>/dev/null || true
print_success "Permissions set"

# Step 7: Create output directory
print_info "Creating output directory..."
mkdir -p "${SCRIPT_DIR}/skillset-output"/{research,analysis,ideation,structure,validation,user-centered,communication,strategy}
print_success "Output directories created"

# Step 8: Initialize metadata
print_info "Initializing metadata..."
CLAUDE_SKILLSETS="$HOME/.claude/skillsets/planning-skillset"
mkdir -p "$CLAUDE_SKILLSETS"

# Create metadata.json
cat > "$CLAUDE_SKILLSETS/metadata.json" << 'METADATA'
{
  "skillset_id": "planning-skillset",
  "version": "1.0.0",
  "initialized_at": "2026-01-21T00:00:00Z",
  "auto_initialized": true,
  "environment": "claude-code"
}
METADATA

# Create progress.json
cat > "$CLAUDE_SKILLSETS/progress.json" << 'PROGRESS'
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
PROGRESS

print_success "Metadata initialized"

# Step 9: Verify installation
print_header "Verifying Installation"

verify_count=0
verify_total=0

# Check agents
verify_total=$((verify_total + 1))
if [ -d "$CLAUDE_HOME/skillsets/$SKILLSET_NAME/agents" ] && [ "$(ls "$CLAUDE_HOME/skillsets/$SKILLSET_NAME/agents" | wc -l)" -ge 8 ]; then
  print_success "Agents directory: $(ls "$CLAUDE_HOME/skillsets/$SKILLSET_NAME/agents" | wc -l) files"
  verify_count=$((verify_count + 1))
else
  print_warning "Agents directory not fully populated"
fi

# Check commands
verify_total=$((verify_total + 1))
if [ "$(ls "$CLAUDE_HOME/commands/skillset" | wc -l)" -ge 4 ]; then
  print_success "Commands installed: $(ls "$CLAUDE_HOME/commands/skillset" | wc -l) files"
  verify_count=$((verify_count + 1))
else
  print_warning "Commands not fully populated"
fi

# Check lib
verify_total=$((verify_total + 1))
if [ "$(ls "$CLAUDE_HOME/lib/skillset" | wc -l)" -ge 1 ]; then
  print_success "Utilities installed: $(ls "$CLAUDE_HOME/lib/skillset" | wc -l) files"
  verify_count=$((verify_count + 1))
else
  print_warning "Utilities not found"
fi

# Check output directory
verify_total=$((verify_total + 1))
if [ -d "${SCRIPT_DIR}/skillset-output" ]; then
  print_success "Output directory created"
  verify_count=$((verify_count + 1))
else
  print_warning "Output directory not found"
fi

# Final summary
echo ""
print_header "Installation Complete! ✅"

echo "Verification: $verify_count/$verify_total checks passed"
echo ""

if [ "$verify_count" -eq "$verify_total" ]; then
  echo -e "${GREEN}Installation was successful!${NC}"
  echo ""
  echo "🚀 Next steps:"
  echo "  1. Initialize: /skillset:init"
  echo "  2. View agents: /skillset:list"
  echo "  3. Start planning: /skillset:run research"
  echo "  4. Get help: /skillset:guide research --short"
  echo ""
  echo "📖 Documentation: See README.md and INSTALLATION.md"
else
  echo -e "${YELLOW}Installation completed with some warnings.${NC}"
  if [ -n "$BACKUP_DIR" ]; then
    echo "Backup location: $BACKUP_DIR"
  fi
fi

echo ""
echo "Installation Details:"
echo "  Claude Home: $CLAUDE_HOME"
echo "  Skillset Path: $CLAUDE_HOME/skillsets/$SKILLSET_NAME"
echo "  Output Path: ${SCRIPT_DIR}/skillset-output"
echo ""

# ============================================================================
# End
# ============================================================================

exit 0
