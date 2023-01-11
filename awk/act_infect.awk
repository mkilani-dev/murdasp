BEGIN{
  FS=";";
}

FNR == NR {
  s[$1] = $3;
# print $1, s[$1], $2, FNR, NR;
  next;
}


/===/ {
  n = 0;
  n_infect = 0;
  print $0;
  next;
}

$2=="+" {
  n += 1;
  n_infect += s[$5];
  display()
}

$2=="-" {
  n -= 1;
  n_infect -= s[$5];
  display()
}


function display() {
    print $1 FS $2 FS $3 FS $4 FS $5 FS n FS s[$5] FS n_infect;
  }

