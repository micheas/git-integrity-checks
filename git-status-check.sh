#!/bin/bash
# Bash script that runs 'git status' and returns if somebody was bad and
# modified the code on production when they weren't supposed to. This is
# designed to be use to help monitor production for inappropriate changes or
# discrepencies to allow more predictability when pushing a release out (since
# git merge failures can cause serious problems when deploying a new release).

BASE_DIR=/var/www/cart;

# Require a base directory to be entered.
if [ $1 ]
then
  BASE_DIR=$1;
else
  echo "Please enter a base directory" > /dev/stderr;
  exit 1;
fi

cd $BASE_DIR;

# Run 'git status' and print how many lines it printed out. If there is more
# than one line, then the repo must've been modified inappropriately.
REPOSITORY_STATUS=$(git status --porcelain | wc -l);

if [ ${REPOSITORY_STATUS} -gt 0 ]
then
  echo "Repository modified" > /dev/stderr;
  git status > /dev/stderr;
  exit 1;
else
  echo "Repository ok!";
  exit;
fi
