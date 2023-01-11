BEGIN {
  FS=";";
}

(NR == FNR) && ($2 == 0) {
  print $0;
  next;
}

(NR == FNR) && ($2 >= 2) && ($2 <= 6) {
  print $1 FS 1+$2 FS 1;
  next;
}

(NR == FNR) {
  print $1 FS 1+$2 FS 0;
  next;
}

{
  print $3 FS 1 FS 0;
}


