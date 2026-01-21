# 📦 Installation Guide

Complete guide for installing the Planning Skillset on your system.

---

## ⚙️ Requirements

Before installing, ensure you have:

- **Claude Code** v1.0.0 or higher
- **Bash** 4.0 or higher
- **macOS 10.15+**, **Linux (Ubuntu 18.04+)**, or **Windows WSL2**
- **jq** (optional, for JSON processing)
- **Git** (optional, for development)

### Check Your System

```bash
# Check Bash version
bash --version

# Check Claude Code
which claude

# Verify jq (optional)
which jq
```

---

## 🚀 Installation Methods

### Method 1: Automatic Installation (Recommended)

The fastest way to get started:

```bash
# Download and run installer
./install.sh
```

**What it does:**
1. Detects your system (macOS/Linux/WSL)
2. Verifies Claude Code installation
3. Creates necessary directories
4. Copies skillset files
5. Registers commands and agents
6. Verifies installation

**Interactive prompts:**
- Confirms installation location
- Asks for backup preference
- Shows progress and results

---

### Method 2: npm Installation

If you prefer npm:

```bash
# Install globally
npm install -g planning-skillset

# Or install locally
npm install planning-skillset
```

Then initialize:
```bash
/skillset:init
```

---

### Method 3: Manual Installation

For advanced users or troubleshooting:

#### Step 1: Determine Claude Code Path
```bash
# Find Claude Code installation
which claude

# Typical paths:
# macOS: /Users/<username>/.claude/
# Linux: /home/<username>/.claude/
# WSL: /mnt/c/Users/<username>/AppData/Roaming/.claude/
```

#### Step 2: Copy Skillset Files

```bash
# Set your Claude Code path
CLAUDE_HOME="$HOME/.claude"

# Copy agents
mkdir -p "$CLAUDE_HOME/skillsets/planning-skillset/agents"
cp agents/* "$CLAUDE_HOME/skillsets/planning-skillset/agents/"

# Copy guides
mkdir -p "$CLAUDE_HOME/skillsets/planning-skillset/guides"
cp guides/* "$CLAUDE_HOME/skillsets/planning-skillset/guides/"

# Copy commands
mkdir -p "$CLAUDE_HOME/commands/skillset"
cp commands/* "$CLAUDE_HOME/commands/skillset/"

# Copy utilities
mkdir -p "$CLAUDE_HOME/lib/skillset"
cp lib/skillset/* "$CLAUDE_HOME/lib/skillset/"

# Copy hooks
cp lib/skillset/skillset-auto-init.sh "$CLAUDE_HOME/hooks/"
```

#### Step 3: Create Output Directory

```bash
# In your project directory
mkdir -p skillset-output/{research,analysis,ideation,structure,validation,user-centered,communication,strategy}
```

#### Step 4: Initialize Metadata

```bash
# Initialize skillset
/skillset:init
```

---

## 🔍 Verification

### Quick Verification
```bash
# Run verification script
./verify.sh
```

### Manual Verification

```bash
# Check if skillset is initialized
ls -la ~/.claude/skillsets/planning-skillset/

# Check if commands are registered
ls -la ~/.claude/commands/skillset/

# Test first command
/skillset:list
```

### Expected Output
```
✓ Claude Code installation verified
✓ Skillset files located
✓ Commands registered
✓ Agents loaded (8/8)
✓ Output directories ready
✓ Installation verified successfully
```

---

## 💾 Installation Locations

### macOS
```
~/.claude/skillsets/planning-skillset/          # Skillset files
~/.claude/commands/skillset/                    # Commands
~/.claude/lib/skillset/                         # Utilities
~/.claude/hooks/                                # Hooks
~/Desktop/code/skillSet_build/skillset-output/  # Project outputs
```

### Linux
```
~/.claude/skillsets/planning-skillset/          # Skillset files
~/.claude/commands/skillset/                    # Commands
~/.claude/lib/skillset/                         # Utilities
~/.claude/hooks/                                # Hooks
~/planning-skillset/skillset-output/            # Project outputs
```

### Windows WSL
```
/home/<username>/.claude/skillsets/planning-skillset/
/home/<username>/.claude/commands/skillset/
/home/<username>/.claude/lib/skillset/
/mnt/c/Users/<username>/AppData/Roaming/.claude/
```

---

## 🆘 Troubleshooting

### Issue: Installation script not found
**Solution:**
```bash
# Make script executable
chmod +x install.sh

# Run again
./install.sh
```

