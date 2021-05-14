/*********************************************
* Roy Pardee
* KP Washington Health Research Institute
* (206) 287-2078
* roy.e.pardee@kp.org
*
* C:\Users/o578092/Documents/vdw/pmca/frolics/make_test_data.sas
*
* Makes some sort-of-claims-shaped data to feed into the main pmca program to
* make sure I havent entirely broken it.
*********************************************/

%include "h:/SAS/Scripts/remoteactivate.sas" ;

options
  linesize  = 150
  pagesize  = 80
  msglevel  = i
  formchar  = '|-++++++++++=|-/|<>*'
  dsoptions = note2err
  nocenter
  noovp
  nosqlremerge
  extendobscounter = no
;

* For detailed database traffic: ;
options sastrace=',,,d' sastraceloc=saslog no$stsuffix ;

ods listing close ;

%include "&GHRIDW_ROOT/Sasdata/CRN_VDW/lib/StdVars.sas" ;
libname s "\\home.ghc.org\home$\pardre1\workingdata\pmca" ;
/*
proc sql outobs = 3000 ;
  create table s.raw_dx as
  select d.*
  from &_vdw_dx as d INNER JOIN
    &_vdw_demographic as dem on d.mrn = dem.mrn
  where year(d.adate) - year(dem.birth_date) le 18
  order by d.enc_id, d.dx
  ;
quit ;
*/

data dx ;
  set s.raw_dx ;
  txt_enc_id = put(enc_id, $hex32.) ;
run ;

proc sort nodupkey data = dx ;
  by mrn txt_enc_id dx ;
run ;

proc transpose data = dx out = s.fake_claims (drop = _:) prefix = dx_ ;
  var dx ;
  by mrn txt_enc_id ;
run ;

