#!/bin/bash
# Run this once after creating the repo.
# Requires: gh CLI installed and logged in.
# Usage: bash scripts/setup-repo.sh

REPO=$(gh repo view --json nameWithOwner -q .nameWithOwner)

echo "Setting up $REPO..."

# protect main - requires 2 approvals
gh api repos/$REPO/branches/main/protection --method PUT \
  --field "required_pull_request_reviews[required_approving_review_count]=2" \
  --field "required_pull_request_reviews[dismiss_stale_reviews]=true" \
  --field "enforce_admins=false" \
  --field "restrictions=null" \
  --field "required_status_checks=null"

echo "main branch protected"

# protect develop - requires 1 approval
gh api repos/$REPO/branches/develop/protection --method PUT \
  --field "required_pull_request_reviews[required_approving_review_count]=1" \
  --field "required_pull_request_reviews[dismiss_stale_reviews]=true" \
  --field "enforce_admins=false" \
  --field "restrictions=null" \
  --field "required_status_checks=null"

echo "develop branch protected"

# create labels
gh label create "backend"  --color "0075ca" --force
gh label create "frontend" --color "e4e669" --force
gh label create "devops"   --color "d93f0b" --force
gh label create "bug"      --color "d73a4a" --force
gh label create "feature"  --color "a2eeef" --force

echo "Labels created"
echo "Done."