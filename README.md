# 🎯 Planning Skillset for Claude Code

**AI-Powered Web Application Planning System with 8 Specialized Agents**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Claude Code](https://img.shields.io/badge/Claude%20Code-Compatible-blue)](https://claude.com/claude-code)
[![Version](https://img.shields.io/badge/Version-1.0.0-green)](#)
[![Status](https://img.shields.io/badge/Status-Production-success)](#)

---

## 📋 Overview

**Planning Skillset** is a comprehensive AI-powered planning system integrated with Claude Code. It provides 8 specialized agents that guide you through the entire web application planning process—from initial research to strategic planning.

### 🎯 What You Can Do

- 🔍 **Research** - Conduct market research and data collection
- 📊 **Analyze** - Extract insights from collected data
- 💡 **Ideate** - Generate creative solutions based on insights
- 🏗️ **Structure** - Define product specifications and architecture
- ✔️ **Validate** - Perform comprehensive plan validation
- 👥 **User-Center** - Optimize user experience
- 📢 **Communicate** - Develop stakeholder communication strategies
- 🎯 **Strategize** - Create long-term business strategies

---

## 🚀 Quick Start

### 1️⃣ Installation

#### Option A: Bash Script (Recommended)
```bash
./install.sh
```

#### Option B: Manual Installation
See [INSTALLATION.md](INSTALLATION.md) for detailed instructions.

### 2️⃣ Initialize
```bash
/skillset:init
```

### 3️⃣ Run Your First Agent
```bash
/skillset:run research
```

### 4️⃣ View Progress
```bash
/skillset:list --status
```

---

## 📚 Core Agents

| Agent | Icon | Purpose | Duration | Difficulty |
|-------|------|---------|----------|------------|
| Research | 🔍 | Market information collection | 6-8h | Medium |
| Analysis | 📊 | Data analysis and insights | 5-7h | Medium |
| Ideation | 💡 | Creative idea generation | 6-8h | Medium |
| Structure | 🏗️ | Product definition | 7-9h | High |
| Validation | ✔️ | Comprehensive verification | 4-6h | Medium |
| User-Centered | 👥 | UX optimization | 6-8h | Medium |
| Communication | 📢 | Stakeholder messaging | 5-7h | Medium |
| Strategy | 🎯 | Business strategy | 5-7h | High |

---

## 📋 Commands Reference

### `/skillset:init` - Initialize
Setup the skillset on first run.
```bash
/skillset:init              # Standard initialization
/skillset:init --reset      # Reset metadata
/skillset:init --verbose    # Show detailed logs
```

### `/skillset:run` - Execute Agent
Run a specific planning agent.
```bash
/skillset:run research              # Run research agent
/skillset:run analysis --guide      # Run with guide display
/skillset:run --continue            # Continue from last agent
```

### `/skillset:list` - View Progress
Display agents and current progress.
```bash
/skillset:list              # Show all agents
/skillset:list --status     # Progress summary
/skillset:list --details    # Detailed information
/skillset:list --json       # JSON output
```

### `/skillset:guide` - View Guides
Display agent-specific guides.
```bash
/skillset:guide research          # Full guide
/skillset:guide research --short  # Quick summary
/skillset:guide research --full   # Complete guide
/skillset:guide research --print  # Print-optimized
```

---

## 📁 Project Structure

```
planning-skillset/
├── agents/                    # 8 agent YAML definitions
│   ├── research-agent.yaml
│   ├── analysis-agent.yaml
│   └── ...
├── guides/                    # Agent guides and documentation
│   ├── research-guide.md
│   ├── analysis-guide.md
│   └── ...
├── commands/                  # Claude Code commands
│   ├── init.md
│   ├── run.md
│   ├── list.md
│   └── guide.md
├── lib/skillset/              # Utility scripts
│   ├── skillset-utils.sh
│   └── skillset-auto-init.sh
├── docs/                      # Additional documentation
│   ├── ARCHITECTURE.md
│   ├── API.md
│   ├── EXAMPLES.md
│   └── TROUBLESHOOTING.md
├── tests/                     # Test scripts
├── install.sh                 # Installation script
├── uninstall.sh               # Uninstall script
├── verify.sh                  # Verification script
├── manifest.yaml              # Claude Code manifest
├── package.json               # Package metadata
├── README.md                  # This file
├── INSTALLATION.md            # Installation guide
├── CONTRIBUTING.md            # Contributing guide
├── CHANGELOG.md               # Version history
└── LICENSE                    # MIT License
```

---

## 💡 Usage Scenarios

### Scenario 1: Complete Planning Workflow
```bash
# Initialize
/skillset:init

# Run agents in sequence
/skillset:run research
/skillset:run analysis
/skillset:run ideation
/skillset:run structure
/skillset:run validation
/skillset:run user-centered
/skillset:run communication
/skillset:run strategy

# View final progress
/skillset:list --status
```

### Scenario 2: Repeat Specific Agents
```bash
# Already completed research and analysis
# Need to redo ideation
/skillset:run ideation --guide
```

### Scenario 3: Get Help
```bash
# View quick guide before starting
/skillset:guide research --short

# View complete guide
/skillset:guide research --full

# Save guide for later
/skillset:guide research --full --print > research-guide.txt
```

---

## 📊 Key Features

✅ **8 Specialized Agents** - Each focusing on different planning aspects
✅ **Progressive Disclosure** - Step-by-step information revelation
✅ **Real-time Tracking** - Monitor progress across all agents
✅ **Automatic Initialization** - First-run setup handled automatically
✅ **Cross-Platform** - Works on macOS, Linux, Windows WSL
✅ **Comprehensive Guides** - Detailed documentation for each agent
✅ **Error Recovery** - Built-in error handling and recovery
✅ **Metadata Management** - JSON-based progress tracking

---

## 🔧 Requirements

- **Claude Code** v1.0.0+
- **Bash** 4.0+
- **jq** (optional, for JSON processing)
- **macOS**, **Linux**, or **Windows WSL**

---

## 📖 Documentation

- [Installation Guide](INSTALLATION.md) - Setup instructions
- [Architecture](docs/ARCHITECTURE.md) - System design overview
- [API Reference](docs/API.md) - Command and utility documentation
- [Examples](docs/EXAMPLES.md) - Real-world usage examples
- [Troubleshooting](docs/TROUBLESHOOTING.md) - Common issues and solutions
- [Contributing](CONTRIBUTING.md) - How to contribute
- [Changelog](CHANGELOG.md) - Version history

---

## 🎓 Workflow

```
START
  ↓
[Step 1] /skillset:init (Initialize)
  ↓
[Step 2] /skillset:run research (Research)
  ↓
[Step 3] /skillset:run analysis (Analysis)
  ↓
[Step 4] /skillset:run ideation (Ideation)
  ↓
[Step 5] /skillset:run structure (Structure)
  ↓
┌─────────────────┬─────────────────┐
│                 │                 │
[Step 6]      [Step 6]          [Step 6]
Validation    User-Centered      (Choose one or both)
│               │
├───────────┬───┘
│           │
[Step 7] Communication
│
[Step 8] Strategy
│
END
```

---

## 🛠️ Installation Methods

### Method 1: Automatic (Recommended)
```bash
./install.sh
```

### Method 2: Using npm
```bash
npm install -g planning-skillset
```

### Method 3: Manual Installation
See [INSTALLATION.md](INSTALLATION.md) for step-by-step instructions.

---

## ✅ Verification

After installation, verify everything works:

```bash
./verify.sh
```

This will check:
- ✓ Claude Code compatibility
- ✓ Skillset files in correct locations
- ✓ Commands registered properly
- ✓ Metadata initialized
- ✓ All agents accessible

---

## 🤝 Contributing

We welcome contributions! See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on:
- Reporting bugs
- Requesting features
- Submitting pull requests
- Code standards

---

## 📝 License

This project is licensed under the MIT License - see [LICENSE](LICENSE) file for details.

---

## 🔗 Links

- **Repository**: https://github.com/anthropics/planning-skillset
- **Issues**: https://github.com/anthropics/planning-skillset/issues
- **Discussions**: https://github.com/anthropics/planning-skillset/discussions
- **Claude Code**: https://claude.com/claude-code

---

## 📞 Support

### Documentation
- 📖 [Full Documentation](docs/)
- 🎓 [Agent Guides](guides/)
- 💡 [Examples](docs/EXAMPLES.md)

### Getting Help
- 🐛 [Report Issues](https://github.com/anthropics/planning-skillset/issues)
- 💬 [Discussions](https://github.com/anthropics/planning-skillset/discussions)
- 📧 support@planning-skillset.com

### Troubleshooting
- 🔧 [Troubleshooting Guide](docs/TROUBLESHOOTING.md)
- ❓ [FAQ](docs/TROUBLESHOOTING.md#faq)

---

## 🎉 Getting Started

Ready to start planning? Follow these steps:

1. **Install** - Run `./install.sh`
2. **Initialize** - Run `/skillset:init`
3. **Start** - Run `/skillset:run research`
4. **Learn** - Run `/skillset:guide research --short`
5. **Progress** - Run `/skillset:list --status`

Good luck! 🚀

---

**Last Updated**: 2026-01-21 | **Version**: 1.0.0
