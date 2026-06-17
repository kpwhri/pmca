/*********************************************
* Jenner compatibility bundle: PMCA dx-list data-integrity checks
*
* Reproduces the PROC SQL validation block from test_classify_dx.sas
* that guards the do_want / dont_want code lists:
*   - codes appearing twice within a list (duped_do_wants)
*   - body-system labels outside the allowed vocabulary (bad_body_sys)
*   - codes that appear in BOTH the keep and drop lists (forbidden_overlap)
*
* Sample rows from do_want.col and dont_want.col are inlined here as
* DATALINES so the bundle is self-contained; the external libname "s"
* and the absolute &root path are not needed. The SQL logic is the
* same as test_classify_dx.sas.
*********************************************/

/* Codes that should be flagged for inclusion (keep list, do_want.col). */
data do_want ;
  input
    @1    dx          $char8.
    @11   bs_wanted   $char21.
    @33   prog_wanted $char3.
    @37   description $char60.
  ;
  dx_codetype = '10' ;
  datalines ;
G93.42    genetic               no  megaloencephalic leukoencephalopathy
T66.XXXS  malignancy            n/a Radiation sickness, unspecified, sequela
Z92.25    immunological         no  Personal history of immunosupression therapy
D57.03    hematological         yes Hb-SS disease with cerebral vascular involvement
E70.81    metabolic             yes Aromatic L-amino acid decarboxylase deficiency
G11.10    neurological          yes Early-onset cerebellar ataxia, unspecified
I27.20    cardiac               yes Pulmonary hypertension, unspecified
K74.00    gastrointestinal      yes Hepatic fibrosis, unspecified
N02.A     renal                 yes Recurrent hematuria with C3 glomerulonephritis
N35.811   genitourinary         no  Other urethral stricture, male, meatal
;
run ;

/* Codes that should NOT be flagged (drop list, dont_want.col). */
data dont_want ;
  input
    @1    dx          $char8.
    @11   bs_wanted   $char21.
    @33   description $char60.
  ;
  dx_codetype = '10' ;
  datalines ;
H57.1     ophthalmological      Ocular pain
H57.11    ophthalmological      Ocular pain, right eye
I82.2     cardiac               Embolism and thrombosis of vena cava
I82.21    cardiac               Embolism and thrombosis of superior vena cava
M24.4     musculoskeletal       Recurrent dislocation of joint
M24.41    musculoskeletal       Recurrent dislocation, shoulder
R51       neurological          Headache
R10.0     gastrointestinal      Acute abdomen
;
run ;

/* The controlled vocabulary of body systems, from test_classify_dx.sas. */
%let allowed_bodysys = %str('cardiac'
                , 'craniofacial'
                , 'dermatological'
                , 'endocrinological'
                , 'gastrointestinal'
                , 'genetic'
                , 'genitourinary'
                , 'hematological'
                , 'immunological'
                , 'malignancy'
                , 'mental health'
                , 'metabolic'
                , 'musculoskeletal'
                , 'neurological'
                , 'ophthalmological'
                , 'otologic'
                , 'otolaryngological'
                , 'pulmonary/respiratory'
                , 'renal') ;

proc sql ;
  /* Any code listed more than once in the keep list. */
  create table duped_do_wants as
  select d.*
  from do_want as d
    inner join (select dx from do_want group by dx having count(*) > 1) as dd
      on d.dx = dd.dx
  order by d.dx
  ;

  /* Any keep-list row whose body system is outside the vocabulary.
     strip() trims the fixed-width $char21. field before the lookup. */
  create table bad_body_sys as
  select dx, bs_wanted
  from do_want
  where strip(bs_wanted) not in (&allowed_bodysys)
  ;

  /* Any code that is in BOTH the keep list and the drop list. */
  create table forbidden_overlap as
  select n.dx, n.bs_wanted as drop_system, w.bs_wanted as keep_system
  from dont_want as n
     inner join do_want as w on n.dx = w.dx
  ;

  title "Codes appearing twice in the keep list (expect 0)" ;
  select count(*) as duped_keep_codes from duped_do_wants ;

  title "Keep-list codes with an out-of-vocabulary body system (expect 0)" ;
  select count(*) as bad_body_systems from bad_body_sys ;

  title "Codes in both the keep and drop lists (expect 0)" ;
  select count(*) as forbidden_overlaps from forbidden_overlap ;
quit ;
title ;

/* Summarize the validated keep list by body system. */
title "Keep-list sample distribution by body system" ;
proc freq data = do_want order = freq ;
  tables bs_wanted / nocum nopercent ;
run ;
title ;
