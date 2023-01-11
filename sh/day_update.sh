#!/bin/zsh

#OAR -l /core=2,walltime=01:00:00
#OAR -p host="orval17"
#OAR -n Epidemics
#OAR -q murdasp

awk_script="awk/day_end.awk";
init_file="output/days-$1/stat_init-$2.txt";
end_file="output/days-$1/stat_end-$2.txt";
out_file="output/days-$1/day_end-$2.txt";

mawk -f $awk_script $init_file $end_file | sort -t ";" -k1,1 -k2,2r | awk -F";" '!_[$1]++' > $out_file



