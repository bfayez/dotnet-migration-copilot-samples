#!/bin/bash
# Complete setup script for creating migration issues
# This script automates the entire process

set -e

echo "=========================================="
echo "ContosoUniversity Migration Issue Creator"
echo "=========================================="
echo ""

# Check if gh is installed
if ! command -v gh &> /dev/null; then
    echo "❌ GitHub CLI (gh) is not installed."
    echo "Please install it from: https://cli.github.com/"
    exit 1
fi

# Check if authenticated
if ! gh auth status &> /dev/null; then
    echo "⚠️  Not authenticated with GitHub"
    echo "Please authenticate first:"
    echo "  gh auth login"
    echo ""
    read -p "Press Enter to authenticate now, or Ctrl+C to cancel..."
    gh auth login
fi

echo "✅ GitHub CLI is installed and authenticated"
echo ""

# Step 1: Create labels
echo "Step 1: Creating labels..."
if [ -f "create-labels.sh" ]; then
    ./create-labels.sh
    echo "✅ Labels created"
else
    echo "❌ create-labels.sh not found!"
    exit 1
fi
echo ""

# Step 2: Confirm issue creation
echo "Step 2: Ready to create issues"
echo "This will create 47 GitHub issues for the migration plan."
echo ""
read -p "Do you want to continue? (yes/no): " confirm

if [ "$confirm" != "yes" ]; then
    echo "Cancelled."
    exit 0
fi

# Step 3: Create issues
echo ""
echo "Step 3: Creating 47 issues..."
if [ -f "create-issues.sh" ]; then
    ./create-issues.sh
    echo ""
    echo "=========================================="
    echo "✅ All 47 issues created successfully!"
    echo "=========================================="
else
    echo "❌ create-issues.sh not found!"
    exit 1
fi

# Step 4: Summary
echo ""
echo "📊 Issue Summary:"
echo "  - Phase 0: 6 issues (Assessment and Planning)"
echo "  - Phase 1: 13 issues (Foundation - Core Migration)"
echo "  - Phase 2: 12 issues (Azure Services Integration)"
echo "  - Phase 3: 7 issues (Testing and Quality)"
echo "  - Phase 4: 5 issues (Deployment and Cutover)"
echo "  - Post-Migration: 4 issues (Enhancements)"
echo ""
echo "🔗 View issues: gh issue list"
echo "🔗 Or visit: https://github.com/$(gh repo view --json nameWithOwner -q .nameWithOwner)/issues"
echo ""
echo "📚 Next steps:"
echo "  1. Review created issues"
echo "  2. Create a Project board for tracking"
echo "  3. Assign issues to team members"
echo "  4. Start with Phase 0 tasks"
echo ""
echo "📖 For more information, see:"
echo "  - QUICK_START.md - Quick reference guide"
echo "  - ISSUE_CREATION_GUIDE.md - Comprehensive guide"
echo "  - ISSUES_SUMMARY.md - Summary of all issues"
echo ""
