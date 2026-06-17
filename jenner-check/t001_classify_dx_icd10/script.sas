/*********************************************
* Jenner compatibility bundle: classify_dx on ICD-10 codes
*
* Exercises the classify_dx macro (classify_dx.sas) against a small
* sample of real ICD-10 diagnosis codes drawn from do_want.col, one
* per body system. The caller mirrors the do_it pattern in
* test_classify_dx.sas: strip decimals, call the classifier, derive
* body_system via the bodsys. format, count involved systems.
*
* The do_want.col data is inlined here as DATALINES so the bundle is
* self-contained; the external libname "s" and the absolute &root path
* from test_classify_dx.sas are not needed.
*********************************************/

/* Sampled keep-list rows in the same layout as do_want.col:
   dx, body system, progressive flag, description. */
data do_want ;
  input
    @1    dx          $char8.
    @11   bs_wanted   $char21.
    @33   prog_wanted $char3.
    @37   description $char70.
  ;
  dx_codetype = '10' ;
  datalines ;
G93.42    genetic               no  megaloencephalic leukoencephalopathy
T66.XXXS  malignancy            n/a Radiation sickness, unspecified, sequela
Z92.25    immunological         no  Personal history of immunosupression therapy
D57.03    hematological         yes Hb-SS disease with cerebral vascular involvement
E11.10    endocrinological      no  Type 2 diabetes mellitus with ketoacidosis
E70.81    metabolic             yes Aromatic L-amino acid decarboxylase deficiency
G11.10    neurological          yes Early-onset cerebellar ataxia, unspecified
G71.00    musculoskeletal       yes Muscular dystrophy, unspecified
H81.4     otologic              no  Vertigo of central origin
I27.20    cardiac               yes Pulmonary hypertension, unspecified
J84.170   pulmonary/respiratory yes Interstitial lung disease, progressive fibrotic
K74.00    gastrointestinal      yes Hepatic fibrosis, unspecified
N02.A     renal                 yes Recurrent hematuria with C3 glomerulonephritis
N35.811   genitourinary         no  Other urethral stricture, male, meatal
F32.A     mental health         no  Depression, unspecified
Z87.730   craniofacial          no  History of corrected cleft lip and palate
;
run ;

/* Classify each code: strip the decimal, run the ICD-10 branch of the
   classifier, then roll the 19 body-system flags up to a label. */
data classified ;
  set do_want ;
  dx_nodecimal = upcase(compress(dx, '.')) ;
  %classify_dx(dx_varname = dx_nodecimal, dx_codetype = 10) ;
  body_system = put(whichn(1, cardiac, cranio, derm, endo, gastro, genetic,
                            genito, hemato, immuno, malign, mh, metab,
                            musculo, neuro, opthal, otol, otolar, pulresp,
                            renal), bodsys.) ;
  num_systems = sum(0, cardiac, cranio, derm, endo, gastro, genetic, genito,
                       hemato, immuno, malign, metab, mh, musculo, neuro,
                       opthal, otol, otolar, pulresp, renal) ;
  prog = put(progressive, bin.) ;
run ;

title "PMCA classify_dx ICD-10 classification of sampled do_want codes" ;
proc print data = classified noobs ;
  var dx dx_nodecimal body_system prog num_systems bs_wanted prog_wanted ;
run ;
title ;

/* A code the algorithm flags should land in exactly one body system. */
proc freq data = classified ;
  tables num_systems / nocum ;
run ;