### Issue: "Command not found: claude"
**Solution:**
```bash
# Claude Code not installed
# Install from https://claude.com/claude-code

# Or verify installation
which claude
```

### Issue: Permission denied
**Solution:**
```bash
# Make scripts executable
chmod +x install.sh uninstall.sh verify.sh

# Run with sudo if needed (not recommended)
# sudo ./install.sh
```

### Issue: Skillset commands not recognized
**Solution:**
```bash
# Reinitialize skillset
/skillset:init --reset

# Verify installation
./verify.sh
```

### Issue: Output directories not created
**Solution:**
```bash
# Manually create them
mkdir -p skillset-output/{research,analysis,ideation,structure,validation,user-centered,communication,strategy}

# Verify permissions
chmod -R 755 skillset-output/
```

---

## 🔄 Uninstallation

To completely remove the skillset:

```bash
# Automatic uninstall
./uninstall.sh

# Or manual removal
rm -rf ~/.claude/skillsets/planning-skillset/
rm -rf ~/.claude/commands/skillset/
rm -rf ~/.claude/lib/skillset/
```

---

## 🔐 Backup Before Installation

The installer automatically backs up existing files. To manually backup:

```bash
# Create backup
cp -r ~/.claude/skillsets ~/.claude/skillsets.backup
cp -r ~/.claude/commands ~/.claude/commands.backup

# Restore if needed
rm -rf ~/.claude/skillsets
cp -r ~/.claude/skillsets.backup ~/.claude/skillsets
```

---

## 🎯 First Time Setup

After successful installation:

### 1. Initialize Skillset
```bash
/skillset:init
```

### 2. View Available Agents
```bash
/skillset:list
```

### 3. Read Quick Guide
```bash
/skillset:guide research --short
```

### 4. Start First Agent
```bash
/skillset:run research
```

---

## 🌍 Platform-Specific Notes

### macOS
- Installation path: `~/.claude/`
- Automatic backup enabled
- Supports both Intel and Apple Silicon
- May require command line tools: `xcode-select --install`

### Linux (Ubuntu/Debian)
- Installation path: `~/.claude/`
- Requires bash 4.0+
- jq recommended: `sudo apt-get install jq`
- Tested on Ubuntu 18.04, 20.04, 22.04

### Linux (RHEL/CentOS)
- Installation path: `~/.claude/`
- Install bash: `sudo yum install bash`
- Install jq: `sudo yum install jq`

### Windows WSL2
- Installation path: `/home/<username>/.claude/`
- Requires WSL2 and Ubuntu 18.04+
- Performance best on WSL2 (not WSL1)
- Path conversion: `/mnt/c/` for C: drive access

---

## 📊 Installation Verification

### Check File Structure
```bash
# Show installation structure
tree ~/.claude/skillsets/planning-skillset/
tree ~/.claude/commands/skillset/

# Or with find
find ~/.claude -name "skillset*" -o -name "planning-skillset"
```

### Check File Permissions
```bash
# Should be readable and executable
ls -la ~/.claude/commands/skillset/
ls -la ~/.claude/lib/skillset/
```

### Run All Commands
```bash
# Test each command
/skillset:init
/skillset:list
/skillset:list --json
/skillset:guide research --short
```

---

## 🔗 Next Steps

After installation:

1. **📖 Read Documentation** - See [README.md](README.md)
2. **🎓 Learn Commands** - Run `/skillset:guide research --full`
3. **🚀 Start Planning** - Run `/skillset:run research`
4. **📊 Track Progress** - Run `/skillset:list --status`

---

## 📞 Support

### If Installation Fails

1. **Check requirements** - Run verification
   ```bash
   ./verify.sh --verbose
   ```

2. **Check logs** - Look for error messages
   ```bash
   cat /var/log/skillset-install.log
   ```

3. **Run manual installation** - See Method 3 above

4. **Contact support**
   - 🐛 [Report Issue](https://github.com/anthropics/planning-skillset/issues)
   - 💬 [Discussions](https://github.com/anthropics/planning-skillset/discussions)

---

## ✅ Installation Checklist

Before using the skillset, verify:

- [ ] Claude Code installed and working
- [ ] Installation script ran successfully
- [ ] Output shows "Installation verified successfully"
- [ ] `/skillset:list` command works
- [ ] `skillset-output/` directory exists
- [ ] All 8 agents visible
- [ ] First agent guide readable

---

**Congratulations!** 🎉 Your Planning Skillset is ready to use.

Start with: `/skillset:init` followed by `/skillset:run research`
