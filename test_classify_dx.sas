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

libname s "\\home.ghc.org\home$\pardre1\workingdata\pmca" ;
%include "C:\users\o578092\documents\vdw\pmca\classify_dx.sas" ;

* These are diagnoses that currently get flagged for inclusion, but should not. ;
* Also, diags that were considered for adding, but decided against. ;
data s.dont_want ;
  input
    @1    dx          $char8.
    @11   bs_wanted   $char21.
    @33   description $char61.
  ;
  dx_codetype = '10' ;
  infile datalines truncover ;
datalines ;
H57.1     ophthalmological      Ocular pain
H57.10    ophthalmological      Ocular pain, unspecified eye
H57.11    ophthalmological      Ocular pain, right eye
H57.12    ophthalmological      Ocular pain, left eye
H57.13    ophthalmological      Ocular pain, bilateral
I82.2     cardiac               Embolism and thrombosis of vena cava and other thoracic veins
I82.21    cardiac               Embolism and thrombosis of superior vena cava
I82.22    cardiac               Embolism and thrombosis of inferior vena cava
I82.29    cardiac               Embolism and thrombosis of other thoracic veins
M24.4     musculoskeletal       Recurrent dislocation of joint
M24.41    musculoskeletal       Recurrent dislocation, shoulder
M24.42    musculoskeletal       Recurrent dislocation, elbow
M24.43    musculoskeletal       Recurrent dislocation, wrist
M24.44    musculoskeletal       Recurrent dislocation, hand and finger(s)
M24.45    musculoskeletal       Recurrent dislocation, hip
M24.46    musculoskeletal       Recurrent dislocation, knee
M24.47    musculoskeletal       Recurrent dislocation, ankle, foot and toes
D59.12    hematological         Cold autoimmune hemolytic anemia
D89.831   immunological         Cytokine release syndrome, grade 1
D89.832   immunological         Cytokine release syndrome, grade 2
D89.833   immunological         Cytokine release syndrome, grade 3
D89.834   immunological         Cytokine release syndrome, grade 4
D89.835   immunological         Cytokine release syndrome, grade 5
D89.839   immunological         Cytokine release syndrome, grade unspecified
K83.0     gastrointestinal      Cholangitis
K83.09    gastrointestinal      Other cholangitis
M35.81    immunological         Multisystem inflammatory syndrome (MIS)
U07.0     pulmonary/respiratory Vaping-related disorder
U07.1     pulmonary/respiratory COVID-19
run ;

* These are the new codes we are adding ;
data s.do_want ;
  input
    @1    dx          $char8.
    @11   bs_wanted   $char21.
    @33   prog_wanted $char3.
    @37   description $char70.
  ;
  dx_codetype = '10' ;
  infile datalines truncover ;
