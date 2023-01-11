BEGIN {
  tau0 = 0;
  theta = 0.000005;
  FS=";";
# p_work = 1;
# p_leisure = 1;
# p_shop = 1;
# p_education = .5;
# p_primary = .001;
# p_home = .3;
# p_bus = 1;
# p_tram = 1;
# p_rail = 1;
# p_subway = 1;
# print "MZMK", p_work, p_primary, p_shop, p_tram, p_rail;
}

#NR = FNR {
#  s[$1]=$2;
#  next;
#}


{
  p = 1 - exp(-theta*($2-tau0));
}

/work/ {
  if( rand() < p_work * p) {infect();}
}

/leisure/ {
  if( rand() < p_leisure * p) {infect();}
}

/primary/ {
  if( rand() < p_primary * p) {infect();}
}

/education/ {
  if( rand() < p_education * p) {infect();}
}

/home/ {
  if( rand() < p_home * p) {infect();}
}

/shop/ {
  if( rand() < p_shop * p) {infect();}
}

/bus/ {
  if( rand() < p_bus * p ) {infect();}
}

/rail/ {
  if( rand() < p_rail * p ) {infect();}
}

/subway/ {
  if( rand() < p_subway * p ) {infect();}
}

/tram/ {
  if( rand() < p_tram * p) {infect();}
}

function infect() {
    print $1 FS $4 FS $5 FS $3 FS $6;
}


