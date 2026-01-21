# 🤝 Contributing to Planning Skillset

Thank you for your interest in contributing! We welcome contributions from everyone.

---

## 📋 Code of Conduct

- Be respectful and inclusive
- Provide constructive feedback
- Assume good intentions
- Report issues responsibly

---

## 🚀 How to Contribute

### Report a Bug
1. Check if the bug is already reported in [Issues](https://github.com/anthropics/planning-skillset/issues)
2. Create a new issue with:
   - Clear title
   - Detailed description
   - Steps to reproduce
   - Expected vs actual behavior
   - Screenshots/logs if relevant
   - Your environment (OS, Claude Code version, etc.)

### Request a Feature
1. Check [Issues](https://github.com/anthropics/planning-skillset/issues) for similar requests
2. Create a new issue with:
   - Clear title starting with "Feature Request:"
   - Problem statement
   - Proposed solution
   - Alternative approaches
   - Use cases and benefits

### Submit Code Changes
1. Fork the repository
2. Create a feature branch: `git checkout -b feature/your-feature`
3. Make your changes
4. Test thoroughly
5. Commit with clear messages: `git commit -m "Add: clear description"`
6. Push to your fork
7. Create a Pull Request

---

## 📝 Commit Message Guidelines

Follow this format:

```
Type: Short description (max 50 chars)

Longer description if needed (max 72 chars per line)

- Bullet point 1
- Bullet point 2

Fixes: #123
```

**Types:**
- `Add:` New feature or file
- `Fix:` Bug fix
- `Update:` Enhancement to existing feature
- `Refactor:` Code restructuring without behavior change
- `Docs:` Documentation updates
- `Style:` Formatting, naming, etc.
- `Test:` Test additions or updates

---

## 🧪 Testing

Before submitting, test your changes:

```bash
# Run verification
./verify.sh

# Test installation
./install.sh --verbose

# Test commands
/skillset:init
/skillset:list
/skillset:guide research --short
```

---

## 📁 File Structure Guidelines

### Adding a New Agent

1. Create agent YAML: `agents/your-agent.yaml`
2. Create guide: `guides/your-guide.md`
3. Follow existing structure and naming conventions
4. Update manifest.yaml with new agent info
5. Add test cases

### Adding Documentation

1. Place in `docs/` directory
2. Use consistent formatting
3. Include code examples where relevant
4. Update main README if applicable

### Code Changes

1. Maintain bash script compatibility (bash 4.0+)
2. Add comments for complex logic
3. Follow existing code style
4. Update related documentation

---

## 🔍 Code Review Process

1. **Automated Checks**: PR must pass CI/CD
2. **Code Review**: At least one maintainer reviews
3. **Feedback**: Address review comments
4. **Approval**: Merge when approved
5. **Release**: Included in next version

---

## 📚 Documentation Standards

- Use clear, concise language
- Include examples where helpful
- Keep up-to-date with code changes
- Use consistent formatting
- Add table of contents for long docs

---

## 🐛 Known Issues

See [Issues](https://github.com/anthropics/planning-skillset/issues?q=is%3Aopen+is%3Aissue+label%3Abug) for current bugs.

---

## 💡 Development Tips

### Local Testing
```bash
# Test in development mode
export VERBOSE=true
./install.sh

# Check logs
cat /var/log/skillset-install.log
```

### Debugging
```bash
# Verbose output
VERBOSE=true /skillset:list

# Check metadata
cat ~/.claude/skillsets/planning-skillset/progress.json
```

### Adding Features
1. Check existing implementation
2. Follow established patterns
3. Add comprehensive tests
4. Update documentation
5. Request feedback early

---

## 📦 Release Process

Maintainers follow:
1. Update CHANGELOG.md
2. Bump version (semver)
3. Tag release on GitHub
4. Publish to npm (if applicable)

---

## 🎓 Learning Resources

- Read existing agent implementations
- Study the manifest.yaml structure
- Review command implementations
- Check test scripts

---

## 🙋 Questions?

- 📖 Check documentation first
- 💬 [Start a discussion](https://github.com/anthropics/planning-skillset/discussions)
- 📧 Contact: support@planning-skillset.com

---

## ✨ Recognition

Contributors will be:
- Listed in CHANGELOG.md
- Acknowledged in README.md
- Featured in releases

---

Thank you for contributing! 🎉
