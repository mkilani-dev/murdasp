#!/bin/zsh

#OAR -l /core=2,walltime=01:00:00
#OAR -p host="orval17"
#OAR -n Epidemics
#OAR -q murdasp

wd_dir="output/days-$1/";
in_file="$wd_dir/stat_init-$2.txt";
out_file="$wd_dir/stat_end-$2.txt";
out_file_tmp="$wd_dir/stat_end_tmp-$2.txt";

if [ ! -f $in_file ]
then
  echo "There are no init file; leaving.."
  exit 0
fi

if [ -f $out_file ]
then
  echo "$out_file exists; deleting"
  rm $out_file
fi

if [ -f $out_file_tmp ]
then
  echo "$out_file_tmp exists; deleting"
  rm $out_file_tmp
fi

touch $out_file_tmp;

activities=("leisure" "shop" "home" "work" "education" "primary");
transport=("bus" "subway" "tram" "rail");

for act in $activities; do
  echo "Infections in activity $act" in day $2;
  act_file="output/interactions/$act.txt";
  mawk -f awk/act_infect.awk $in_file $act_file | \
    mawk -f awk/interact.awk | \
    mawk -f awk/infection.awk -v p_work=$3 \
                              -v p_leisure=$4 \
                              -v p_shop=$5 \
                              -v p_education=$6 \
                              -v p_primary=$7 \
                              -v p_home=$8 \
                              -v p_bus=$9 \
                              -v p_tram=$10 \
                              -v p_rail=$11 \
                              -v p_subway=$12 >> $out_file_tmp;
done

for trsp in $transport; do
  echo "Infections in transport $trsp" in day $2;
  trsp_file="output/interactions/$trsp.txt";
  mawk -f awk/act_infect.awk $in_file $trsp_file | \
    mawk -f awk/interact.awk | \
    mawk -f awk/infection.awk -v p_work=$3 \
                              -v p_leisure=$4 \
                              -v p_shop=$5 \
                              -v p_education=$6 \
                              -v p_primary=$7 \
                              -v p_home=$8 \
                              -v p_bus=$9 \
                              -v p_tram=$10 \
                              -v p_rail=$11 \
                              -v p_subway=$12 >> $out_file_tmp;
done

echo "Sorting with respect to time";
sort -t ";" -k1,1 $out_file_tmp > $out_file;
echo "done"

rm -f $out_file_tmp;

# Display some statistics
echo "All: "$(wc $out_file | awk '{print $1}');
for i in $activities; do
  echo "$i: "$(grep $i $out_file | wc | awk '{print $1}');
done

for i in $transport; do
  echo "$i: "$(grep $i $out_file | wc | awk '{print $1}');
done



