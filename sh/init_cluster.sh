#!/bin/zsh

#OAR -l /core=2,walltime=01:00:00
#OAR -p host="orval17"
#OAR -n Epidemics
#OAR -q murdasp

# Create the initial infection picture for the first day

# Check if the number of arguments is correct
if [[ $# -ne 4 ]]
then
  echo "Incorrect number of arguments. Stoppping.."
  exit 0
fi


# AWK scripts 
awk_script1="awk/cluster.awk";
awk_script2="awk/init_infect_cluster.awk";

# Data files
ids_file="output/population/ids.csv";
xy_file="data/xy_facilities.csv";

# Created files
out_file="output/days-$1/stat_init-0.txt";
cluster_file="data/cluster-$1.csv";

# Check that there are no file containing the cluster.
#if [[ -f $cluster_file ]]
#then
#  echo "File $cluster_file exists; leaving..";
#  exit 0
#fi

# This command needs the X and Y coordinates 
# where the center of cluster is located
awk -f $awk_script1 -v X0=$2 -v Y0=$3 $xy_file > $cluster_file ;

# Check if the output file exists
#if [[ -f $out_file ]]
#then
#  echo "File $out_file exists; leaving..";
#  exit 0
#fi

if [[ ! -d "output/days-$1" ]]
then
  mkdir -p "output/days-$1";
fi

# Create the initial set of the infected in the population
awk -f $awk_script2 -v s=$4 $cluster_file $ids_file > $out_file

echo "Creating simulation for day 0"

sh/infections.sh $1 0 1 1 1 0.5 0.01 0.03 1 1 1 1
sh/day_update.sh $1 0



