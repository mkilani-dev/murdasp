#!/bin/zsh

#OAR -l /core=12,walltime=01:00:00
#OAR -p host="orval17"
#OAR -n Epidemics
#OAR -q murdasp

# Creates a file "ids.csv" that contains a list of all
# IDs found in the "events" file.

file_ids="output/population/ids.csv";
dir_ids="output/population";
file_events="data/output_events.xml.gz";

if [[ -f $file_ids ]]
then
  echo "File $file_ids exists; exiting !!" 
  exit 0 
fi

if [[ ! -d $dir_ids ]]
then
  echo "Directory $dir_ids does not exist; creating it !"
  mkdir -p $dir_ids
fi

zcat $file_events | \
  mawk -F'"' '/person/ {for(i=1;i<=NR-1;++i) {if($i ~ "person") {j=i+1; print $j;next;} } next; }' | \
  sort -u > $file_ids



