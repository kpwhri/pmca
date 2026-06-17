/*********************************************
* Jenner compatibility bundle: classify_dx on ICD-9 codes
*
* Exercises the ICD-9 branch of the classify_dx macro
* (classify_dx.sas, the dx_codetype = 09 path). The diagnosis codes
* below are real ICD-9 codes drawn directly from the if-then lists in
* that branch (e.g. 250 -> endocrine, 042 -> immunological/progressive,
* 410 -> cardiac/progressive, 749 -> craniofacial).
*
* The caller follows the do_it pattern from test_classify_dx.sas:
* normalize the code, call the classifier with dx_codetype = 09,
* derive body_system via the bodsys. format, and count systems.
*********************************************/

/* A spread of ICD-9 diagnosis codes the algorithm is designed to flag,
   one per body system, with the body system its if-then list assigns. */
data icd9_codes ;
  input @1 dx $char6. @8 expected_system $char22. ;
  datalines ;
0103   pulmonary/respiratory
0420   immunological
1359   immunological
1629   malignancy
2500   endocrinological
2770   pulmonary/respiratory
2810   hematological
2950   mental health
3430   neurological
4100   cardiac
4240   cardiac
4930   pulmonary/respiratory
5810   renal
7100   immunological
7490   craniofacial
V08    immunological
;
run ;

/* Normalize the code the same way test_classify_dx.sas does, then run
   the ICD-9 branch of the classifier. */
data classified ;
  set icd9_codes ;
  dx_nodecimal = upcase(compress(dx, '.')) ;
  %classify_dx(dx_varname = dx_nodecimal, dx_codetype = 09) ;
  body_system = put(whichn(1, cardiac, cranio, derm, endo, gastro, genetic,
                            genito, hemato, immuno, malign, mh, metab,
                            musculo, neuro, opthal, otol, otolar, pulresp,
                            renal), bodsys.) ;
  num_systems = sum(0, cardiac, cranio, derm, endo, gastro, genetic, genito,
                       hemato, immuno, malign, metab, mh, musculo, neuro,
                       opthal, otol, otolar, pulresp, renal) ;
  prog = put(progressive, bin.) ;
run ;

title "PMCA classify_dx ICD-9 classification" ;
proc print data = classified noobs ;
  var dx dx_nodecimal body_system prog num_systems expected_system ;
run ;
title ;

/* Tabulate how the ICD-9 codes distribute across body systems. */
proc freq data = classified ;
  tables body_system / nocum nopercent ;
run ;
