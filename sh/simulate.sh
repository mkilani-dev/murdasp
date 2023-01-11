#!/bin/zsh

#OAR -l /core=1,walltime=12:00:00
#OAR -p host="orval15"
#OAR -n Epidemics
#OAR -q murdasp

# This scripts simulates the pandemic for a given
# number of days (passed as an argument).
# 
# Created: April 2022
# Last update: September 2022

x0=$13;
y0=$14;
n_max=$15;

sh/init_cluster.sh $1 $x0 $y0 $n_max

sh_infect="sh/infections.sh"
sh_update="sh/day_update.sh"

wd_dir="output/days-$1";

info_file=$wd_dir"/params.txt";

echo  "p_work=$3"       > $info_file;
echo  "p_leisure=$4"   >> $info_file;
echo  "p_shop=$5"      >> $info_file;
echo  "p_education=$6" >> $info_file;
echo  "p_primary=$7"   >> $info_file;
echo  "p_home=$8"      >> $info_file;
echo  "p_bus=$9"       >> $info_file;
echo  "p_tram=$10"     >> $info_file;
echo  "p_rail=$11"     >> $info_file;
echo  "p_subway=$12"   >> $info_file;

if [ -f "$wd_dir/stat_init-1.txt" ];
then
  echo "Simulation already started here. Existing.."
  exit 0
fi



n=$2;

for i in {1..$n}
do
  echo "==============================="
  echo "  PROCESSING DAY $i -- START   "
  echo "==============================="
  (( j = $i - 1 ))
  in_file="$wd_dir/day_end-$j.txt"
  init_file="$wd_dir/stat_init-$i.txt"
  if [ ! -f $in_file ] 
  then
    echo "File $in_file does not exist; exiting"
    exit 0
  fi
# cp $in_file $init_file
  ln $in_file $init_file
  $sh_infect $1 $i $3 $4 $5 $6 $7 $8 $9 $10 $11 $12
  $sh_update $1 $i
  echo "-------------------------------"
  echo "  PROCESSING DAY $i -- END     "
  echo "-------------------------------"
done




