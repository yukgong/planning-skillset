# 🏗️ Architecture Overview

High-level system architecture and design decisions for the Planning Skillset.

---

## System Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                     Claude Code Terminal                     │
│  (/skillset:init, /skillset:run, /skillset:list, etc.)      │
└─────────────────────────────────┬───────────────────────────┘
                                  │
                    ┌─────────────┴─────────────┐
                    ▼                           ▼
        ┌──────────────────────┐    ┌──────────────────────┐
        │  Command Handler     │    │  Hook System         │
        │ (commands/*.md)      │    │ (SessionStart)       │
        └──────────┬───────────┘    └──────────┬───────────┘
                   │                           │
                   └─────────────┬─────────────┘
                                 ▼
                    ┌──────────────────────────┐
                    │  Skillset Utils Library   │
                    │ (lib/skillset/*.sh)      │
                    └──────────┬───────────────┘
                               │
          ┌────────────────────┼────────────────────┐
          ▼                    ▼                    ▼
    ┌──────────────┐  ┌──────────────┐  ┌──────────────┐
    │ Agent Layer  │  │ Metadata     │  │ Output       │
    │ (agents/)    │  │ (progress    │  │ Management   │
    │              │  │  .json)      │  │ (output/)    │
    │ • 8 Agents   │  │              │  │              │
    │ • YAML       │  │ Global:      │  │ 8 Folders:   │
    │   Config     │  │ ~/.claude/   │  │ • research   │
    └──────────────┘  │              │  │ • analysis   │
                      │ Project:     │  │ • ...        │
                      │ ./.moai/     │  │              │
                      └──────────────┘  └──────────────┘
```

---

## Core Components

### 1. Command Interface Layer

**Files:** `commands/*.md`

Commands are the entry points for user interactions:
- **init.md** - Initialization command
- **run.md** - Agent execution command
- **list.md** - Progress display command
- **guide.md** - Guide display command

Each command:
- Handles user input
- Validates parameters
- Calls utility functions
- Returns formatted output

### 2. Utility Library

**File:** `lib/skillset/skillset-utils.sh`

Central library providing:
- Print functions (formatted output)
- Metadata management
- Directory operations
- Agent validation
- UI helpers
- File operations

### 3. Agent Definitions

**Files:** `agents/*-agent.yaml`

YAML-based agent metadata:
- Agent identity (ID, name, icon)
- Description and purpose
- Prerequisites
- Expected outputs
- Duration estimates

### 4. Guides

**Files:** `guides/*-guide.md`

Comprehensive step-by-step guides:
- Agent overview
- 8-step workflow
- Practical examples
- Templates
- FAQ

### 5. Metadata Management

**Locations:**
- Global: `~/.claude/skillsets/planning-skillset/`
- Project: `./.moai/config/sections/`

**Files:**
- `metadata.json` - Skillset info
- `progress.json` - Agent progress tracking

### 6. Output Management

**Structure:** `skillset-output/`

```
skillset-output/
├── research/           # Research agent outputs
├── analysis/           # Analysis agent outputs
├── ideation/           # Ideation agent outputs
├── structure/          # Structure agent outputs
├── validation/         # Validation agent outputs
├── user-centered/      # User-centered agent outputs
├── communication/      # Communication agent outputs
└── strategy/           # Strategy agent outputs
```

---

## Data Flow

### Initialization Flow

```
User runs /skillset:init
    ↓
Check if initialized
    ↓
Create directories (if needed)
    ↓
Initialize metadata.json
    ↓
Initialize progress.json
    ↓
Display summary
```

### Agent Execution Flow

```
User runs /skillset:run <agent>
    ↓
Validate agent exists
    ↓
Check prerequisites
    ↓
Load agent definition
    ↓
Display guide (if --guide)
    ↓
Execute agent workflow
    ↓
Update progress.json
    ↓
Save outputs
    ↓
Display completion summary
```

### Progress Tracking Flow

```
Agent action
    ↓
Update progress.json
    ↓
Log timestamps
    ↓
Count outputs
    ↓
Calculate completion status
    ↓
Display when /skillset:list called
```

---

## File Organization

### Root Level
- `install.sh` - Installation script
- `uninstall.sh` - Uninstall script
- `verify.sh` - Verification script
- `package.json` - NPM metadata
- `manifest.yaml` - Claude Code manifest
- `README.md` - Main documentation
- `LICENSE` - MIT License

### agents/ (8 files)
- YAML definitions for each agent
- Metadata and configuration

### guides/ (8 files)
- Markdown guides for each agent
- Comprehensive workflows

### commands/ (4 files)
- Claude Code command implementations
- User interaction handlers

### lib/skillset/ (2 files)
- `skillset-utils.sh` - Main utility library
- `skillset-auto-init.sh` - Auto-initialization hook

### docs/ (5 files)
- Architecture (this file)
- API reference
- Examples
- Troubleshooting
- Workflow

### .github/ (future)
- CI/CD workflows
- Release automation

---

## Key Design Decisions

### 1. Bash-based Implementation
**Why:** Maximum compatibility across platforms (macOS, Linux, WSL)

### 2. YAML for Agent Configuration
**Why:** Human-readable, widely supported, hierarchical structure

### 3. JSON for Progress Tracking
**Why:** Easy parsing, standard format, efficient updates

### 4. Modular Command Structure
**Why:** Easy to maintain, add, and modify individual commands

### 5. Centralized Utility Library
**Why:** Reduces duplication, ensures consistency, easier updates

### 6. Progressive Disclosure
**Why:** Gradual complexity revelation for better UX

### 7. Automatic Initialization Hook
**Why:** Seamless first-run experience for users

---

## Scalability Considerations

### Current Limitations
- Single project (future: multi-project support)
- 8 agents (extensible)
- 4 commands (easily added)
- CLI only (future: web UI)

### Growth Path
1. Web dashboard
2. Real-time updates
3. Multi-project support
4. Agent collaboration
5. API interface

---

## Security Considerations

### Input Validation
- Command parameters validated
- File paths sanitized
- User input checked

### File Permissions
- Proper directory permissions
- Readable/executable flags set
- Secure backup handling

### Metadata Protection
- JSON structure validated
- Corruption detection
- Automatic recovery

---

## Performance Characteristics

### Initialization
- Time: < 1 second
- Resources: Minimal disk/memory
- I/O operations: ~10 file creates

### Command Execution
- Response time: < 100ms
- Memory footprint: < 10MB
- Disk I/O: Minimal

### Scaling
- Handles 100+ project directories
- Supports rapid agent switching
- Efficient metadata updates

---

## Extension Points

### Adding a New Agent
1. Create `agents/new-agent.yaml`
2. Create `guides/new-guide.md`
3. Update `manifest.yaml`
4. Add prerequisites logic (optional)

### Adding a New Command
1. Create `commands/new-command.md`
2. Implement in command handler
3. Update manifest.yaml
4. Add to help documentation

### Custom Utilities
1. Add functions to `lib/skillset/skillset-utils.sh`
2. Export for use in commands
3. Document in API reference

---

## Dependencies

### External
- Bash 4.0+
- jq (optional, for JSON processing)
- Standard Unix tools (mkdir, cp, grep, etc.)

### Internal
- Claude Code v1.0.0+
- YAML parser (built into Claude Code)

### No External Dependencies
- No npm packages required
- No system services needed
- No external APIs called

---

## Future Architecture Enhancements

### v1.1+
- Database backend
- Real-time sync
- Web API
- Agent federation

### v2.0+
- Microservices architecture
- Cloud backend
- Mobile support
- Advanced analytics

---

## Troubleshooting Guide

See [TROUBLESHOOTING.md](TROUBLESHOOTING.md) for common issues.

---

**Last Updated:** 2026-01-21
