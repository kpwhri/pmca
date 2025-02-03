/*********************************************
* Roy Pardee
* KP Washington Health Research Institute
* (206) 287-2078
* roy.e.pardee@kp.org
*
* C:\Users/o578092/Documents/vdw/pmca/frolics/generate_lookups.sas
*
* Uses the many if-statements of pmca.sas to try and generate a
* lookup dataset of dx codes from OMOP-distributed reference data.
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
%include "\\ghcmaster.ghc.org\ghri\Warehouse\management\Workspace\pardre1\pmca\classify_dx.sas" ;

libname s "\\home.ghc.org\home$\pardre1\workingdata\pmca" ;


%macro get_raw(outset = ) ;
  %include "&GHRIDW_ROOT/Sasdata/CRN_VDW/lib/StdVars.sas" ;

  proc sql ;
    * w/out distinct n=113,202. Same with distinct. ;
    create table &outset as
    select upcase(code) as dx length = 12
      , upcase(compress(code, '.')) as dx_nodecimal length = 12
      , case code_type when 'ICD10CM' then '10' when 'ICD9CM' then '09' else '??' end as dx_codetype
      , code_source length = 12 format = $12. informat = $12.
      , code_desc length = 300 format = $300. informat = $300.
    from &_rcm_vdw_codebucket
    where code_type in ('ICD10CM', 'ICD9CM')
    order by code, code_type
    ;
    create table s.duped_dx_codes as
    select r.*
    from &outset as r INNER JOIN
        (select dx, dx_codetype from &outset
          group by dx, dx_codetype
          having count(*) > 1) as d on r.dx = d.dx and r.dx_codetype = d.dx_codetype
    order by r.dx
    ;

    * supplement with any wanted codes that dont appear in &_rcm_vdw_codebucket ;
    create table supp_wanted as
    select w.dx length = 12
      , upcase(compress(w.dx, '.')) as dx_nodecimal length = 12
      , w.dx_codetype
      , 'Rita M-S' as code_source length = 12
      , w.description as code_desc length = 300
    from s.do_want as w
      left join &outset as o on w.dx = o.dx and w.dx_codetype = o.dx_codetype
    where o.dx is null
    ;

  quit ;

  proc append base = &outset data = supp_wanted ;
  run ;

  * Found some dupes in the icd10 diags--differences in casing & description. Lets ditch those ;
  proc sort nodupkey data = &outset ;
    by dx dx_codetype ;
  run ;
  proc sql ;
    alter table s.raw_dx_codes add primary key (dx, dx_codetype) ;
  quit ;

%mend get_raw ;

%macro generate_lookup(inset = , outset = , dx_varname = code, dx_codetype = 09) ;
  data &outset ;
    set &inset ;
    %classify_dx(dx_varname = &dx_varname, dx_codetype = &dx_codetype) ;
    which_flag = whichn(1
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
            , mh
            , metab
            , musculo
            , neuro
            , opthal
            , otol
            , otolar
            , pulresp
            , renal) ;

    body_system = put(which_flag, bodsys.) ;
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

%mend generate_lookup ;


%get_raw(outset = s.raw_dx_codes) ;

%generate_lookup(inset = s.raw_dx_codes (where = (dx_codetype = '09')), dx_varname = dx_nodecimal, dx_codetype = 09, outset = s.icd09_lookup) ;
%generate_lookup(inset = s.raw_dx_codes (where = (dx_codetype = '10')), dx_varname = dx_nodecimal, dx_codetype = 10, outset = s.icd10_lookup) ;

ods _all_ close ;

ods excel file="%sysfunc(pathname(s))/pmca_dx_code_lists.xlsx"
    style=htmlblue
    options(orientation         = 'landscape'
            SHEET_NAME          = 'icd-9'
            embedded_titles     = 'no'
            frozen_headers      = 'yes'
            gridlines           = 'yes'
            page_order_across   = 'yes'
            contents            = 'no'
            gridlines           = 'yes'
            sheet_interval      = 'proc'
            )
  ;

  proc print data = s.icd09_lookup ;
    var dx_nodecimal code_desc body_system progressive ;
    format dx $12. progressive bin. ;
    id dx ;
  run ;

  ods excel options(sheet_name="icd-10");

  proc print data = s.icd10_lookup ;
    var dx_nodecimal code_desc body_system progressive ;
    format dx $12. progressive bin. ;
    id dx ;
  run ;

ods excel close ;

endsas ;
/*

data gnu ;
  length dx $ 12 ;
  set s.web_icd10_list ;
  dx = upcase(compress(icd_10_code, '.', 'kn')) ;
  web_progressive = lowcase(progressive) ;
  web_body_system = left(compress(body_system, '/', 'ka')) ;
  drop progressive icd_10_code body_system ;
run ;

proc sort nodupkey data = gnu ;
  by dx ;
run ;

data s.icd_10_compare ;
  merge
    gnu (in  = w)
    s.icd10_lookup (in = o)
  ;
  by dx ;
  in_omop  = put(o, bin.) ;
  in_webxl = put(w, bin.) ;
  code_progressive = put(max(progressive, 0), bin.) ;
  code_body_system = left(compress(body_system, '/', 'ka')) ;
  drop progressive dx_codetype code_source body_system ;
run ;
*/

