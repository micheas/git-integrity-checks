#!/bin/bash
# Written by Micheas Herman <https://github.com/micheas>

BASE_DIR=/var/www/cart;
 
BASE_TAG=shop-yliving-com;
if [ $1 ]
then
  BASE_TAG=$1;
fi

# Check if the repository has been polluted
REPOSITORY_STATUS=$(bash git-status-check.sh $BASE_DIR);
if [ $REPOSITORY_STATUS -ne 'Repository ok!' ]
then
  echo $REPOSITORY_STATUS > /dev/stderr;
  exit 1;
fi


# Check if the repo has appropriately set base tags

TAG_SEPARATOR='-';
NF=$(echo ${BASE_TAG} | awk -F "${TAG_SEPARATOR}" "{print(NF + 1)}");

LATEST_TAG=$(git tag | \
  grep $BASE_TAG | \
  awk -F "${TAG_SEPARATOR}" \
    "BEGIN {max = 0} {if (\$$NF>max && NF == $NF) max=\$$NF} END {print \"${BASE_TAG}-\" max}");
 
REPOSITORY_STATUS=$(git status | grep "HEAD detached at ${LATEST_TAG}" | wc -l);
 
if [ ${REPOSITORY_STATUS} != 1 ]
then
  echo "Not on latest Release tag. Manual intervention required" > /dev/stderr;
  git status > /dev/stderr;
  exit 1;
fi
 
exit 0;
