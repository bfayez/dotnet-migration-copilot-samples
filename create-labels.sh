#!/bin/bash
# Script to create GitHub labels for ContosoUniversity migration issues
# This should be run before creating issues to ensure all labels exist

set -e

echo "Creating GitHub labels for migration issues..."
echo ""

# Phase labels (blue shades)
echo "Creating phase labels..."
gh label create "phase-0" --color "0052CC" --description "Phase 0: Assessment and Planning" --force 2>/dev/null || true
gh label create "phase-1" --color "0052CC" --description "Phase 1: Foundation - Core Migration" --force 2>/dev/null || true
gh label create "phase-2" --color "0052CC" --description "Phase 2: Azure Services Integration" --force 2>/dev/null || true
gh label create "phase-3" --color "0052CC" --description "Phase 3: Testing and Quality" --force 2>/dev/null || true
gh label create "phase-4" --color "0052CC" --description "Phase 4: Deployment and Cutover" --force 2>/dev/null || true
gh label create "post-migration" --color "0052CC" --description "Post-Migration Enhancements" --force 2>/dev/null || true

# Effort labels (yellow/orange shades)
echo "Creating effort labels..."
gh label create "1-2-days" --color "FBCA04" --description "1-2 days of effort" --force 2>/dev/null || true
gh label create "2-3-days" --color "FBCA04" --description "2-3 days of effort" --force 2>/dev/null || true
gh label create "3-4-days" --color "FBCA04" --description "3-4 days of effort" --force 2>/dev/null || true
gh label create "1-week" --color "D93F0B" --description "1 week of effort" --force 2>/dev/null || true
gh label create "2-weeks" --color "D93F0B" --description "2 weeks of effort" --force 2>/dev/null || true

# Type labels (various colors)
echo "Creating type labels..."
gh label create "setup" --color "1D76DB" --description "Setup and preparation tasks" --force 2>/dev/null || true
gh label create "migration" --color "1D76DB" --description "Code migration tasks" --force 2>/dev/null || true
gh label create "azure" --color "0075CA" --description "Azure services integration" --force 2>/dev/null || true
gh label create "testing" --color "28A745" --description "Testing tasks" --force 2>/dev/null || true
gh label create "deployment" --color "5319E7" --description "Deployment tasks" --force 2>/dev/null || true
gh label create "enhancement" --color "84B6EB" --description "Post-migration enhancements" --force 2>/dev/null || true

# Priority labels (traffic light colors)
echo "Creating priority labels..."
gh label create "critical" --color "B60205" --description "Critical priority - must be done first" --force 2>/dev/null || true
gh label create "high" --color "D93F0B" --description "High priority" --force 2>/dev/null || true
gh label create "medium" --color "FBCA04" --description "Medium priority" --force 2>/dev/null || true
gh label create "low" --color "0E8A16" --description "Low priority" --force 2>/dev/null || true

echo ""
echo "✓ All labels created successfully!"
echo ""
echo "To view all labels, run: gh label list"
