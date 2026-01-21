# 🔧 Troubleshooting Guide

Solutions for common issues with the Planning Skillset.

---

## Installation Issues

### Issue: "Command not found: claude"

**Problem:** Claude Code is not installed or not in PATH.

**Solutions:**
1. Install Claude Code from https://claude.com/claude-code
2. Add to PATH: `export PATH="$PATH:$HOME/.claude/bin"`
3. Verify: `which claude`

### Issue: "Permission denied" on install.sh

**Problem:** Script doesn't have execute permission.

**Solution:**
```bash
chmod +x install.sh
./install.sh
```

### Issue: Installation fails silently

**Problem:** Error details not shown.

**Solution:**
```bash
# Run with verbose output
VERBOSE=true ./install.sh

# Check logs
cat /var/log/skillset-install.log

# Run verify to diagnose
./verify.sh --verbose
```

### Issue: Insufficient disk space

**Problem:** Not enough space for installation.

**Solution:**
```bash
# Check available space
df -h ~

# Check required space
du -sh agents guides commands lib docs

# Free up space
# (Remove unnecessary files, clear cache, etc.)

# Retry installation
./install.sh
```

---

## Initialization Issues

### Issue: /skillset:init not found

**Problem:** Commands not registered.

**Solutions:**
1. Verify installation: `./verify.sh`
2. Check Claude Code status: `which claude`
3. Restart Claude Code terminal session
4. Reinstall: `./uninstall.sh && ./install.sh`

### Issue: "Output directory creation failed"

**Problem:** Cannot create skillset-output directories.

**Solution:**
```bash
# Manually create directories
mkdir -p skillset-output/{research,analysis,ideation,structure,validation,user-centered,communication,strategy}

# Fix permissions
chmod -R 755 skillset-output/

# Retry init
/skillset:init
```

### Issue: "Metadata initialization failed"

**Problem:** Cannot create metadata files.

**Solution:**
```bash
# Check metadata directory permissions
ls -la ~/.claude/skillsets/

# Fix permissions
mkdir -p ~/.claude/skillsets/planning-skillset
chmod -R 755 ~/.claude/skillsets/

# Reset metadata
/skillset:init --reset
```

---

## Command Issues

### Issue: /skillset:list shows no agents

**Problem:** Agents not loaded properly.

**Solutions:**
1. Verify installation: `./verify.sh`
2. Check agent files exist:
   ```bash
   ls ~/.claude/skillsets/planning-skillset/agents/
   ```
3. Reinitialize:
   ```bash
   /skillset:init --reset
   ```

### Issue: /skillset:run <agent> fails

**Problem:** Agent execution error.

**Solutions:**
1. Check prerequisites:
   ```bash
   /skillset:list --details
   ```
2. Run with verbose output:
   ```bash
   VERBOSE=true /skillset:run research
   ```
3. Check guide first:
   ```bash
   /skillset:guide research --short
   ```

### Issue: Guide command shows wrong content

**Problem:** Guide files not in correct location.

**Solution:**
```bash
# Verify guide location
ls ~/.claude/skillsets/planning-skillset/guides/

# Check guide exists for agent
ls ~/.claude/skillsets/planning-skillset/guides/research-guide.md

# Reinstall if missing
./install.sh
```

---

## Performance Issues

### Issue: Commands run very slowly

**Problem:** Performance degradation.

**Solutions:**
1. Check system resources:
   ```bash
   top -l 1
   df -h
   ```
2. Clear cache:
   ```bash
   rm -rf ~/.claude/.cache/
   ```
3. Reinstall:
   ```bash
   ./install.sh --reset
   ```

### Issue: High memory usage

**Problem:** Skillset consuming excessive memory.

**Solution:**
```bash
# This shouldn't happen with skillset
# If it does, restart Claude Code
# And verify installation
./verify.sh
```

---

## Data/Progress Issues

### Issue: Progress not updating

**Problem:** `/skillset:list` always shows same progress.

**Solution:**
```bash
# Check progress file
cat ~/.claude/skillsets/planning-skillset/progress.json

# Manually update (if needed)
jq '.agents["research-agent"].status = "completed"' progress.json > temp.json
mv temp.json progress.json

# Verify
/skillset:list --status
```

### Issue: Progress file corrupted

**Problem:** Invalid JSON in progress.json.

**Solution:**
```bash
# Reset metadata
/skillset:init --reset

# Or manually fix
cp ~/.claude/skillsets/planning-skillset/progress.json ~/.claude/skillsets/planning-skillset/progress.json.backup
/skillset:init --reset
```

### Issue: Outputs not saving

**Problem:** Files not created in skillset-output/.

**Solution:**
```bash
# Check permissions
ls -la skillset-output/

# Fix permissions
chmod -R 755 skillset-output/

# Verify directory writable
touch skillset-output/test-file.txt
rm skillset-output/test-file.txt
```

---

## Platform-Specific Issues

### macOS Issues

#### "zsh: command not found: /skillset:init"

**Problem:** Using zsh instead of bash.

