#!/bin/bash
# Written by Micheas Herman <https://github.com/micheas>

BASE_DIR=/var/www/cart;
 
BASE_TAG=shop-yliving-com;
if [ $1 ]
then
  BASE_TAG=$1;
fi
 
TAG_SEPARATOR='-';
 
cd $BASE_DIR;
 
NF=$(echo ${BASE_TAG} | awk -F "${TAG_SEPARATOR}" "{print(NF + 1)}");
 
REPOSITORY_STATUS=$(git status --porcelain | wc -l);
 
if [ ${REPOSITORY_STATUS} -gt 0 ]
then
  echo "Repository modified" > /dev/stderr;
  git status > /dev/stderr;
  exit 1;
fi
 
 
 
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
