BEGIN {
  FS=";"
  male=0;
  female=0;
}

NR == FNR && NR > 1 {
  code=$2""$3""$4"_"$9;
  gender[code]=$10;
  weight[code]=$35;
# print code, sexe[code];
  switch($18) {
       case "010":
         act_type[code]=10;
         break
       case "020":
         act_type[code]=20;
         break
       case "021":
         act_type[code]=21;
         break
       case "022":
         act_type[code]=22;
         break
       case "023":
         act_type[code]=23;
         break
       case "030":
         act_type[code]=30;
         break
       case "031":
         act_type[code]=31;
         break
       case "032":
         act_type[code]=32;
         break
       case "036":
         act_type[code]=36;
         break
       case "040":
         act_type[code]=40;
         break
       case "041":
         act_type[code]=41;
         break
       case "046":
         act_type[code]=46;
         break
       case "047":
         act_type[code]=47;
         break
       case "048":
         act_type[code]=48;
         break
       case "050":
         act_type[code]=50;
         break
       case "051":
         act_type[code]=51;
         break
       case "054":
         act_type[code]=54;
         break
       case "055":
         act_type[code]=55;
         break
       case "056":
         act_type[code]=56;
         break
       case "060":
         act_type[code]=60;
         break
       case "061":
         act_type[code]=61;
         break
       case "066":
         act_type[code]=66;
         break
       case "069":
         act_type[code]=69;
         break
       case "070":
         act_type[code]=70;
         break
       case "080":
         act_type[code]=80;
         break
       case "081":
         act_type[code]=81;
         break
       case "082":
         act_type[code]=82;
         break
       case "083":
         act_type[code]=83;
         break
       case "084":
         act_type[code]=84;
         break
       case "085":
         act_type[code]=85;
         break
       case "086":
         act_type[code]=86;
         break
       case "087":
         act_type[code]=87;
         break
       case "088":
         act_type[code]=88;
         break
       case "089":
         act_type[code]=89;
         break
       case "090":
         act_type[code]=90;
         break
    }

  next;
} 

$2 >= 1 {
  str1=substr($1,1,15);
  str2=substr($1,19,2);
  indiv=str1"_"str2;
  s = gender[indiv];
  if(s!="") {
    if(s=="1") {male   += weight[indiv];}
    if(s=="2") {female += weight[indiv];}
#   print  male,  female, weight[indiv];
  }
}

END {
  tot=male+female;
  print "Male: ", male,"("male/tot*100" %)", "Female: " female,"("female/tot*100" %)";
}




