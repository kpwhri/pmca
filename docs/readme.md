# Dx Code List & Other Files in /docs

There are 3 important files in this folder. All the rest are just added context and/or stuff that Rita or others sent me that I didn't want to lose track of. The important files are:

1. `pmca_dx_code_lists.xlsx` which is **descriptive** of the dxs the SAS code considers relevant.
2. `icd9_pmca_systems.xlsx`
3. `icd10_pmca_systems.xlsx`

The latter 2 there are actually **operative**--by which I mean the R code (which, recall is *not* up to date) consumes those files and (near as I can tell) uses exact character comparisons to decide which codes should implicate which flags.

Note that the set of ICD-10 dx codes is somewhat volatile, which is why the SAS code uses a pattern-matching approach.  While we at KPWHRI do have a pretty good reference list of dx codes & their descriptions (and shout-out to [OHDSI's OMOP](https://www.ohdsi.org/data-standardization/) project for that) the codes in `pmca_dx_code_lists.xlsx` are guaranteed to be **accurate**, but not necessarily **complete**.  That is, you may find raw diagnosis codes in the data you feed into `%pmca()` that trip a body system or progressive flag that are not on this list. Pro tip: use the `%classify_dx()` macro in the file of the same name to test your own set of codes.

I hereby undertake to regenerate `pmca_dx_code_lists.xlsx` when I update the main macros. But none of the other files are my work, and so there's no warranty of functionality, usefulness, etc.
