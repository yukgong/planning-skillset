# 📚 API Reference

Complete command and utility function reference for the Planning Skillset.

---

## Commands API

### /skillset:init

Initialize the Planning Skillset.

#### Usage
```bash
/skillset:init              # Standard initialization
/skillset:init --reset      # Reset all metadata
/skillset:init --verbose    # Show detailed logs
```

#### Parameters
- `--reset` - Reset metadata to initial state
- `--verbose` - Show detailed initialization logs

#### Output
- Creates 8 output directories
- Initializes metadata.json
- Initializes progress.json
- Displays initialization summary

#### Example
```bash
$ /skillset:init
✓ Directories created
✓ Metadata initialized
✓ Skills loaded (8/8)
```

---

### /skillset:run

Execute a planning agent.

#### Usage
```bash
/skillset:run                   # Interactive selection menu
/skillset:run research          # Run research agent
/skillset:run analysis --guide  # Run with guide display
/skillset:run --continue        # Continue from last agent
```

#### Parameters
- `--guide` - Display guide while running
- `--continue` - Continue from last executed agent
- Agent name (optional): research, analysis, ideation, structure, validation, user-centered, communication, strategy

#### Output
- Displays agent information
- Shows step-by-step workflow
- Updates progress.json
- Saves outputs to skillset-output/

#### Example
```bash
$ /skillset:run research
🔍 Research Agent
Starting workflow...
Step 1: Define research scope
...
```

---

### /skillset:list

Display agents and progress tracking.

#### Usage
```bash
/skillset:list              # Show all agents
/skillset:list --status     # Progress summary with bar
/skillset:list --details    # Detailed information per agent
/skillset:list --json       # JSON output for parsing
```

#### Parameters
- `--status` - Show progress summary with completion bar
- `--details` - Show detailed information for each agent
- `--json` - Output in JSON format

#### Output
- Agent list with status
- Progress indicators
- Completion percentages
- Output file counts

#### Example
```bash
$ /skillset:list --status
🎯 Planning Skillset Progress
[████████░░░░░░░░░░░] 40% (4/10)

[✅] Research Agent (2 outputs)
[✅] Analysis Agent (1 output)
[🔲] Ideation Agent
...
```

---

### /skillset:guide

Display agent-specific guides.

#### Usage
```bash
/skillset:guide research          # Display guide (paginated)
/skillset:guide research --short  # Quick summary
/skillset:guide research --full   # Complete guide
/skillset:guide research --print  # Print-optimized format
```

#### Parameters
- `--short` - Summary version (1-2 minutes read)
- `--full` - Complete guide (20-30 minutes read)
- `--print` - Optimized for printing/saving
- Agent name (required): research, analysis, ideation, structure, validation, user-centered, communication, strategy

#### Output
- Agent overview
- 8-step workflow
- Practical examples
- Templates
- FAQ

#### Example
```bash
$ /skillset:guide research --short
🔍 Research Agent - Quick Overview

Purpose: Market research and data collection
Duration: 6-8 hours
Difficulty: Medium

8 Core Steps:
  1️⃣ Define research scope
  2️⃣ Market size analysis
  ...
```

---

## Utility Functions API

Functions available in `lib/skillset/skillset-utils.sh`:

### Output Functions

#### `print_header [text]`
Print formatted header.
```bash
print_header "Installation Started"
# Output: ╔════════════╗ ...
```

#### `print_success [message]`
Print success message.
```bash
print_success "Installation complete"
# Output: ✓ Installation complete (in green)
```

#### `print_error [message]`
Print error message.
```bash
print_error "File not found"
# Output: ✗ File not found (in red)
```

#### `print_warning [message]`
Print warning message.
```bash
print_warning "Check permissions"
# Output: ⚠ Check permissions (in yellow)
```

#### `print_info [message]`
Print info message.
```bash
print_info "Processing..."
# Output: ℹ Processing... (in cyan)
```

### Metadata Functions

#### `init_metadata`
Initialize metadata files.
```bash
init_metadata
# Creates: metadata.json, progress.json
```

#### `scan_progress`
Scan and count completed agents.
```bash
completed=$(scan_progress)
# Returns: "2/8" (completed/total)
```

