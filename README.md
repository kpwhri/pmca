# Pediatric Medical Complexity Algorithm (PMCA)

SAS Code and associated documents for calculating the PMCA.

Reference: [Pediatric Medical Complexity Algorithm: A New Method to Stratify Children by Medical Complexity](http://pediatrics.aappublications.org/content/early/2014/05/07/peds.2013-3875), Tamara D. Simon, Mary Lawrence Cawthon, Susan Stanford, Jean Popalisky, Dorothy Lyons, Peter Woodcox, Margaret Hood, Alex Y. Chen and Rita Mangione-Smith,  Pediatrics; originally published online May 12, 2014;  DOI: 10.1542/peds.2013-3875

## Now with an implementation in R

The implementation in get_PCMA.R is not tested by me (@kaiser-roy). Please get in touch with the author listed in that file's header for support.

## Update Process

(Mostly a note-to-self)

Rita will occasionally send an xlsx of new dx codes, along with yes-or-no include decisions, body systems & progressive-or-not information. When that happens, the steps for updating the %pmca macro are:

1. copy the `%classify_dx` macro out of pmca.sas and into classify_dx.sas (to make absolutely sure you're working with the most recent version).
2. Take the no-diagnoses and append them to the end of the `s.dont_want` input datastep in test_classify_dx.sas.
3. Take the yes-diagnoses and append those to the end of `s.do_want`.
4. Run test_classify_dx.sas and note the deficiencies listed in the test_classify_dx.html output.
5. Edit classify_dx.sas until there are no more deficiencies
6. Copy `%classify_dx` out of classify_dx.sas and over top of the macro in pmca.sas
7. Commit/push/tag & inform Rita the update is done.
