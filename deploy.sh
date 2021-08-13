#!/bin/sh

# If a command fails then the deploy stops
set -e

printf "\033[0;32mDeploying updates to GitHub...\033[0m\n"
cd docs && rm -rf * 
cd ..
cp CNAME docs
cd _hugo
# Build the project.
hugo -t reveal-hugo # if using a theme, replace with `hugo -t <YOURTHEME>`

# Go To Public folder
mv public/* ../docs

# Add changes to git.
git add -A

# Commit changes.
msg="rebuilding site $(date)"
if [ -n "$*" ]; then
	msg="$*"
fi
git commit -m "$msg"

# Push source and build repos.
# git push origin master
git push -f origin master