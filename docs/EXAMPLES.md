# 💡 Usage Examples

Real-world scenarios and complete workflow examples for the Planning Skillset.

---

## Scenario 1: Complete Web App Planning Workflow

Run all 8 agents in sequence to complete a full planning cycle.

### Steps

```bash
# Step 1: Initialize
/skillset:init

# Step 2: Start research
/skillset:run research
# Answer: What market segment are we targeting?
# Output: Market analysis report, competitor analysis

# Step 3: Analyze findings
/skillset:run analysis
# Answer: What patterns emerge from the data?
# Output: Data summary, insights document

# Step 4: Generate ideas
/skillset:run ideation
# Answer: What solutions can we propose?
# Output: Idea document, concept sketches

# Step 5: Structure product
/skillset:run structure
# Answer: How do we build this?
# Output: Product spec, architecture

# Step 6: Validate plan
/skillset:run validation
# Answer: What are the risks?
# Output: Validation report, risk assessment

# Step 7: Optimize UX
/skillset:run user-centered
# Answer: How can we improve user experience?
# Output: UX document, user flows

# Step 8: Create strategy
/skillset:run strategy
# Answer: What's our long-term vision?
# Output: Strategic plan, roadmap
```

### Expected Output
```
✓ Research: 4 outputs generated
✓ Analysis: 3 outputs generated
✓ Ideation: 5 outputs generated
✓ Structure: 6 outputs generated
✓ Validation: 4 outputs generated
✓ User-Centered: 5 outputs generated
✓ Communication: 3 outputs generated
✓ Strategy: 2 outputs generated

Total: 32 planning documents created
```

---

## Scenario 2: Rapid MVP Planning (4 Hours)

Focused, time-constrained planning for an MVP.

```bash
# Only essential agents
/skillset:run research       # 1 hour - Research competitors
/skillset:run ideation       # 1 hour - Generate MVP ideas
/skillset:run structure      # 1 hour - Define core features
/skillset:run validation     # 1 hour - Quick risk check

# Check progress
/skillset:list --status
```

**Output:** 15-20 focused planning documents

---

## Scenario 3: Re-planning Existing Project

Restart planning for specific aspects without repeating all work.

```bash
# Already completed: research, analysis, ideation, structure
# Need to: revise strategy and communication

# Skip ahead
/skillset:run communication
/skillset:run strategy

# View only recent outputs
/skillset:list --details
```

---

## Scenario 4: Learning Through Guides

Understand each agent before execution.

```bash
# Get quick overview
/skillset:guide research --short
# (2 min read - understand purpose and steps)

# Run agent with guide visible
/skillset:run research --guide
# (Guide displays alongside execution)

# Study complete guide
/skillset:guide research --full
# (30 min read - comprehensive understanding)

# Save for later reference
/skillset:guide research --full --print > my-research-guide.md
```

---

## Scenario 5: Team Collaboration Workflow

Multiple team members working on the planning process.

```bash
# Team Lead: Initialize
/skillset:init

# Team Member 1: Research Phase
/skillset:run research
# Create market analysis document

# Team Member 2: Analysis Phase (can start after research outputs are created)
/skillset:run analysis --guide
# Review team member 1's findings
# Create insights document

# Team Lead: Monitor progress
/skillset:list --status
# Check what's been completed

# Team: All available
/skillset:list --json | jq '.agents[] | select(.status == "pending")'
# Find next available work
```

---

## Scenario 6: Documentation Export

Export planning documentation for stakeholders.

```bash
# Save all guides
for agent in research analysis ideation structure validation user-centered communication strategy; do
  /skillset:guide $agent --full --print > docs/$agent-guide.md
done

# Export progress summary
/skillset:list --json > planning-progress.json

# Create executive summary
cat > PLANNING_SUMMARY.md << 'SUMMARY'
# Planning Progress Report

Generated: $(date)
Status: See planning-progress.json
SUMMARY
```

---

## Scenario 7: Recovering From Errors

If a process gets interrupted or fails.

```bash
# Verify installation
./verify.sh

# Check current state
/skillset:list --status

# If corrupted, reset
/skillset:init --reset

# Continue from where you were
/skillset:run ideation --continue

# If needed, reinstall
./uninstall.sh
./install.sh
```

---

## Scenario 8: Custom Extension

Building custom scripts on top of skillset.

```bash
#!/bin/bash

# Source utilities
source ~/.claude/lib/skillset/skillset-utils.sh

# Custom workflow
print_header "Custom Planning Workflow"

# Run specific agents
agents=("research-agent" "analysis-agent" "ideation-agent")
for agent in "${agents[@]}"; do
  if is_valid_agent "$agent"; then
    print_info "Running $agent..."
    # Custom logic here
  fi
done

# Generate report
print_header "Planning Complete"
completed=$(scan_progress)
print_success "Completed: $completed agents"
```

---

## Scenario 9: Batch Testing

Test all functionality quickly.

```bash
#!/bin/bash

echo "Testing Planning Skillset..."

# Test 1: Initialization
echo "Test 1: Init"
/skillset:init
assert_success

# Test 2: List agents
echo "Test 2: List"
/skillset:list
assert_success

# Test 3: Show guides
echo "Test 3: Guides"
/skillset:guide research --short
assert_success

# Test 4: Verify
echo "Test 4: Verify"
./verify.sh
assert_success

echo "✓ All tests passed"
```

---

## Scenario 10: Performance Testing

Benchmark the skillset on your system.

```bash
#!/bin/bash

# Measure initialization time
time /skillset:init

# Measure command response time
time /skillset:list

# Measure guide loading
time /skillset:guide research --short

# Test with verbose logging
VERBOSE=true time /skillset:run research
```

---

## Common Patterns

### Pattern 1: Sequential Agent Execution
```bash
for agent in research analysis ideation structure validation user-centered communication strategy; do
  /skillset:run $agent
done
```

### Pattern 2: Conditional Execution
```bash
if is_initialized; then
  /skillset:run research
else
  /skillset:init
  /skillset:run research
fi
```

### Pattern 3: Progress Monitoring
```bash
while true; do
  /skillset:list --status
  sleep 10  # Check every 10 seconds
done
```

### Pattern 4: Error Recovery
```bash
if ! /skillset:run research 2>/dev/null; then
  echo "Error running research"
  ./verify.sh
  exit 1
fi
```

---

## Tips & Tricks

### Speed Up Planning
- Use `--short` guides for quick overviews
- Focus on essential agents only
- Reuse outputs from similar projects

### Team Efficiency
- Share outputs as soon as available
- Use JSON format for parsing: `/skillset:list --json`
- Set up automated progress reporting

### Learning
- Start with `--short` guides
- Progress to `--full` guides when ready
- Study existing outputs

### Customization
- Create wrapper scripts
- Combine with other tools (grep, jq, etc.)
- Automate with cron jobs

---

**Last Updated:** 2026-01-21