options orientation = landscape ;
ods graphics / height = 8in width = 10in ;

* %let out_folder = /C/Users/o578092/Documents/vdw/pmca/frolics/ ;
%let out_folder = %sysfunc(pathname(s)) ;

ods html5 path = "&out_folder" (URL=NONE)
         body   = "pmca_icd10_audit.html"
         (title = "PMCA: Comparing ICD-10 Codes")
         style = magnify
         nogfootnote
         device = svg
          ;

* ods word file = "&out_folder.generate_lookups.docx" ;

  title1 "Comparing ICD-10 Code lists: Web Download vs. what the SAS code does to OMOP's lookup" ;
  proc sql number ;
    create table missing_from_omop as
    select c.dx, c.web_body_system, c.description, case when b.code is null then 'yes' else 'no' end as possible_code_problem
    from s.icd_10_compare as c
      left join &_rcm_vdw_codebucket as b on c.dx = b.code
    where c.in_webxl = 'yes' and c.in_omop = 'no'
    ;

    title2 "These Codes are in the Web Download but not OMOP (as selected by the PMCA code)" ;
    select *
    from missing_from_omop
    order by web_body_system, dx
    ;

    title2 "Codes disagreeing on body system" ;
    select dx, web_body_system, code_body_system, description
    from s.icd_10_compare
    where in_webxl = 'yes' and in_omop = 'yes' and web_body_system ne code_body_system
    order by web_body_system, dx
    ;

    title2 "Codes disagreeing on progressive-ness" ;
    select dx, web_progressive, code_progressive, description
    from s.icd_10_compare
    where in_webxl = 'yes' and in_omop = 'yes' and web_progressive ne code_progressive and web_progressive ne 'n/a'
    order by dx
    ;

    title2 "These Codes are in OMOP (as selected by the PMCA code) but not the Web Download" ;
    create table s.possibly_missing_10s as
    select i.dx, i.code_body_system, i.code_desc, count(distinct d.enc_id) as num_encounters format = comma9.0 label = "No. encounters in KPWA featuring this dx (over all time)"
    from s.icd_10_compare as i
      LEFT JOIN &_vdw_dx as d on i.dx = d.dx and d.dx_codetype = '10'
    where i.in_webxl = 'no' and i.in_omop = 'yes'
    group by i.dx, i.code_body_system, i.code_desc
    ;
    select i.*
    from s.possibly_missing_10s as i
    order by i.num_encounters desc, i.code_body_system, i.dx
    ;
  quit ;


run ;

ods _all_ close ;


ods excel file="%sysfunc(pathname(s))/possibly_missing_10s.xlsx"
    style=htmlblue
    options(orientation         = 'landscape'
            SHEET_NAME          = 'ICD-10'
            embedded_titles     = 'no'
            frozen_headers      = 'yes'
            gridlines           = 'yes'
            page_order_across   = 'yes'
            contents            = 'no'
            gridlines           = 'yes'
            sheet_interval      = 'proc'
            )
  ;


  proc print data = s.possibly_missing_10s ;
  run ;

ods excel close ;