### Directory Functions

#### `init_output_directories`
Create all output directories.
```bash
init_output_directories
# Creates: skillset-output/{research,analysis,...}
```

#### `check_output_directories`
Verify output directories exist.
```bash
if check_output_directories; then
  print_success "Directories verified"
fi
```

### Agent Functions

#### `is_valid_agent [agent_id]`
Check if agent ID is valid.
```bash
if is_valid_agent "research-agent"; then
  echo "Valid agent"
fi
```

#### `get_agent_id [short_name]`
Get full agent ID from short name.
```bash
agent_id=$(get_agent_id "research")
# Returns: "research-agent"
```

#### `check_prerequisites [agent_id]`
Check if agent prerequisites are met.
```bash
if check_prerequisites "analysis-agent"; then
  /skillset:run analysis
fi
```

### UI Functions

#### `display_agent_list [show_status]`
Display list of all agents.
```bash
display_agent_list true   # With status indicators
display_agent_list false  # Without status
```

#### `display_progress_bar [completed] [total]`
Display progress bar.
```bash
display_progress_bar 3 8
# Output: [███░░░░░░] 37% (3/8)
```

### File Functions

#### `read_guide_short [agent_id]`
Read first 50 lines of guide.
```bash
read_guide_short "research-agent"
```

#### `read_guide_full [agent_id]`
Read complete guide.
```bash
read_guide_full "research-agent"
```

### Status Functions

#### `is_initialized`
Check if skillset is initialized.
```bash
if ! is_initialized; then
  /skillset:init
fi
```

#### `is_valid_project`
Check if project has output directory.
```bash
if is_valid_project; then
  echo "Project setup complete"
fi
```

---

## JSON Schema

### metadata.json
```json
{
  "skillset_id": "planning-skillset",
  "version": "1.0.0",
  "initialized_at": "2026-01-21T00:00:00Z",
  "auto_initialized": true,
  "environment": "claude-code"
}
```

### progress.json
```json
{
  "agents": {
    "research-agent": {
      "status": "pending|in_progress|completed",
      "started_at": "ISO8601 timestamp or null",
      "completed_at": "ISO8601 timestamp or null",
      "outputs": 0
    },
    ...
  },
  "last_updated": "ISO8601 timestamp"
}
```

---

## Error Codes

### Installation Errors
- `1` - Unsupported OS
- `2` - Claude Code not found
- `3` - Permission denied
- `4` - Directory creation failed

### Command Errors
- `10` - Invalid agent ID
- `11` - Prerequisites not met
- `12` - Guide not found
- `13` - Output directory not writable

### Metadata Errors
- `20` - Metadata file corrupted
- `21` - Progress file not found
- `22` - Invalid JSON format

---

## Environment Variables

```bash
# Verbose logging
export VERBOSE=true

# Custom Claude Code path
export CLAUDE_HOME="/custom/path"

# Custom output directory
export SKILLSET_OUTPUT_DIR="/custom/output"

# Installation options
export BACKUP=true          # Create backup
export FORCE=true           # Force installation
```

---

## Advanced Usage

### Programmatic API (for scripts)

```bash
#!/bin/bash

# Source utilities
source ~/.claude/lib/skillset/skillset-utils.sh

# Run functions
print_header "My Custom Script"
init_metadata
display_agent_list true

# Process agents
for agent in research-agent analysis-agent; do
  if is_valid_agent "$agent"; then
    print_info "Processing $agent..."
  fi
done
```

### Batch Operations

```bash
#!/bin/bash

# Initialize all outputs
for dir in skillset-output/{research,analysis,ideation,structure,validation,user-centered,communication,strategy}; do
  mkdir -p "$dir"
done

# Update progress
for i in {1..8}; do
  jq ".agents[\"agent-$i\"].outputs += 1" progress.json > temp.json
  mv temp.json progress.json
done
```

---

## Rate Limiting

No rate limiting. All operations are local and unlimited.

---

## Versioning

API versioning follows semantic versioning:
- **v1.0.0+**: Initial stable release

Breaking changes will bump major version.

---

**Last Updated:** 2026-01-21
