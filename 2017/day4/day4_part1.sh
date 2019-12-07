#!/bin/bash
counter=0
while IFS='' read -r line || [[ -n "$line" ]]; do
  lines=$(echo "$line" | tr " " "\n"| sort | uniq -D)
  if [[ ! "$lines" ]];then
    ((counter++))
  fi
done < "$1"
echo "There are $counter valid passphrases"
