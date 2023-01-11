BEGIN {
  FS=";";
}

NR == 1 {
  next;
}

/===/ {
  t_old=0;
  split("",tab_i);
  split("",tab_ni);
  n_i = 0;
  n_ni = 0;
  next;
}


$2=="+" {
# print "entry",length(tab_ni), length(tab_i);
    for(i in tab_i) {
      for (j in tab_ni) {
        print $1 FS $1-t_old FS $4 FS tab_i[i] FS tab_ni[j] FS $3;
      }
    }

  if($7==0) {
    n_ni += 1;
    tab_ni[n_ni] = $5;
  } else {
    n_i += 1;
    tab_i[n_i]  = $5;
  }
  t_old = $1;
}

$2=="-" {
# print "exit",length(tab_ni), length(tab_i);
    for(i in tab_i) {
      for (j in tab_ni) {
        print $1 FS $1-t_old FS $4 FS tab_i[i] FS tab_ni[j] FS $3;
      }
    }

  if($7==0) {
     for(i in tab_ni) {
       if(tab_ni[i]==$5) {delete tab_ni[i];}
     }
  } else {
     for(i in tab_i) {
       if(tab_i[i]==$5) {delete tab_i[i];}
     }
  }
  t_old = $1;
}

