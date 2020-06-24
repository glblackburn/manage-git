#!/usr/bin/env bash

src_branch=$1
if [ -z "$src_branch" ]; then
  echo "Please specify a source branch"
  exit 1
fi

dst_branch=$2
if [ -z "$dst_branch" ]; then
  echo "Please specify a destination branch"
  exit 2
fi

# Ensure working directory in version branch clean
git update-index -q --refresh
if ! git diff-index --quiet HEAD --; then
  echo "Working directory not clean, please commit your changes first"
  exit
fi

# Get current branch and checkout if needed
branch=$(git symbolic-ref --short -q HEAD)
if [ "$branch" != "$dst_branch" ]; then
  git checkout $dst_branch
fi
