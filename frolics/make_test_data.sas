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
* options sastrace=',,,d' sastraceloc=saslog no$stsuffix ;

ods listing close ;

%include "&GHRIDW_ROOT/Sasdata/CRN_VDW/lib/StdVars.sas" ;
libname s "\\home.ghc.org\home$\pardre1\workingdata\pmca" ;
libname out "\\home.ghc.org\home$\pardre1\workingdata\pmca\output" ;
/*
%pmca(inset = s.test_kids, index_date = index_date, outset = out.vdw_mac_output, days_lookback = 365) ;

* Interim dset of diags created by the vdw pmca macro ;
data dx ;
  set dxes ;
  txt_enc_id = put(enc_id, $hex32.) ;
  drop enc_id ;
run ;

proc sort nodupkey data = dx ;
  by mrn txt_enc_id dx ;
run ;

proc transpose data = dx out = s.fake_claims (drop = _:) prefix = dx_ ;
  var dx ;
  by mrn txt_enc_id ;
run ;

endsas ;
*/

proc sort data = out.vdw_mac_output ;
  by mrn ;
run ;

proc sort data = out.results_pmca_32 ;
  by mrn ;
run ;

proc sort data = out.results_pmca_v3_1 ;
  by mrn ;
run ;

data out.comparison ;
  merge
    out.vdw_mac_output    (rename = (cond_less = vdw_cond_less cond_more = vdw_cond_more))
    out.results_pmca_v3_1 (rename = (cond_less = pmca_31_cond_less cond_more = pmca_31_cond_more))
    out.results_pmca_32   (rename = (cond_less = pmca_32_cond_less cond_more = pmca_32_cond_more))
  ;
  by mrn ;

  label
    vdw_cond_less    = "VDW-macro PMCA score using the LESS conservative algorithm"
    vdw_cond_more    = "VDW-macro PMCA score using the MORE conservative algorithm"
    pmca_31_cond_less = "Version 31 PMCA score using the LESS conservative algorithm"
    pmca_31_cond_more = "Version 31 PMCA score using the MORE conservative algorithm"
    pmca_32_cond_less = "Version 32 PMCA score using the LESS conservative algorithm"
    pmca_32_cond_more = "Version 32 PMCA score using the MORE conservative algorithm"
  ;

run ;

options orientation = landscape ;
ods graphics / height = 8in width = 10in ;

%let out_folder = %sysfunc(pathname(out)) ;

ods html5 path = "&out_folder" (URL=NONE)
         body   = "make_test_data.html"
         (title = "make_test_data output")
         style = magnify
         nogfootnote
         device = svg
         /* options(svg_mode="embed") */
          ;

  proc freq data = out.comparison order = freq ;
    tables pmca_31_cond_less * pmca_32_cond_less / missing format = comma9.0 ;
    tables pmca_31_cond_more * pmca_32_cond_more / missing format = comma9.0 ;
  run ;

run ;

ods _all_ close ;

