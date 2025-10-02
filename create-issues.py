#!/usr/bin/env python3
"""
Script to create GitHub issues from task markdown files.
This script generates the data needed to create issues following best practices.
"""

import os
import re
import json
from pathlib import Path

# Define the repository root
REPO_ROOT = Path(__file__).parent
TASKS_DIR = REPO_ROOT / "tasks"

# Phase information for labels
PHASE_INFO = {
    "phase-0-assessment-planning": {
        "label": "phase-0",
        "name": "Phase 0: Assessment and Planning"
    },
    "phase-1-foundation": {
        "label": "phase-1",
        "name": "Phase 1: Foundation - Core Migration"
    },
    "phase-2-azure-integration": {
        "label": "phase-2",
        "name": "Phase 2: Azure Services Integration"
    },
    "phase-3-testing-quality": {
        "label": "phase-3",
        "name": "Phase 3: Testing and Quality"
    },
    "phase-4-deployment": {
        "label": "phase-4",
        "name": "Phase 4: Deployment and Cutover"
    },
    "post-migration": {
        "label": "post-migration",
        "name": "Post-Migration: Enhancements"
    }
}

def extract_title_from_content(content):
    """Extract title from the first heading in the markdown content."""
    match = re.search(r'^#\s+Task:\s+(.+)$', content, re.MULTILINE)
    if match:
        return match.group(1).strip()
    # Fallback to first heading
    match = re.search(r'^#\s+(.+)$', content, re.MULTILINE)
    if match:
        return match.group(1).strip()
    return None

def extract_estimated_effort(content):
    """Extract estimated effort from the task content."""
    match = re.search(r'##\s+Estimated Effort\s+(.+?)(?=\n##|\Z)', content, re.DOTALL)
    if match:
        effort_text = match.group(1).strip()
        # Map to effort labels
        if 'day' in effort_text.lower():
            if '1-2 days' in effort_text or '1 day' in effort_text:
                return '1-2-days'
            elif '2-3 days' in effort_text:
                return '2-3-days'
            elif '3-4 days' in effort_text:
                return '3-4-days'
            else:
                return '1-week'
        elif 'week' in effort_text.lower():
            if '2 weeks' in effort_text:
                return '2-weeks'
            else:
                return '1-week'
    return None

def determine_type_label(title, content):
    """Determine the type label based on task title and content."""
    title_lower = title.lower()
    content_lower = content.lower()
    
    if any(word in title_lower for word in ['test', 'testing']):
        return 'testing'
    elif any(word in title_lower for word in ['deploy', 'deployment', 'docker', 'container', 'cicd', 'ci/cd']):
        return 'deployment'
    elif any(word in title_lower for word in ['azure', 'sql', 'service bus', 'blob', 'key vault', 'ad b2c']):
        return 'azure'
    elif any(word in title_lower for word in ['setup', 'set up', 'create project', 'inventory', 'planning']):
        return 'setup'
    elif any(word in title_lower for word in ['migrate', 'convert', 'update', 'move']):
        return 'migration'
    elif any(word in title_lower for word in ['monitor', 'caching', 'signalr', 'disaster recovery', 'optimization']):
        return 'enhancement'
    else:
        return 'migration'

def determine_priority(phase, task_number):
    """Determine priority based on phase and task order."""
    if phase == "phase-0-assessment-planning":
        return "critical"  # Phase 0 is critical setup
    elif phase == "phase-1-foundation" and task_number <= 5:
        return "high"  # Early phase 1 tasks are high priority
    elif phase == "phase-4-deployment":
        return "high"  # Deployment tasks are high priority
    elif phase == "post-migration":
        return "medium"  # Post-migration enhancements are medium
    else:
        return "high"  # Default to high for migration tasks

def parse_task_file(file_path, phase):
    """Parse a task markdown file and extract metadata."""
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    title = extract_title_from_content(content)
    if not title:
        title = file_path.stem.replace('-', ' ').title()
    
    # Extract task number from filename
    task_number = int(file_path.stem.split('-')[0]) if file_path.stem[0].isdigit() else 0
    
    # Determine labels
    phase_label = PHASE_INFO[phase]["label"]
    effort_label = extract_estimated_effort(content)
    type_label = determine_type_label(title, content)
    priority_label = determine_priority(phase, task_number)
    
    labels = [phase_label, type_label, priority_label]
    if effort_label:
        labels.append(effort_label)
    
    return {
        "title": title,
        "body": content,
        "labels": labels,
        "file_path": str(file_path.relative_to(REPO_ROOT)),
        "phase": phase,
        "task_number": task_number
    }

def collect_all_tasks():
    """Collect all task files from the tasks directory."""
    tasks = []
    
    for phase_dir in sorted(TASKS_DIR.iterdir()):
        if not phase_dir.is_dir():
            continue
        
        phase_name = phase_dir.name
        if phase_name not in PHASE_INFO:
            continue
        
        task_files = sorted(phase_dir.glob("*.md"))
        
        for task_file in task_files:
            task_data = parse_task_file(task_file, phase_name)
            tasks.append(task_data)
    
    return tasks

