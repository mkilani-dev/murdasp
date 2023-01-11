BEGIN {
  FS=";";
  th1 = 0.0100;
  th2 = 0.0200;
  th3 = 0.0350;
  th4 = 0.0500;
  tot_inf = 0;
}



NR == FNR {
  home[$1] = 1;
  next;
}


!/[0-9]{15}/ {
  print $1";"0";"0;
  next;
}

{
  addr=substr($1,0,18)"";
}

home[addr] != 1 {
  print $1";"0";"0;
  next;
}


{
  p = rand();
}

p <= th1 && tot_inf <= s {
  print $1";"1";"0;
  tot_inf += 1;
  next;
}

p <= th2 && tot_inf <= s {
  print $1";"2";"0;
  tot_inf += 1;
  next;
}
  
p <= th3 && tot_inf <= s {
  print $1";"3";"1;
  tot_inf += 1;
  next;
}

p <= th4 && tot_inf <= s {
  print $1";"4";"1;
  tot_inf += 1;
  next;
}

{
  print $1";"0";"0;
}