**Solution:**
```bash
# Use bash explicitly
bash -c "source ~/.claude/commands/skillset/init.md"

# Or switch to bash
chsh -s /bin/bash
```

#### M1/Apple Silicon compatibility

**Solution:**
```bash
# Should work out of the box, but if not:
arch -arm64 /bin/bash -c "./install.sh"
```

### Linux Issues

#### "command not found" for standard tools

**Problem:** Missing coreutils.

**Solution:**
```bash
# Ubuntu/Debian
sudo apt-get install coreutils bash

# RHEL/CentOS
sudo yum install coreutils bash
```

### Windows WSL Issues

#### Path conversion errors

**Problem:** Windows path format issues.

**Solution:**
```bash
# Convert path properly
wslpath -a "C:\Users\Name"

# Use Unix paths
cd /mnt/c/Users/Name/planning-skillset
```

#### Permissions issues in WSL

**Solution:**
```bash
# Fix permissions
chmod -R 755 ~/.claude/

# Or reset with sudo
sudo chmod -R 755 ~/.claude/
```

---

## Recovery Procedures

### Complete Reset

```bash
# Backup current state
cp -r ~/.claude/skillsets ~/.claude/skillsets.backup

# Uninstall
./uninstall.sh

# Clear metadata
rm -rf ~/.claude/skillsets/planning-skillset/

# Reinstall
./install.sh

# Reinitialize
/skillset:init
```

### Restore from Backup

```bash
# If something went wrong
rm -rf ~/.claude/skillsets/planning-skillset/
cp -r ~/.claude/skillsets.backup ~/.claude/skillsets/

# Verify
./verify.sh
```

### Manual Installation Recovery

```bash
# If scripts fail, do manual install
CLAUDE_HOME="$HOME/.claude"

# Copy files
cp -r agents/* "$CLAUDE_HOME/skillsets/planning-skillset/agents/"
cp -r guides/* "$CLAUDE_HOME/skillsets/planning-skillset/guides/"
cp -r commands/* "$CLAUDE_HOME/commands/skillset/"
cp -r lib/skillset/* "$CLAUDE_HOME/lib/skillset/"

# Initialize
/skillset:init

# Verify
./verify.sh
```

---

## Getting Help

### Self-Diagnosis

Run verification:
```bash
./verify.sh --verbose
```

This will check:
- ✓ Installation completeness
- ✓ File locations
- ✓ Permissions
- ✓ Metadata integrity

### Collect Debug Info

```bash
# Gather system info
bash << 'DEBUG'
echo "OS: $(uname -a)"
echo "Claude: $(which claude)"
echo "Bash: $(bash --version | head -1)"
echo "Files:"
ls -la ~/.claude/skillsets/planning-skillset/
echo "Status:"
/skillset:list --json
DEBUG
```

### Report Issues

When reporting bugs, include:
1. **System info** - OS, Claude version, Bash version
2. **Error message** - Full error text
3. **Steps to reproduce** - Exact commands that fail
4. **Expected behavior** - What should happen
5. **Actual behavior** - What actually happens
6. **Logs** - Output with `VERBOSE=true`

Report to: https://github.com/anthropics/planning-skillset/issues

---

## FAQ

### Q: Can I use this without Claude Code?
A: No, this skillset requires Claude Code. It won't work standalone.

### Q: Can I install multiple versions?
A: Yes, but they'll share the same metadata directory.

### Q: Is my data backed up?
A: Backups are created during installation if you choose.

### Q: Can I use this offline?
A: Yes, it's completely offline (no internet required).

### Q: What if I delete skillset-output/? 
A: You lose the output files, but you can regenerate them.

### Q: Can I modify the agents?
A: Yes, edit the YAML files, but changes may be overwritten on update.

### Q: How do I update the skillset?
A: `./install.sh` will update while preserving your outputs.

### Q: What if I run out of disk space?
A: Clear old outputs or increase available space, then reinit.

### Q: Can I back up my progress?
A: Yes: `cp -r skillset-output/ skillset-output.backup/`

### Q: Is there a GUI version?
A: Not yet, planned for v1.1+.

---

## Emergency Procedures

### Skillset completely broken?

```bash
# Option 1: Full uninstall + reinstall
./uninstall.sh
rm -rf ~/.claude/skillsets/planning-skillset/
./install.sh
/skillset:init

# Option 2: Manual cleanup
rm -rf ~/.claude/skillsets/
rm -rf ~/.claude/commands/skillset/
rm -rf ~/.claude/lib/skillset/
./install.sh
```

### Files accidentally deleted?

```bash
# Check backup
ls ~/.claude/skillsets.backup/

# Restore
cp -r ~/.claude/skillsets.backup/* ~/.claude/skillsets/
```

### Still not working?

1. Run `./verify.sh --verbose`
2. Report issue with full output
3. Include system info and steps

---

**Last Updated:** 2026-01-21

For more help, see [ARCHITECTURE.md](ARCHITECTURE.md) and [API.md](API.md)
