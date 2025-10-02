# Quick Reference: Creating Migration Issues

This is a quick reference for creating all 47 migration issues from the task files.

## ⚡ Quick Start (30 seconds)

```bash
# Step 1: Authenticate with GitHub CLI
gh auth login

# Step 2: Create labels (one-time setup)
./create-labels.sh

# Step 3: Create all 47 issues
./create-issues.sh
```

That's it! All issues will be created with proper labels and descriptions.

## 📊 What Gets Created

- **47 GitHub Issues** - One for each migration task
- **Proper Labels** - Phase, effort, type, and priority labels
- **Full Descriptions** - Complete task details from markdown files
- **Organized by Phase** - Easy to filter and track

## 🏷️ Label Legend

### Phase Labels
- 🔵 `phase-0` - Assessment and Planning (6 issues)
- 🔵 `phase-1` - Foundation - Core Migration (13 issues)
- 🔵 `phase-2` - Azure Services Integration (12 issues)
- 🔵 `phase-3` - Testing and Quality (7 issues)
- 🔵 `phase-4` - Deployment and Cutover (5 issues)
- 🔵 `post-migration` - Enhancements (4 issues)

### Effort Labels
- 🟡 `1-2-days` - Short tasks
- 🟡 `2-3-days` - Medium tasks
- 🟡 `3-4-days` - Longer tasks
- 🟠 `1-week` - Week-long tasks
- 🟠 `2-weeks` - Extended tasks

### Type Labels
- 🔷 `setup` - Setup and preparation
- 🔷 `migration` - Code migration
- 🔵 `azure` - Azure services
- 🟢 `testing` - Testing tasks
- 🟣 `deployment` - Deployment tasks
- 💙 `enhancement` - Post-migration enhancements

### Priority Labels
- 🔴 `critical` - Phase 0 tasks (must do first)
- 🟠 `high` - Most migration tasks
- 🟡 `medium` - Post-migration tasks
- 🟢 `low` - Optional tasks

## 🔍 Viewing Issues

After creation:

```bash
# List all issues
gh issue list --limit 50

# Filter by phase
gh issue list --label "phase-0"
gh issue list --label "phase-1"

# Filter by type
gh issue list --label "azure"
gh issue list --label "testing"

# View a specific issue
gh issue view 1
```

## 📋 Issue Organization

### Recommended Workflow

1. **Create a Project Board**
   ```bash
   # Create a new project
   gh project create "ContosoUniversity Migration"
   ```

2. **Add columns for each phase**
   - Phase 0: Planning
   - Phase 1: Foundation
   - Phase 2: Azure
   - Phase 3: Testing
   - Phase 4: Deployment
   - Post-Migration

3. **Move issues as you progress**

### Milestones (Optional)

Create milestones for major phases:

```bash
gh milestone create "Phase 0 Complete" --due 2024-12-31
gh milestone create "Phase 1 Complete" --due 2025-01-31
# ... etc
```

Then assign issues to milestones:

```bash
# Assign Phase 0 issues to milestone
gh issue edit 1 --milestone "Phase 0 Complete"
gh issue edit 2 --milestone "Phase 0 Complete"
# ... etc
```

## 🚨 Troubleshooting

### "Not logged in to GitHub"
```bash
gh auth login
# Follow the prompts
```

### "Label already exists"
This is normal - the script handles existing labels gracefully.

### "Permission denied"
Make sure the scripts are executable:
```bash
chmod +x create-issues.sh create-labels.sh
```

### Want to recreate a specific issue?
Extract the command from `create-issues.sh` for that issue and run it individually.

## 📚 More Information

- **Full Guide**: [ISSUE_CREATION_GUIDE.md](./ISSUE_CREATION_GUIDE.md)
- **Issues Summary**: [ISSUES_SUMMARY.md](./ISSUES_SUMMARY.md)
- **Migration Plan**: [MigrationWithModernization.md](./MigrationWithModernization.md)
- **Task Files**: [tasks/](./tasks/)

## ✅ Next Steps After Creating Issues

1. ✅ Review all created issues
2. ✅ Set up a Project board for tracking
3. ✅ Assign issues to team members
4. ✅ Link dependencies between issues
5. ✅ Start with Phase 0 tasks
6. ✅ Track progress as you complete tasks

---

**Need help?** See the [full guide](./ISSUE_CREATION_GUIDE.md) or open an issue in this repository.