def generate_gh_commands(tasks):
    """Generate GitHub CLI commands to create issues."""
    commands = []
    
    for i, task in enumerate(tasks, 1):
        labels_str = ",".join(task["labels"])
        
        # Escape special characters in title and body
        title = task["title"].replace('"', '\\"')
        
        # Save body to a temp file to avoid shell escaping issues
        body_file = f"/tmp/issue-body-{i}.md"
        
        cmd = f"""# Issue {i}: {task['title']}
# File: {task['file_path']}
# Phase: {task['phase']}
cat > {body_file} << 'EOF'
{task['body']}
EOF

gh issue create \\
  --title "{title}" \\
  --body-file {body_file} \\
  --label "{labels_str}"

"""
        commands.append(cmd)
    
    return "\n".join(commands)

def generate_issue_data_json(tasks):
    """Generate JSON data for issues that can be used programmatically."""
    return json.dumps(tasks, indent=2)

def main():
    """Main function to generate issue creation artifacts."""
    print("Collecting tasks from the tasks directory...")
    tasks = collect_all_tasks()
    
    print(f"Found {len(tasks)} tasks across {len(PHASE_INFO)} phases.")
    
    # Generate shell script with gh commands
    print("\nGenerating shell script with GitHub CLI commands...")
    commands_script = f"""#!/bin/bash
# Script to create GitHub issues for ContosoUniversity migration tasks
# Generated automatically from task markdown files
#
# Usage:
#   1. Ensure you're authenticated with GitHub CLI: gh auth login
#   2. Run this script: ./create-issues.sh
#
# Total issues to create: {len(tasks)}

set -e  # Exit on error

echo "Creating {len(tasks)} GitHub issues for ContosoUniversity migration..."
echo ""

{generate_gh_commands(tasks)}

echo ""
echo "Successfully created {len(tasks)} issues!"
echo "View them at: gh issue list"
"""
    
    script_path = REPO_ROOT / "create-issues.sh"
    with open(script_path, 'w', encoding='utf-8') as f:
        f.write(commands_script)
    os.chmod(script_path, 0o755)
    print(f"Created: {script_path}")
    
    # Generate JSON data
    print("\nGenerating JSON data file...")
    json_data = generate_issue_data_json(tasks)
    json_path = REPO_ROOT / "issues-data.json"
    with open(json_path, 'w', encoding='utf-8') as f:
        f.write(json_data)
    print(f"Created: {json_path}")
    
    # Generate summary report
    print("\nGenerating summary report...")
    summary = f"""# GitHub Issues Creation Summary

## Overview
- **Total Issues**: {len(tasks)}
- **Phases**: {len(PHASE_INFO)}

## Issues by Phase
"""
    
    for phase_name, phase_info in PHASE_INFO.items():
        phase_tasks = [t for t in tasks if t["phase"] == phase_name]
        summary += f"\n### {phase_info['name']}\n"
        summary += f"- **Count**: {len(phase_tasks)} issues\n"
        summary += f"- **Label**: `{phase_info['label']}`\n"
        summary += f"\n"
        for task in phase_tasks:
            summary += f"- [ ] {task['title']} ({', '.join(task['labels'])})\n"
    
    summary += f"""
## Labels Used

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
- `critical` - Must be done first
- `high` - High priority
- `medium` - Medium priority
- `low` - Low priority

## How to Create Issues

### Method 1: Using GitHub CLI (Recommended)
```bash
# Authenticate with GitHub
gh auth login

# Run the generated script
./create-issues.sh
```

### Method 2: Using the Web UI
1. Go to the repository's Issues page
2. Click "New Issue"
3. Use the data from `issues-data.json` to create each issue:
   - Copy the title
   - Copy the body (markdown content)
   - Add the labels
4. Repeat for all {len(tasks)} tasks

### Method 3: Using GitHub API
Use the `issues-data.json` file with a script that calls the GitHub API to create issues programmatically.

## Next Steps

After creating the issues:
1. Review all created issues
2. Link dependencies between issues (use GitHub issue references like #1, #2, etc.)
3. Add issues to a GitHub Project board for tracking
4. Assign issues to team members as needed
5. Organize issues by milestone if needed

## Files Generated
- `create-issues.sh` - Shell script with gh CLI commands
- `issues-data.json` - JSON data for programmatic issue creation
- `ISSUES_SUMMARY.md` - This summary document
"""
    
    summary_path = REPO_ROOT / "ISSUES_SUMMARY.md"
    with open(summary_path, 'w', encoding='utf-8') as f:
        f.write(summary)
    print(f"Created: {summary_path}")
    
    print("\n" + "="*70)
    print("✓ Issue creation artifacts generated successfully!")
    print("="*70)
    print(f"\nGenerated files:")
    print(f"  1. create-issues.sh     - Shell script to create issues via gh CLI")
    print(f"  2. issues-data.json     - JSON data for programmatic creation")
    print(f"  3. ISSUES_SUMMARY.md    - Summary and instructions")
    print(f"\nTo create issues, run:")
    print(f"  ./create-issues.sh")

if __name__ == "__main__":
    main()