datalines ;
C43.111   malignancy            n/a Malignant melanoma of right upper eyelid, including canthus
C43.112   malignancy            n/a Malignant melanoma of right lower eyelid, including canthus
C43.121   malignancy            n/a Malignant melanoma of left upper eyelid, including canthus
C43.122   malignancy            n/a Malignant melanoma of left lower eyelid, including canthus
C44.1021  malignancy            n/a Unspecified malignant neoplasm of skin of right upper eyelid, including canthus
C44.1022  malignancy            n/a Unspecified malignant neoplasm of skin of right lower eyelid, including canthus
C44.1091  malignancy            n/a Unspecified malignant neoplasm of skin of left upper eyelid, including canthus
C44.1092  malignancy            n/a Unspecified malignant neoplasm of skin of left lower eyelid, including canthus
C44.1121  malignancy            n/a Basal cell carcinoma of skin of right upper eyelid, including canthus
C44.1122  malignancy            n/a Basal cell carcinoma of skin of right lower eyelid, including canthus
C44.1191  malignancy            n/a Basal cell carcinoma of skin of left upper eyelid, including canthus
C44.1192  malignancy            n/a Basal cell carcinoma of skin of left lower eyelid, including canthus
C44.1221  malignancy            n/a Squamous cell carcinoma of skin of right upper eyelid, including canthus
C44.1222  malignancy            n/a Squamous cell carcinoma of skin of right lower eyelid, including canthus
C44.1291  malignancy            n/a Squamous cell carcinoma of skin of left upper eyelid, including canthus
C44.1292  malignancy            n/a Squamous cell carcinoma of skin of left lower eyelid, including canthus
C44.131   malignancy            n/a Sebaceous cell carcinoma of skin of unspecified eyelid, including canthus
C44.1321  malignancy            n/a Sebaceous cell carcinoma of skin of right upper eyelid, including canthus
C44.1322  malignancy            n/a Sebaceous cell carcinoma of skin of right lower eyelid, including canthus
C44.1391  malignancy            n/a Sebaceous cell carcinoma of skin of left upper eyelid, including canthus
C44.1392  malignancy            n/a Sebaceous cell carcinoma of skin of left lower eyelid, including canthus
C44.1921  malignancy            n/a Other specified malignant neoplasm of skin of right upper eyelid, including canthus
C44.1922  malignancy            n/a Other specified malignant neoplasm of skin of right lower eyelid, including canthus
C44.1991  malignancy            n/a Other specified malignant neoplasm of skin of left upper eyelid, including canthus
C44.1992  malignancy            n/a Other specified malignant neoplasm of skin of left lower eyelid, including canthus
C4A.11    malignancy            n/a Merkel cell carcinoma of right upper eyelid, including canthus
C4A.12    malignancy            n/a Merkel cell carcinoma of right lower eyelid, including canthus
C4A.21    malignancy            n/a Merkel cell carcinoma of left upper eyelid, including canthus
C4A.22    malignancy            n/a Merkel cell carcinoma of left lower eyelid, including canthus
C96.20    malignancy            n/a Malignant mast cell neoplasm, unspecified
C96.21    malignancy            n/a Aggressive systemic mastocytosis
C96.22    malignancy            n/a Mast cell sarcoma
C96.29    malignancy            n/a Other malignant mast cell neoplasm
D03.111   malignancy            n/a Melanoma in situ of right upper eyelid, including canthus
D03.112   malignancy            n/a Melanoma in situ of right lower eyelid, including canthus
D03.121   malignancy            n/a Melanoma in situ of left upper eyelid, including canthus
D03.122   malignancy            n/a Melanoma in situ of left lower eyelid, including canthus
D57.03    hematological         yes Hb-SS disease with cerebral vascular involvement
D57.09    hematological         yes Hb-SS disease with crisis with other specified complication
D57.213   hematological         yes Sickle-cell/Hb-C disease with cerebral vascular involvement
D57.218   hematological         yes Sickle-cell/Hb-C disease with crisis with other specified complication
D57.413   hematological         yes Sickle-cell thalassemia, unspecified, with cerebral vascular involvement
D57.418   hematological         yes Sickle-cell thalassemia, unspecified, with crisis with other specified complication
D57.42    hematological         yes Sickle-cell thalassemia betaZero without crisis
D57.431   hematological         yes Sickle-cell thalassemia betaZero with acute chest syndrome
D57.432   hematological         yes Sickle-cell thalassemia betaZero with splenic sequestration
D57.433   hematological         yes Sickle-cell thalassemia betaZero with cerebral vascular involvement
D57.438   hematological         yes Sickle-cell thalassemia betaZero with crisis with other specified complication
D57.439   hematological         yes Sickle-cell thalassemia betaZero with crisis, unspecified
D57.44    hematological         no  Sickle-cell thalassemia beta plus without crisis
D57.451   hematological         no  Sickle-cell thalassemia beta plus with acute chest syndrome
D57.452   hematological         no  Sickle-cell thalassemia beta plus with splenic sequestration
D57.453   hematological         no  Sickle-cell thalassemia beta plus with cerebral vascular involvement
D57.458   hematological         no  Sickle-cell thalassemia beta plus with crisis with other specified complication
D57.459   hematological         no  Sickle-cell thalassemia beta plus with crisis, unspecified
D57.813   hematological         yes Other sickle-cell disorders with cerebral vascular involvement
D57.818   hematological         yes Other sickle-cell disorders with crisis with other specified complication
D59.10    hematological         no  Autoimmune hemolytic anemia, unspecified
D59.11    hematological         no  Warm autoimmune hemolytic anemia
D59.13    hematological         no  Mixed type autoimmune hemolytic anemia
D59.19    hematological         no  Other autoimmune hemolytic anemia
D75.A     hematological         no  Glucose-6-phosphate dehydrogenase (G6PD) deficiency without anemia
D81.30    immunological         yes Adenosine deaminase deficiency, unspecified
D81.31    immunological         yes Severe combined immunodeficiency due to adenosine deaminase deficiency
D81.32    immunological         yes Adenosine deaminase 2 deficiency
D81.39    immunological         yes Other adenosine deaminase deficiency
D84.1     immunological         no  Immunodeficiency due to conditions classified elsewhere
D84.21    immunological         no  Immunodeficiency due to drugs
D84.22    immunological         no  Immunodeficiency due to external causes
D84.9     immunological         no  Other immunodeficiencies
E11.10    endocrinological      no  Type 2 diabetes mellitus with ketoacidosis without coma
E11.11    endocrinological      no  Type 2 diabetes mellitus with ketoacidosis with coma
E70.81    metabolic             yes Aromatic L-amino acid decarboxylase deficiency
E70.89    metabolic             yes Other disorders of aromatic amino-acid metabolism
E72.81    metabolic             yes Disorders of gamma aminobutyric acid metabolism
E72.89    metabolic             yes Other specified disorders of amino-acid metabolism
E74.810   metabolic             yes Glucose transporter protein type 1 deficiency
E74.818   metabolic             yes Other disorders of glucose transport
E74.819   metabolic             yes Disorders of glucose transport, unspecified
E74.89    metabolic             yes Other specified disorders of carbohydrate metabolism
E75.26    metabolic             yes Sulfatase deficiency
E85.81    metabolic             yes Light chain (AL) amyloidosis
E85.82    metabolic             yes Wild-type transthyretin-related (ATTR) amyloidosis
E85.89    metabolic             yes Other amyloidosis
E88.02    metabolic             no  Plasminogen deficiency
G11.10    neurological          yes Early-onset cerebellar ataxia, unspecified
G11.11    neurological          yes Friedreich ataxia
G11.19    neurological          yes Other early-onset cerebellar ataxia
G12.23    neurological          yes Primary lateral sclerosis
G12.24    neurological          yes Familial motor neuron disease
G12.25    neurological          yes Progressive spinal muscle atrophy
G40.42    neurological          no  Cyclin-Dependent Kinase-Like 5 Deficiency Disorder
G40.833   neurological          yes Dravet syndrome, intractable, with status epilepticus
G40.834   neurological          yes Dravet syndrome, intractable, without status epilepticus
G71.00    neurological          yes Muscular dystrophy, unspecified
G71.01    neurological          yes Duchenne or Becker muscular dystrophy
G71.02    neurological          no  Facioscapulohumeral muscular dystrophy
G71.09    neurological          yes Other specified muscular dystrophies
G71.20    neurological          yes Congenital myopathy, unspecifed
G71.21    neurological          yes Nemaline myopathy
G71.220   neurological          yes X-linked myotubular myopathy
G71.228   neurological          yes Other centronuclear myopathy
G71.29    neurological          yes Other congenital myopathy
H54.0X33  ophthalmological      no  Blindness right eye category 3, blindness left eye category 3
H54.0X34  ophthalmological      no  Blindness right eye category 3, blindness left eye category 4
H54.0X35  ophthalmological      no  Blindness right eye category 3, blindness left eye category 5
H54.0X43  ophthalmological      no  Blindness right eye category 4, blindness left eye category 3
H54.0X44  ophthalmological      no  Blindness right eye category 4, blindness left eye category 4
H54.0X45  ophthalmological      no  Blindness right eye category 4, blindness left eye category 5
H54.0X53  ophthalmological      no  Blindness right eye category 5, blindness left eye category 3
H54.0X54  ophthalmological      no  Blindness right eye category 5, blindness left eye category 4
H54.0X55  ophthalmological      no  Blindness right eye category 5, blindness left eye category 5
H54.1131  ophthalmological      no  Blindness right eye category 3, low vision left eye category 1
H54.1132  ophthalmological      no  Blindness right eye category 3, low vision left eye category 2
H54.1141  ophthalmological      no  Blindness right eye category 4, low vision left eye category 1
H54.1142  ophthalmological      no  Blindness right eye category 4, low vision left eye category 2
H54.1151  ophthalmological      no  Blindness right eye category 5, low vision left eye category 1
H54.1152  ophthalmological      no  Blindness right eye category 5, low vision left eye category 2
H54.1213  ophthalmological      no  Low vision right eye category 1, blindness left eye category 3
H54.1214  ophthalmological      no  Low vision right eye category 1, blindness left eye category 4
H54.1215  ophthalmological      no  Low vision right eye category 1, blindness left eye category 5
H54.1223  ophthalmological      no  Low vision right eye category 2, blindness left eye category 3
H54.1224  ophthalmological      no  Low vision right eye category 2, blindness left eye category 4
H54.1225  ophthalmological      no  Low vision right eye category 2, blindness left eye category 5
H54.2X11  ophthalmological      no  Low vision right eye category 1, low vision left eye category 1
H54.2X12  ophthalmological      no  Low vision right eye category 1, low vision left eye category 2
H54.2X21  ophthalmological      no  Low vision right eye category 2, low vision left eye category 1
H54.2X22  ophthalmological      no  Low vision right eye category 2, low vision left eye category 2
H81.4     otologic              no  Vertigo of central origin
I21.9     cardiac               yes Acute myocardial infarction, unspecified
I21.A1    cardiac               yes Myocardial infarction type 2
I21.A9    cardiac               yes Other myocardial infarction type
I27.20    cardiac               yes Pulmonary hypertension, unspecified
I27.21    cardiac               yes Secondary pulmonary arterial hypertension
I27.22    cardiac               yes Pulmonary hypertension due to left heart disease
I27.23    cardiac               yes Pulmonary hypertension due to lung diseases and hypoxia
I27.24    cardiac               yes Chronic thromboembolic pulmonary hypertension
I27.29    cardiac               yes Other secondary pulmonary hypertension
I27.83    cardiac               yes Eisenmengers syndrome
I48.11    cardiac               no  Longstanding persistent atrial fibrillation
I48.19    cardiac               no  Other persistent atrial fibrillation
I48.20    cardiac               no  Chronic atrial fibrillation, unspecified
I48.21    cardiac               no  Permanent atrial fibrillation
I50.810   cardiac               yes Right heart failure, unspecified
I50.811   cardiac               yes Acute right heart failure
I50.812   cardiac               yes Chronic right heart failure
I50.813   cardiac               yes Acute on chronic right heart failure
I50.814   cardiac               yes Right heart failure due to left heart failure
I50.82    cardiac               yes Biventricular heart failure
I50.83    cardiac               yes High output heart failure
I50.84    cardiac               yes End stage heart failure
I50.89    cardiac               yes Other heart failure
I63.81    neurological          yes Other cerebral infarction due to occlusion or stenosis of small artery
I63.89    neurological          yes Other cerebral infarction
I82.551   cardiac               no  Chronic embolism and thrombosis of right peroneal vein
I82.552   cardiac               no  Chronic embolism and thrombosis of left peroneal vein
I82.553   cardiac               no  Chronic embolism and thrombosis of peroneal vein, bilateral
I82.559   cardiac               no  Chronic embolism and thrombosis of unspecified peroneal vein
I82.561   cardiac               no  Chronic embolism and thrombosis of right calf muscular vein
I82.562   cardiac               no  Chronic embolism and thrombosis of left calf muscular vein
I82.563   cardiac               no  Chronic embolism and thrombosis of calf muscular vein, bilateral
I82.569   cardiac               no  Chronic embolism and thrombosis of unspecified calf muscular vein
J84.170   pulmonary/respiratory yes Interstitial lung disease with progressive fibrotic phenotype in diseases classified elsewhere
J84.178   pulmonary/respiratory yes Other interstitial pulmonary diseases with fibrosis in diseases classified elsewhere
K74.00    gastrointestinal      yes Hepatic fibrosis, unspecified
K74.01    gastrointestinal      yes Hepatic fibrosis, early fibrosis
K74.02    gastrointestinal      yes Hepatic fibrosis, advanced fibrosis
K83.01    gastrointestinal      yes Primary sclerosing cholangitis
L89.006   dermatological        no  Pressure-induced deep tissue damage of unspecified elbow
L89.016   dermatological        no  Pressure-induced deep tissue damage of right elbow
L89.026   dermatological        no  Pressure-induced deep tissue damage of left elbow
L89.116   dermatological        no  Pressure-induced deep tissue damage of right upper back
L89.126   dermatological        no  Pressure-induced deep tissue damage of left upper back
L89.136   dermatological        no  Pressure-induced deep tissue damage of right lower back
L89.146   dermatological        no  Pressure-induced deep tissue damage of left lower back
L89.156   dermatological        no  Pressure-induced deep tissue damage of sacral region
L89.216   dermatological        no  Pressure-induced deep tissue damage of right hip
L89.226   dermatological        no  Pressure-induced deep tissue damage of left hip
L89.306   dermatological        no  Pressure-induced deep tissue damage of unspecified buttock
L89.316   dermatological        no  Pressure-induced deep tissue damage of right buttock
L89.326   dermatological        no  Pressure-induced deep tissue damage of left buttock
L89.46    dermatological        no  Pressure-induced deep tissue damage of contiguous site of back, buttock and hip
L89.506   dermatological        no  Pressure-induced deep tissue damage of unspecified ankle
L89.516   dermatological        no  Pressure-induced deep tissue damage of right ankle
L89.526   dermatological        no  Pressure-induced deep tissue damage of left ankle
L89.606   dermatological        no  Pressure-induced deep tissue damage of unspecified heel
L89.616   dermatological        no  Pressure-induced deep tissue damage of right heel
L89.626   dermatological        no  Pressure-induced deep tissue damage of left heel
L89.816   dermatological        no  Pressure-induced deep tissue damage of head
L89.896   dermatological        no  Pressure-induced deep tissue damage of other site
L97.105   dermatological        no  Non-pressure chronic ulcer of unspecified thigh with muscle involvement without evidence of necrosis
L97.106   dermatological        no  Non-pressure chronic ulcer of unspecified thigh with bone involvement without evidence of necrosis
L97.108   dermatological        no  Non-pressure chronic ulcer of unspecified thigh with other specified severity
L97.115   dermatological        no  Non-pressure chronic ulcer of right thigh with muscle involvement without evidence of necrosis
L97.116   dermatological        no  Non-pressure chronic ulcer of right thigh with bone involvement without evidence of necrosis
L97.118   dermatological        no  Non-pressure chronic ulcer of right thigh with other specified severity
L97.125   dermatological        no  Non-pressure chronic ulcer of left thigh with muscle involvement without evidence of necrosis
L97.126   dermatological        no  Non-pressure chronic ulcer of left thigh with bone involvement without evidence of necrosis
L97.128   dermatological        no  Non-pressure chronic ulcer of left thigh with other specified severity
L97.205   dermatological        no  Non-pressure chronic ulcer of unspecified calf with muscle involvement without evidence of necrosis
L97.206   dermatological        no  Non-pressure chronic ulcer of unspecified calf with bone involvement without evidence of necrosis
L97.208   dermatological        no  Non-pressure chronic ulcer of unspecified calf with other specified severity
L97.215   dermatological        no  Non-pressure chronic ulcer of right calf with muscle involvement without evidence of necrosis
L97.216   dermatological        no  Non-pressure chronic ulcer of right calf with bone involvement without evidence of necrosis
L97.218   dermatological        no  Non-pressure chronic ulcer of right calf with other specified severity
L97.225   dermatological        no  Non-pressure chronic ulcer of left calf with muscle involvement without evidence of necrosis
L97.226   dermatological        no  Non-pressure chronic ulcer of left calf with bone involvement without evidence of necrosis
L97.228   dermatological        no  Non-pressure chronic ulcer of left calf with other specified severity
L97.305   dermatological        no  Non-pressure chronic ulcer of unspecified ankle with muscle involvement without evidence of necrosis
L97.306   dermatological        no  Non-pressure chronic ulcer of unspecified ankle with bone involvement without evidence of necrosis
L97.308   dermatological        no  Non-pressure chronic ulcer of unspecified ankle with other specified severity
L97.315   dermatological        no  Non-pressure chronic ulcer of right ankle with muscle involvement without evidence of necrosis
L97.316   dermatological        no  Non-pressure chronic ulcer of right ankle with bone involvement without evidence of necrosis
L97.318   dermatological        no  Non-pressure chronic ulcer of right ankle with other specified severity
L97.325   dermatological        no  Non-pressure chronic ulcer of left ankle with muscle involvement without evidence of necrosis
L97.326   dermatological        no  Non-pressure chronic ulcer of left ankle with bone involvement without evidence of necrosis
L97.328   dermatological        no  Non-pressure chronic ulcer of left ankle with other specified severity
L97.405   dermatological        no  Non-pressure chronic ulcer of unspecified heel and midfoot with muscle involvement without evidence of necrosis
L97.406   dermatological        no  Non-pressure chronic ulcer of unspecified heel and midfoot with bone involvement without evidence of necrosis
L97.408   dermatological        no  Non-pressure chronic ulcer of unspecified heel and midfoot with other specified severity
L97.415   dermatological        no  Non-pressure chronic ulcer of right heel and midfoot with muscle involvement without evidence of necrosis
L97.416   dermatological        no  Non-pressure chronic ulcer of right heel and midfoot with bone involvement without evidence of necrosis
L97.418   dermatological        no  Non-pressure chronic ulcer of right heel and midfoot with other specified severity
L97.425   dermatological        no  Non-pressure chronic ulcer of left heel and midfoot with muscle involvement without evidence of necrosis
L97.426   dermatological        no  Non-pressure chronic ulcer of left heel and midfoot with bone involvement without evidence of necrosis
L97.428   dermatological        no  Non-pressure chronic ulcer of left heel and midfoot with other specified severity
L97.505   dermatological        no  Non-pressure chronic ulcer of other part of unspecified foot with muscle involvement without evidence of necrosis
L97.506   dermatological        no  Non-pressure chronic ulcer of other part of unspecified foot with bone involvement without evidence of necrosis
L97.508   dermatological        no  Non-pressure chronic ulcer of other part of unspecified foot with other specified severity
L97.515   dermatological        no  Non-pressure chronic ulcer of other part of right foot with muscle involvement without evidence of necrosis
L97.516   dermatological        no  Non-pressure chronic ulcer of other part of right foot with bone involvement without evidence of necrosis
L97.518   dermatological        no  Non-pressure chronic ulcer of other part of right foot with other specified severity
L97.525   dermatological        no  Non-pressure chronic ulcer of other part of left foot with muscle involvement without evidence of necrosis
L97.526   dermatological        no  Non-pressure chronic ulcer of other part of left foot with bone involvement without evidence of necrosis
L97.528   dermatological        no  Non-pressure chronic ulcer of other part of left foot with other specified severity
L97.805   dermatological        no  Non-pressure chronic ulcer of other part of unspecified lower leg with muscle involvement without evidence of necrosis
L97.806   dermatological        no  Non-pressure chronic ulcer of other part of unspecified lower leg with bone involvement without evidence of necrosis
L97.808   dermatological        no  Non-pressure chronic ulcer of other part of unspecified lower leg with other specified severity
L97.815   dermatological        no  Non-pressure chronic ulcer of other part of right lower leg with muscle involvement without evidence of necrosis
L97.816   dermatological        no  Non-pressure chronic ulcer of other part of right lower leg with bone involvement without evidence of necrosis
L97.818   dermatological        no  Non-pressure chronic ulcer of other part of right lower leg with other specified severity
L97.825   dermatological        no  Non-pressure chronic ulcer of other part of left lower leg with muscle involvement without evidence of necrosis
L97.826   dermatological        no  Non-pressure chronic ulcer of other part of left lower leg with bone involvement without evidence of necrosis
L97.828   dermatological        no  Non-pressure chronic ulcer of other part of left lower leg with other specified severity
L97.905   dermatological        no  Non-pressure chronic ulcer of unspecified part of unspecified lower leg with muscle involvement without evidence of necrosis
L97.906   dermatological        no  Non-pressure chronic ulcer of unspecified part of unspecified lower leg with bone involvement without evidence of necrosis
L97.908   dermatological        no  Non-pressure chronic ulcer of unspecified part of unspecified lower leg with other specified severity
L97.915   dermatological        no  Non-pressure chronic ulcer of unspecified part of right lower leg with muscle involvement without evidence of necrosis
L97.916   dermatological        no  Non-pressure chronic ulcer of unspecified part of right lower leg with bone involvement without evidence of necrosis
L97.918   dermatological        no  Non-pressure chronic ulcer of unspecified part of right lower leg with other specified severity
L97.925   dermatological        no  Non-pressure chronic ulcer of unspecified part of left lower leg with muscle involvement without evidence of necrosis
L97.926   dermatological        no  Non-pressure chronic ulcer of unspecified part of left lower leg with bone involvement without evidence of necrosis
L97.928   dermatological        no  Non-pressure chronic ulcer of unspecified part of left lower leg with other specified severity
L98.415   dermatological        no  Non-pressure chronic ulcer of buttock with muscle involvement without evidence of necrosis
L98.416   dermatological        no  Non-pressure chronic ulcer of buttock with bone involvement without evidence of necrosis
L98.418   dermatological        no  Non-pressure chronic ulcer of buttock with other specified severity
L98.425   dermatological        no  Non-pressure chronic ulcer of back with muscle involvement without evidence of necrosis
L98.426   dermatological        no  Non-pressure chronic ulcer of back with bone involvement without evidence of necrosis
L98.428   dermatological        no  Non-pressure chronic ulcer of back with other specified severity
L98.495   dermatological        no  Non-pressure chronic ulcer of skin of other sites with muscle involvement without evidence of necrosis
L98.496   dermatological        no  Non-pressure chronic ulcer of skin of other sites with bone involvement without evidence of necrosis
L98.498   dermatological        no  Non-pressure chronic ulcer of skin of other sites with other specified severity
M06.0A    immunological         no  Rheumatoid arthritis without rheumatoid factor, other specified site
M06.8A    immunological         no  Other specified rheumatoid arthritis, other specified site
M08.0A    immunological         no  Unspecified juvenile rheumatoid arthritis, other specified site
M08.2A    immunological         no  Juvenile rheumatoid arthritis with systemic onset, other specified site
M08.4A    immunological         no  Pauciarticular juvenile rheumatoid arthritis, other specified site
M08.9A    immunological         no  Juvenile arthritis, unspecified, other specified site
M24.19    musculoskeletal       no  Other articular cartilage disorders, other specified site
M24.29    musculoskeletal       no  Disorder of ligament, other specified site
M24.39    musculoskeletal       no  Pathological dislocation of other specified joint, not elsewhere classified
M24.49    musculoskeletal       no  Recurrent dislocation, other specified joint
M24.59    musculoskeletal       no  Contracture, other specified joint
M24.69    musculoskeletal       no  Ankylosis, other specified joint
M24.89    musculoskeletal       no  Other specific joint derangement of other specified joint, not elsewhere classified
N02.A     renal                 yes Recurrent and persistent hematuria with C3 glomerulonephritis
N03.A     renal                 yes Chronic nephritic syndrome with C3 glomerulonephritis
N04.A     renal                 yes Nephrotic syndrome with C3 glomerulonephritis
N05.A     renal                 yes Unspecified nephritic syndrome with C3 glomerulonephritis
N18.30    renal                 yes Chronic kidney disease, stage 3 unspecified
N18.31    renal                 yes Chronic kidney disease, stage 3a
N18.32    renal                 yes Chronic kidney disease, stage 3b
N35.811   renal                 no  Other urethral stricture, male, meatal
N35.812   renal                 no  Other urethral bulbous stricture, male
N35.813   renal                 no  Other membranous urethral stricture, male
N35.814   renal                 no  Other anterior urethral stricture, male
N35.816   renal                 no  Other urethral stricture, male, overlapping sites
N35.819   renal                 no  Other urethral stricture, male, unspecified site
N35.82    renal                 no  Other urethral stricture, female
N35.911   renal                 no  Unspecified urethral stricture, male, meatal
N35.912   renal                 no  Unspecified bulbous urethral stricture, male
N35.913   renal                 no  Unspecified membranous urethral stricture, male
N35.914   renal                 no  Unspecified anterior urethral stricture, male
N35.916   renal                 no  Unspecified urethral stricture, male, overlapping sites
N35.919   renal                 no  Unspecified urethral stricture, male, unspecified site
N35.92    renal                 no  Unspecified urethral stricture, female
P29.30    cardiac               no  Pulmonary hypertension of newborn
P29.38    cardiac               no  Other persistent fetal circulation
Q66.70    musculoskeletal       no  Congenital pes cavus, unspecified foot
Q66.71    musculoskeletal       no  Congenital pes cavus, right foot
Q66.72    musculoskeletal       no  Congenital pes cavus, left foot
Q79.60    musculoskeletal       no  Ehlers-Danlos syndrome, unspecified
Q79.61    musculoskeletal       no  Classical Ehlers-Danlos syndrome
Q79.62    musculoskeletal       no  Hypermobile Ehlers-Danlos syndrome
Q79.63    musculoskeletal       yes Vascular Ehlers-Danlos syndrome
Q79.69    musculoskeletal       no  Other Ehlers-Danlos syndromes
Q87.11    genetic               yes Prader-Willi syndrome
Q87.19    genetic               no  Other congenital malformation syndromes predominantly associated with short stature
Q93.51    genetic               no  Angelman syndrome
Q93.59    genetic               no  Other deletions of part of a chromosome
Q93.82    genetic               yes Williams syndrome
;
run ;

proc sql ;
  alter table s.dont_want add primary key (dx) ;
  alter table s.do_want add primary key (dx) ;
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

proc sql ;
  create table s.to_be_added as
  select n.*, (not t.dx is null) as already_included
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

  proc freq data = s.added_codes  ;
    tables body_system * bs_wanted / missing format = comma9.0 ;
    where body_system ne bs_wanted ;
  run ;

  proc freq data = s.added_codes  ;
    tables progressive * prog_wanted / missing format = comma9.0 ;
  run ;

run ;

ods _all_ close ;

