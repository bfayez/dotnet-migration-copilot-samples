# Creating GitHub Issues for Migration Plan

This directory contains tools and instructions for creating GitHub issues from the migration task files in the `tasks/` directory.

## 📋 Overview

The migration plan consists of **47 tasks** organized into **6 phases**:

| Phase | Description | Tasks | Duration |
|-------|-------------|-------|----------|
| Phase 0 | Assessment and Planning | 6 | 2 weeks |
| Phase 1 | Foundation - Core Migration | 13 | 4 weeks |
| Phase 2 | Azure Services Integration | 12 | 3 weeks |
| Phase 3 | Testing and Quality | 7 | 2 weeks |
| Phase 4 | Deployment and Cutover | 5 | 1 week |
| Post-Migration | Enhancements | 4 | Ongoing |

## 🚀 Quick Start

### Method 1: GitHub CLI (Recommended)

The fastest way to create all issues:

```bash
# 1. Authenticate with GitHub
gh auth login

# 2. Run the script
./create-issues.sh
```

This will create all 47 issues with proper labels, titles, and descriptions.

### Method 2: GitHub Actions Workflow

Use the included GitHub Actions workflow to create issues:

1. Go to the **Actions** tab in your repository
2. Select **"Create Migration Issues"** workflow
3. Click **"Run workflow"**
4. Type `create-issues` to confirm
5. Click **"Run workflow"**

The workflow will:
- Generate issue data from task files
- Create all 47 issues automatically
- Apply appropriate labels to each issue

### Method 3: Manual Creation

If you prefer to create issues manually or need to customize them:

1. Review the generated `issues-data.json` file
2. For each issue in the JSON:
   - Go to GitHub Issues → New Issue
   - Copy the `title` field as the issue title
   - Copy the `body` field as the issue description
   - Add all labels from the `labels` array

## 📁 Generated Files

After running `create-issues.py`, you'll have:

| File | Description |
|------|-------------|
| `create-issues.sh` | Shell script with `gh` CLI commands to create all issues |
| `issues-data.json` | JSON data containing all issue details |
| `ISSUES_SUMMARY.md` | Human-readable summary of all issues |

## 🏷️ Labels

Issues are automatically labeled with:

### Phase Labels
- `phase-0` - Assessment and Planning
- `phase-1` - Foundation - Core Migration  
- `phase-2` - Azure Services Integration
- `phase-3` - Testing and Quality
- `phase-4` - Deployment and Cutover
- `post-migration` - Post-Migration Enhancements

### Effort Labels
- `1-2-days` - 1-2 days of effort
- `2-3-days` - 2-3 days of effort
- `3-4-days` - 3-4 days of effort
- `1-week` - 1 week of effort
- `2-weeks` - 2 weeks of effort

### Type Labels
- `setup` - Setup and preparation tasks
- `migration` - Code migration tasks
- `azure` - Azure services integration
- `testing` - Testing tasks
- `deployment` - Deployment tasks
- `enhancement` - Post-migration enhancements

### Priority Labels
- `critical` - Must be done first (Phase 0 tasks)
- `high` - High priority (most migration tasks)
- `medium` - Medium priority (post-migration enhancements)
- `low` - Low priority

## 🔧 Customization

### Regenerating Issue Data

If you modify task files or want to update the generated files:

```bash
python3 create-issues.py
```

This will regenerate all three output files.

### Modifying Labels

To customize label assignment logic, edit `create-issues.py`:

- `determine_type_label()` - Controls type labels based on task content
- `determine_priority()` - Controls priority labels based on phase
- `extract_estimated_effort()` - Maps effort text to effort labels

### Adding Dependencies

After creating issues, you should link dependencies between them:

1. Note the issue numbers GitHub assigns
2. Edit issue descriptions to add dependencies like:
   ```markdown
   ## Dependencies
   - #1 - Application Inventory and Dependency Analysis
   - #2 - Set Up Azure Subscription
   ```

## 📊 Best Practices

When working with these issues:

