#!/bin/bash
i=0
while IFS=$"\n" read -r line; do
    array[i]="${line}"
    ((++i))
done < "$1"
counter=0
position=0
while true; do
  ((counter++))
  offset=${array[${position}]}
  ((array[position]++))
position=$((position+offset))
  if [[ "$position" -ge ${#array[@]} ]];then
    echo "escaped!"
    break
  fi
done
echo "There are $counter steps needed."
