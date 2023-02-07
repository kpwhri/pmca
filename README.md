# Pediatric Medical Complexity Algorithm (PMCA)

SAS Code and associated documents for calculating the PMCA.

Reference: [Pediatric Medical Complexity Algorithm: A New Method to Stratify Children by Medical Complexity](http://pediatrics.aappublications.org/content/early/2014/05/07/peds.2013-3875), Tamara D. Simon, Mary Lawrence Cawthon, Susan Stanford, Jean Popalisky, Dorothy Lyons, Peter Woodcox, Margaret Hood, Alex Y. Chen and Rita Mangione-Smith, Pediatrics; originally published online May 12, 2014; DOI: 10.1542/peds.2013-3875

## Now with an implementation in R

As of release v3.2.0, this repo contains an implementation of the PMCA in R. It is important to know that this code:

* has not been validated
* was not tested by me (@kaiser-roy), and
* has thus far not been updated since v3.2.0

Please get in touch with the author listed in that file's header for support.

## Update Process

(Mostly a note-to-self)

Rita will occasionally send an xlsx of new dx codes, along with yes-or-no include decisions, body systems & progressive-or-not information. When that happens, the steps for updating the %pmca macro are:

1. copy the `%classify_dx` macro out of pmca.sas and into classify_dx.sas (to make absolutely sure you're working with the most recent version).
2. Take the no-diagnoses and append them to the end of the `s.dont_want` input datastep in test_classify_dx.sas.
3. Take the yes-diagnoses and append those to the end of `s.do_want`.
4. Run test_classify_dx.sas and note the deficiencies listed in the test_classify_dx.html output.
5. Edit classify_dx.sas until there are no more deficiencies
6. Copy `%classify_dx` out of classify_dx.sas and paste it over top of the one in pmca.sas
7. Commit/tag/push & inform Rita the update is done.
