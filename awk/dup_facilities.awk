BEGIN {
  FS=";";
}

NR == 1 {
  count=0;
  v = 1;
  next;
}


/===/ {
  prn(fac,count);
  count=0;
  v = 1;
  next;
}

v == 1 {
  v = 0;
  fac = $4;
}

{
  count++;
}

END {
  prn(fac,count);
}

function prn(f, n) {
  nn = 1+int(n/th);
  print f";"n";"nn;
}

