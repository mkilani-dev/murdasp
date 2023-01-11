#!/bin/zsh

#OAR -l /core=12,walltime=01:00:00
#OAR -p host="orval17"
#OAR -n Epidemics
#OAR -q murdasp

 
#events="data/output_events.xml.gz";
events="data/small.xml.gz";


activities=("leisure" "shop" "home" "work" "education" "primary");
transport=("bus" "subway" "tram" "rail");

file_inter="output/interactions";

if [[ -d "$file_inter" ]]
then
  echo "$file_inter directory exists; exiting"
  exit 0
fi

mkdir $file_inter

for act in $activities; do
  echo "Processing activity $act";
  file="output/interactions/"$act".txt";
  zcat $events | grep "actstart\|actend" | grep $act | \
    mawk -F'"' '{for(i=1;i<=NF;++i) {if($i ~ "actType=") {I=i+1;}} ; print $2 ";" $4 ";" $6 ";" $8 ";" $I}' | \
    sort -t ';' -k3,3 -k1,1 -k2,2r | mawk -f awk/process.awk | sort -t ";" -k4,4 -k1,1  | \
    mawk -F";" 'BEGIN{id="";} $4 != id {print "===";} {print $1";"$2";"$5";"$4";"$3; id=$4;}' > $file
done



for trsp in $transport; do
  echo "Processing transport mode $trsp";
  file="$file_inter/$trsp.txt";
  zcat $events | grep "PersonEnters\|PersonLeaves" | grep $trsp | \
    mawk -F'"' -v mode=$trsp '{print $2 ";" $4 ";" $6 ";" $8 ";" mode}' | \
    sort -t ';' -k3,3 -k1,1 -k2,2r | mawk -f awk/process_trsp.awk | sort -t ";" -k4,4 -k1,1  | \
    mawk -F";" 'BEGIN{id="";} $4 != id {print "===";} {print $1";"$2";"$5";"$4";"$3; id=$4;}' | \
    > $file
done