### 1. Create Labels First
Before running the script, create these labels in your repository:
```bash
# You can create labels using gh CLI
gh label create "phase-0" --color "0052CC" --description "Phase 0: Assessment and Planning"
gh label create "phase-1" --color "0052CC" --description "Phase 1: Foundation"
gh label create "phase-2" --color "0052CC" --description "Phase 2: Azure Integration"
gh label create "phase-3" --color "0052CC" --description "Phase 3: Testing and Quality"
gh label create "phase-4" --color "0052CC" --description "Phase 4: Deployment"
gh label create "post-migration" --color "0052CC" --description "Post-Migration Enhancements"

# Effort labels
gh label create "1-2-days" --color "FBCA04" --description "1-2 days of effort"
gh label create "2-3-days" --color "FBCA04" --description "2-3 days of effort"
gh label create "3-4-days" --color "FBCA04" --description "3-4 days of effort"
gh label create "1-week" --color "D93F0B" --description "1 week of effort"
gh label create "2-weeks" --color "D93F0B" --description "2 weeks of effort"

# Type labels
gh label create "setup" --color "1D76DB" --description "Setup and preparation"
gh label create "migration" --color "1D76DB" --description "Code migration"
gh label create "azure" --color "0075CA" --description "Azure services"
gh label create "testing" --color "28A745" --description "Testing tasks"
gh label create "deployment" --color "5319E7" --description "Deployment tasks"
gh label create "enhancement" --color "84B6EB" --description "Enhancements"

# Priority labels
gh label create "critical" --color "B60205" --description "Critical priority"
gh label create "high" --color "D93F0B" --description "High priority"
gh label create "medium" --color "FBCA04" --description "Medium priority"
gh label create "low" --color "0E8A16" --description "Low priority"
```

Or use the provided script:
```bash
./create-labels.sh
```

### 2. Organize in a Project Board
After creating issues:
1. Create a GitHub Project board
2. Add all issues to the board
3. Organize by phase using board columns
4. Track progress as work is completed

### 3. Link Dependencies
Use GitHub's task lists and issue references:
```markdown
## Dependencies
- Depends on #1, #2
- Blocks #5, #6
```

### 4. Assign to Team Members
Distribute work across your team:
```bash
gh issue edit 1 --add-assignee username1
gh issue edit 2 --add-assignee username2
```

### 5. Set Milestones
Group issues by milestones:
```bash
gh issue edit 1-6 --milestone "Phase 0"
gh issue edit 7-19 --milestone "Phase 1"
```

## 🔍 Verification

After creating issues, verify:

```bash
# List all created issues
gh issue list --limit 50

# Count issues by label
gh issue list --label "phase-0" --state all
gh issue list --label "phase-1" --state all

# View a specific issue
gh issue view 1
```

## 🛠️ Troubleshooting

### Issue: Script fails with authentication error
**Solution**: Run `gh auth login` and follow the prompts to authenticate.

### Issue: Labels don't exist
**Solution**: Create labels first using the script in the Best Practices section above, or let GitHub create them automatically (they'll have default colors).

### Issue: Want to recreate specific issues
**Solution**: 
1. Close/delete the existing issue
2. Extract the specific command from `create-issues.sh`
3. Run just that command

### Issue: Need to update issue descriptions
**Solution**: After creation, edit issues with:
```bash
gh issue edit <number> --body-file new-description.md
```

## 📚 Additional Resources

- [GitHub CLI Documentation](https://cli.github.com/manual/)
- [GitHub Issues Documentation](https://docs.github.com/en/issues)
- [GitHub Projects Documentation](https://docs.github.com/en/issues/planning-and-tracking-with-projects)
- [Task files](./tasks/) - Original task markdown files
- [Migration plan](./MigrationWithModernization.md) - Overall migration strategy

## 🤝 Contributing

If you find issues with the task descriptions or issue generation:

1. Update the task files in `tasks/` directory
2. Regenerate issue data: `python3 create-issues.py`
3. Review changes in the generated files
4. Create a pull request with your improvements

## 📝 Notes

- Issues are created in the order they should be executed
- Each issue includes comprehensive details from the task files
- Dependencies are documented in each issue's description
- The script is idempotent - you can run it multiple times (though it will create duplicate issues)

---

**Need help?** Open an issue in this repository or consult the team lead.
