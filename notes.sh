#!/bin/sh
###################
# INSTRUCTIONS
#
# You should create data folder by doing
#   1. create gist on https://gist.github.com
#   2. git clone {gits_clone_url} data
#   3. correcting DATA_PATH to your "data" folder path
#
# After that you can add notes.sh to your path or alias
#

DATA_PATH="/home/tinej/Programs/notes/data"

echo "Opening notes..."

# Change dir
cd $DATA_PATH

# Get latest version
git pull &> /dev/null

# Start vim
vim *

echo "Saving changes..."

# Commit
git add . > /dev/null
git commit -m "pushing note" > /dev/null

# Push changes
git push &> /dev/null
