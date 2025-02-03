/*********************************************
* Roy Pardee
* KP Washington Health Research Institute
* (206) 287-2078
* roy.e.pardee@kp.org
*
* C:\Users/o578092/Documents/vdw/pmca/test_classify_dx.sas
*
* Tests the classify_dx macro against cherry-picked datasets of diags
* that we know we do/dont want to affect the PMCA score.
*********************************************/

* %include "h:/SAS/Scripts/remoteactivate.sas" ;

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

%let root = \\ghcmaster.ghc.org\ghri\Warehouse\management\Workspace\pardre1\pmca ;

libname s "\\home.ghc.org\home$\pardre1\workingdata\pmca" ;
%include "&root\classify_dx.sas" ;

data gnu ;
  ** infile "\\server\share\my_data.txt" ;
  input
    @1    ndc         $char11.
    @12   drug_name   $char40.
  ;
  infile datalines truncover ;
datalines ;
blah
run ;


* These are diagnoses that currently get flagged for inclusion, but should not. ;
* Also, diags that were considered for adding, but decided against. ;
data s.dont_want ;
  infile "&root\dont_want.col" truncover ;
  input
    @1    dx          $char8.
    @11   bs_wanted   $char21.
    @33   description $char61.
  ;
  dx_codetype = '10' ;
run ;

* These are the new codes we are adding ;
data s.do_want ;
  infile "&root\do_want.col" truncover ;
  input
    @1    dx          $char8.
    @11   bs_wanted   $char21.
    @33   prog_wanted $char3.
    @37   description $char70.
  ;
  dx_codetype = '10' ;
run ;

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
  create table s.duped_dont_wants as
  select d.*
  from s.dont_want as d
    inner join (select dx from s.dont_want group by dx having count(*) > 1) as dd on d.dx = dd.dx
  order by d.dx
  ;

  create table s.duped_do_wants as
  select d.*
  from s.do_want as d
    inner join (select dx from s.do_want group by dx having count(*) > 1) as dd on d.dx = dd.dx
  order by d.dx
  ;

  create table s.bad_body_sys as
  select *
  from s.do_want
  where bs_wanted not in (&allowed_bodysys)
  ;

  alter table s.dont_want add primary key (dx) ;
  alter table s.do_want add primary key (dx) ;
  alter table s.do_want add constraint body_sys
    check (bs_wanted in (&allowed_bodysys)
          )
  ;

  create table s.forbidden_overlap as
  select n.*
  from s.dont_want as n
     inner join s.do_want as w on n.dx = w.dx
  ;
  %if &sqlobs > 0 %then %do ;
    %put ERROR: do_want and dont_want share some codes!!! ;
  %end ;
quit ;

%macro do_it(dset) ;
  data &dset._test ;
    set &dset ;
    dx_nodecimal = upcase(compress(dx, '.')) ;
    %classify_dx(dx_varname = dx_nodecimal, dx_codetype = 10) ;
      body_system = put(whichn(1, cardiac, cranio, derm, endo, gastro, genetic, genito, hemato, immuno, malign, mh, metab, musculo, neuro, opthal, otol, otolar, pulresp, renal), bodsys.) ;
      num_systems = sum(0
                      , cardiac
                      , cranio
                      , derm
                      , endo
                      , gastro
                      , genetic
                      , genito
                      , hemato
                      , immuno
                      , malign
                      , metab
                      , mh
                      , musculo
                      , neuro
                      , opthal
                      , otol
                      , otolar
                      , pulresp
                      , renal)
      ;
      if num_systems > 0 then output ;
  run ;
%mend do_it ;

%do_it(dset = s.dont_want) ;
%do_it(dset = s.do_want) ;
%do_it(dset = s.not_sure_yet) ;

proc sql ;
  create table s.to_be_added as
  select n.*, t.body_system, t.progressive, (not t.dx is null) as already_included
  from s.do_want as n
    left join s.do_want_test as t on n.dx = t.dx
  where t.dx is null
  order by n.dx
  ;

  create table s.added_codes as
  select n.*, t.body_system, t.progressive
  from s.do_want as n
    left join s.do_want_test as t on n.dx = t.dx
  ;
quit ;

options orientation = landscape ;
ods graphics / height = 8in width = 10in ;

%let out_folder = %sysfunc(pathname(s)) ;

ods html5 path = "&out_folder" (URL=NONE)
         body   = "test_classify_dx.html"
         (title = "test_classify_dx output")
         style = magnify
         nogfootnote
         device = svg
         /* options(svg_mode="embed") */
          ;

  proc sql number ;
    title1 "These codes are not currently detected, and so need to be added" ;
    select dx, bs_wanted, prog_wanted, description
    from s.to_be_added
    where not already_included
    order by bs_wanted, dx
    ;

    title1 "These codes are NOT wanted but ARE being detected, so need to be removed" ;
    select dx, bs_wanted, body_system, progressive, description
    from s.dont_want_test
    order by bs_wanted, dx
    ;

    title1 "These codes are detected, but are being assigned to the wrong body system" ;
    select dx, body_system as bs_assigned, bs_wanted as bs_should_be, prog_wanted, description
    from s.added_codes
    where body_system is not null and body_system ne bs_wanted
    ;

    title1 "These codes are currently detected, but are getting a bad progressive value " ;
    select dx, body_system as bs_assigned, bs_wanted as bs_should_be, progressive, prog_wanted, description
    from s.added_codes
    where progressive is not null and progressive ne (prog_wanted = 'yes')
    ;

  quit ;
run ;

* proc freq data = s.do_want order = freq ;
*   tables bs_wanted * prog_wanted / missing format = comma9.0 ;
* run ;

ods _all_ close ;

