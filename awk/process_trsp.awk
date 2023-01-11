BEGIN {
  FS=";";
  start=0;
  eps=0.5;
  id="";
  t0="00000.0";
  tmax=7200;
}

$1 <= 1000 {
  next;
}

# With the new id, if the last id has ended with
# start on, then close it 
($3 != id) && start {
  print t";+;"id";"act_id";"typ;
  print t+tmax";-;"id";"act_id";"typ;
}

# If person is new, then initilize "t" and "start"
($3 != id ) {
  t = -10;
  start = 0;
}

# If the new id starts with and "actend"
# then open the activity early
($3 != id) && ($2 == "PersonLeavesVehicle") {
  print t0";+;"$3";"$4";"$5;
  print $1";-;"$3";"$4";"$5;
  id = $3;
  next;
}

/PersonEnters/ && ($1 >= t+eps) && !start {
  start = 1;
  t = $1;
  id = $3;
  act_id = $4;
  typ = $5;
  next;
}  

start && ($1 >= t+eps) {
 print t";+;"id";"act_id";"typ; 
 print $1";-;"id";"act_id";"typ; 
 t = $1
 start = 0;
}  



