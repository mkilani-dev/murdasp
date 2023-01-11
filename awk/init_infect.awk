BEGIN {
  th1 = 0.002;
  th2 = 0.007;
  th3 = 0.012;
  th4 = 0.015;

  n1 = 0;
  n2 = 0;
  n3 = 0;
  n4 = 0;

  N = 0;
}

{
  p = 100 * rand();
  ++N;
}

p <= th1 {
  print $1";"1";"0;
  ++n1;
  next;
}

p <= th2 {
  print $1";"2";"0;
  ++n2;
  next;
}
  
p <= th3 {
  print $1";"3";"1;
  ++n3;
  next;
}

p <= th4 {
  print $1";"4";"1;
  ++n4;
  next;
}

{
  print $1";"0";"0;
}


#END {
#  print "n1 = "n1;
#  print "n2 = "n2;
#  print "n3 = "n3;
#  print "n4 = "n4;
#  print "N  = "N ;
#}

