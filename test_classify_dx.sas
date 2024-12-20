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
%include "\\ghcmaster.ghc.org\ghri\Warehouse\management\Workspace\pardre1\pmca\classify_dx.sas" ;

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
D89.44    immunological         Hereditary alpha tryptasemia
B37.31                          Acute candidiasis of vulva and vagina
B37.32                          Chronic candidiasis of vulva and vagina
D59.30                          Hemolytic-uremic syndrome, unspecified
D59.31                          Infection-associated hemolytic-uremic syndrome
D59.39                          Other hemolytic-uremic syndrome
D75.821                         Non-immune heparin-induced thrombocytopenia
D75.822                         Immune-mediated heparin-induced thrombocytopenia
D75.828                         Other heparin-induced thrombocytopenia syndrome
D75.829                         Heparin-induced thrombocytopenia, unspecified
D75.84                          Other platelet-activating anti-PF4 disorders
E34.31                          Constitutional short stature
E87.20                          Acidosis, unspecified
E87.21                          Acute metabolic acidosis
E87.29                          Other acidosis
F01.511                         Vascular dementia, unspecified severity, with agitation
F01.518                         Vascular dementia, unspecified severity, with other behavioral disturbance
F01.52                          Vascular dementia, unspecified severity, with psychotic disturbance
F01.53                          Vascular dementia, unspecified severity, with mood disturbance
F01.54                          Vascular dementia, unspecified severity, with anxiety
F01.A0                          Vascular dementia, mild, without behavioral disturbance, psychotic disturbance, mood disturbance, and anxiety
F01.A11                         Vascular dementia, mild, with agitation
F01.A18                         Vascular dementia, mild, with other behavioral disturbance
F01.A2                          Vascular dementia, mild, with psychotic disturbance
F01.A3                          Vascular dementia, mild, with mood disturbance
F01.A4                          Vascular dementia, mild, with anxiety
F01.B0                          Vascular dementia, moderate, without behavioral disturbance, psychotic disturbance, mood disturbance, and anxiety
F01.B11                         Vascular dementia, moderate, with agitation
F01.B18                         Vascular dementia, moderate, with other behavioral disturbance
F01.B2                          Vascular dementia, moderate, with psychotic disturbance
F01.B3                          Vascular dementia, moderate, with mood disturbance
F01.B4                          Vascular dementia, moderate, with anxiety
F01.C0                          Vascular dementia, severe, without behavioral disturbance, psychotic disturbance, mood disturbance, and anxiety
F01.C11                         Vascular dementia, severe, with agitation
F01.C18                         Vascular dementia, severe, with other behavioral disturbance
F01.C2                          Vascular dementia, severe, with psychotic disturbance
F01.C3                          Vascular dementia, severe, with mood disturbance
F01.C4                          Vascular dementia, severe, with anxiety
F10.90                          Alcohol use, unspecified, uncomplicated
F10.91                          Alcohol use, unspecified, in remission
F11.91                          Opioid use, unspecified, in remission
F12.91                          Cannabis use, unspecified, in remission
F13.91                          Sedative, hypnotic or anxiolytic use, unspecified, in remission
F14.91                          Cocaine use, unspecified, in remission
F15.91                          Other stimulant use, unspecified, in remission
F16.91                          Hallucinogen use, unspecified, in remission
F18.91                          Inhalant use, unspecified, in remission
F19.91                          Other psychoactive substance use, unspecified, in remission
F43.89                          Other reactions to severe stress
G93.31                          Postviral fatigue syndrome
G93.39                          Other post infection and related fatigue syndromes
I20.2                           Refractory angina pectoris
I25.112                         Atherosclerosic heart disease of native coronary artery with refractory angina pectoris
I25.702                         Atherosclerosis of coronary artery bypass graft(s), unspecified, with refractory angina pectoris
I25.712                         Atherosclerosis of autologous vein coronary artery bypass graft(s) with refractory angina pectoris
I25.722                         Atherosclerosis of autologous artery coronary artery bypass graft(s) with refractory angina pectoris
I25.732                         Atherosclerosis of nonautologous biological coronary artery bypass graft(s) with refractory angina pectoris
I25.752                         Atherosclerosis of native coronary artery of transplanted heart with refractory angina pectoris
I25.762                         Atherosclerosis of bypass graft of coronary artery of transplanted heart with refractory angina pectoris
I25.792                         Atherosclerosis of other coronary artery bypass graft(s) with refractory angina pectoris
I31.31                          Malignant pericardial effusion in diseases classified elsewhere
I31.39                          Other pericardial effusion (noninflammatory)
I34.81                          Nonrheumatic mitral (valve) annulus calcification
I71.010                         Dissection of ascending aorta
I71.011                         Dissection of aortic arch
I71.012                         Dissection of descending thoracic aorta
I71.019                         Dissection of thoracic aorta, unspecified
I71.10                          Thoracic aortic aneurysm, ruptured, unspecified
I71.11                          Aneurysm of the ascending aorta, ruptured
I71.12                          Aneurysm of the aortic arch, ruptured
I71.13                          Aneurysm of the descending thoracic aorta, ruptured
I71.30                          Abdominal aortic aneurysm, ruptured, unspecified
I71.31                          Pararenal abdominal aortic aneurysm, ruptured
I71.32                          Juxtarenal abdominal aortic aneurysm, ruptured
I71.33                          Infrarenal abdominal aortic aneurysm, ruptured
I71.50                          Thoracoabdominal aortic aneurysm, ruptured, unspecified
I71.51                          Supraceliac aneurysm of the abdominal aorta, ruptured
I71.52                          Paravisceral aneurysm of the abdominal aorta, ruptured
I71.60                          Thoracoabdominal aortic aneurysm, without rupture, unspecified
J95.87                          Transfusion-associated dyspnea (TAD)
K76.82                          Hepatic encephalopathy
M93.004                         Unspecified slipped upper femoral epiphysis (nontraumatic), bilateral hips
M93.014                         Acute slipped upper femoral epiphysis, stable (nontraumatic), bilateral hips
M93.034                         Acute on chronic slipped upper femoral epiphysis, stable (nontraumatic), bilateral hips
M93.041                         Acute slipped upper femoral epiphysis, unstable (nontraumatic), right hip
M93.042                         Acute slipped upper femoral epiphysis, unstable (nontraumatic), left hip
M93.043                         Acute slipped upper femoral epiphysis, unstable (nontraumatic), unspecified hip
M93.044                         Acute slipped upper femoral epiphysis, unstable (nontraumatic), bilateral hips
M93.051                         Acute on chronic slipped upper femoral epiphysis, unstable (nontraumatic), right hip
M93.052                         Acute on chronic slipped upper femoral epiphysis, unstable (nontraumatic), left hip
M93.053                         Acute on chronic slipped upper femoral epiphysis, unstable (nontraumatic), unspecified hip
M93.054                         Acute on chronic slipped upper femoral epiphysis, unstable (nontraumatic), bilateral hips
M93.061                         Acute slipped upper femoral epiphysis, unspecified stability (nontraumatic), right hip
M93.062                         Acute slipped upper femoral epiphysis, unspecified stability (nontraumatic), left hip
M93.063                         Acute slipped upper femoral epiphysis, unspecified stability (nontraumatic), unspecified hip
M93.064                         Acute slipped upper femoral epiphysis, unspecified stability (nontraumatic), bilateral hips
M93.071                         Acute on chronic slipped upper femoral epiphysis, unspecified stability (nontraumatic), right hip
M93.072                         Acute on chronic slipped upper femoral epiphysis, unspecified stability (nontraumatic), left hip
M93.073                         Acute on chronic slipped upper femoral epiphysis, unspecified stability (nontraumatic), unspecified hip
M93.074                         Acute on chronic slipped upper femoral epiphysis, unspecified stability (nontraumatic), bilateral hips
M96.A1                          Fracture of sternum associated with chest compression and cardiopulmonary resuscitation
M96.A2                          Fracture of one rib associated with chest compression and cardiopulmonary resuscitation
M96.A3                          Multiple fractures of ribs associated with chest compression and cardiopulmonary resuscitation
M96.A4                          Flail chest associated with chest compression and cardiopulmonary resuscitation
M96.A9                          Other fracture associated with chest compression and cardiopulmonary resuscitation
N14.11                          Contrast-induced nephropathy
N14.19                          Nephropathy induced by other drugs, medicaments and biological substances
N76.82                          Fournier disease of vagina and vulva
O35.00X0                        Maternal care for (suspected) central nervous system malformation or damage in fetus, unspecified, not applicable or unspecified
O35.00X1                        Maternal care for (suspected) central nervous system malformation or damage in fetus, unspecified, fetus 1
O35.00X2                        Maternal care for (suspected) central nervous system malformation or damage in fetus, unspecified, fetus 2
O35.00X3                        Maternal care for (suspected) central nervous system malformation or damage in fetus, unspecified, fetus 3
O35.00X4                        Maternal care for (suspected) central nervous system malformation or damage in fetus, unspecified, fetus 4
O35.00X5                        Maternal care for (suspected) central nervous system malformation or damage in fetus, unspecified, fetus 5
O35.00X9                        Maternal care for (suspected) central nervous system malformation or damage in fetus, unspecified, other fetus
O35.01X0                        Maternal care for (suspected) central nervous system malformation or damage in fetus, agenesis of the corpus callosum, not applicable or unspecified
O35.01X1                        Maternal care for (suspected) central nervous system malformation or damage in fetus, agenesis of the corpus callosum, fetus 1
O35.01X2                        Maternal care for (suspected) central nervous system malformation or damage in fetus, agenesis of the corpus callosum, fetus 2
O35.01X3                        Maternal care for (suspected) central nervous system malformation or damage in fetus, agenesis of the corpus callosum, fetus 3
O35.01X4                        Maternal care for (suspected) central nervous system malformation or damage in fetus, agenesis of the corpus callosum, fetus 4
O35.01X5                        Maternal care for (suspected) central nervous system malformation or damage in fetus, agenesis of the corpus callosum, fetus 5
O35.01X9                        Maternal care for (suspected) central nervous system malformation or damage in fetus, agenesis of the corpus callosum, other fetus
O35.02X0                        Maternal care for (suspected) central nervous system malformation or damage in fetus, anencephaly, not applicable or unspecified
O35.02X1                        Maternal care for (suspected) central nervous system malformation or damage in fetus, anencephaly, fetus 1
O35.02X2                        Maternal care for (suspected) central nervous system malformation or damage in fetus, anencephaly, fetus 2
O35.02X3                        Maternal care for (suspected) central nervous system malformation or damage in fetus, anencephaly, fetus 3
O35.02X4                        Maternal care for (suspected) central nervous system malformation or damage in fetus, anencephaly, fetus 4
O35.02X5                        Maternal care for (suspected) central nervous system malformation or damage in fetus, anencephaly, fetus 5
O35.02X9                        Maternal care for (suspected) central nervous system malformation or damage in fetus, anencephaly, other fetus
O35.03X0                        Maternal care for (suspected) central nervous system malformation or damage in fetus, choroid plexus cysts, not applicable or unspecified
O35.03X1                        Maternal care for (suspected) central nervous system malformation or damage in fetus, choroid plexus cysts, fetus 1
O35.03X2                        Maternal care for (suspected) central nervous system malformation or damage in fetus, choroid plexus cysts, fetus 2
O35.03X3                        Maternal care for (suspected) central nervous system malformation or damage in fetus, choroid plexus cysts, fetus 3
O35.03X4                        Maternal care for (suspected) central nervous system malformation or damage in fetus, choroid plexus cysts, fetus 4
O35.03X5                        Maternal care for (suspected) central nervous system malformation or damage in fetus, choroid plexus cysts, fetus 5
O35.03X9                        Maternal care for (suspected) central nervous system malformation or damage in fetus, choroid plexus cysts, other fetus
O35.04X0                        Maternal care for (suspected) central nervous system malformation or damage in fetus, encephalocele, not applicable or unspecified
O35.04X1                        Maternal care for (suspected) central nervous system malformation or damage in fetus, encephalocele, fetus 1
O35.04X2                        Maternal care for (suspected) central nervous system malformation or damage in fetus, encephalocele, fetus 2
O35.04X3                        Maternal care for (suspected) central nervous system malformation or damage in fetus, encephalocele, fetus 3
O35.04X4                        Maternal care for (suspected) central nervous system malformation or damage in fetus, encephalocele, fetus 4
O35.04X5                        Maternal care for (suspected) central nervous system malformation or damage in fetus, encephalocele, fetus 5
O35.04X9                        Maternal care for (suspected) central nervous system malformation or damage in fetus, encephalocele, other fetus
O35.05X0                        Maternal care for (suspected) central nervous system malformation or damage in fetus, holoprosencephaly, not applicable or unspecified
O35.05X1                        Maternal care for (suspected) central nervous system malformation or damage in fetus, holoprosencephaly, fetus 1
O35.05X2                        Maternal care for (suspected) central nervous system malformation or damage in fetus, holoprosencephaly, fetus 2
O35.05X3                        Maternal care for (suspected) central nervous system malformation or damage in fetus, holoprosencephaly, fetus 3
O35.05X4                        Maternal care for (suspected) central nervous system malformation or damage in fetus, holoprosencephaly, fetus 4
O35.05X5                        Maternal care for (suspected) central nervous system malformation or damage in fetus, holoprosencephaly, fetus 5
O35.05X9                        Maternal care for (suspected) central nervous system malformation or damage in fetus, holoprosencephaly, other fetus
O35.06X0                        Maternal care for (suspected) central nervous system malformation or damage in fetus, hydrocephaly, not applicable or unspecified
O35.06X1                        Maternal care for (suspected) central nervous system malformation or damage in fetus, hydrocephaly, fetus 1
O35.06X2                        Maternal care for (suspected) central nervous system malformation or damage in fetus, hydrocephaly, fetus 2
O35.06X3                        Maternal care for (suspected) central nervous system malformation or damage in fetus, hydrocephaly, fetus 3
O35.06X4                        Maternal care for (suspected) central nervous system malformation or damage in fetus, hydrocephaly, fetus 4
O35.06X5                        Maternal care for (suspected) central nervous system malformation or damage in fetus, hydrocephaly, fetus 5
O35.06X9                        Maternal care for (suspected) central nervous system malformation or damage in fetus, hydrocephaly, other fetus
O35.07X0                        Maternal care for (suspected) central nervous system malformation or damage in fetus, microcephaly, not applicable or unspecified
O35.07X1                        Maternal care for (suspected) central nervous system malformation or damage in fetus, microcephaly, fetus 1
O35.07X2                        Maternal care for (suspected) central nervous system malformation or damage in fetus, microcephaly, fetus 2
O35.07X3                        Maternal care for (suspected) central nervous system malformation or damage in fetus, microcephaly, fetus 3
O35.07X4                        Maternal care for (suspected) central nervous system malformation or damage in fetus, microcephaly, fetus 4
O35.07X5                        Maternal care for (suspected) central nervous system malformation or damage in fetus, microcephaly, fetus 5
O35.07X9                        Maternal care for (suspected) central nervous system malformation or damage in fetus, microcephaly, other fetus
O35.08X0                        Maternal care for (suspected) central nervous system malformation or damage in fetus, spina bifida, not applicable or unspecified
O35.08X1                        Maternal care for (suspected) central nervous system malformation or damage in fetus, spina bifida, fetus 1
O35.08X2                        Maternal care for (suspected) central nervous system malformation or damage in fetus, spina bifida, fetus 2
O35.08X3                        Maternal care for (suspected) central nervous system malformation or damage in fetus, spina bifida, fetus 3
O35.08X4                        Maternal care for (suspected) central nervous system malformation or damage in fetus, spina bifida, fetus 4
O35.08X5                        Maternal care for (suspected) central nervous system malformation or damage in fetus, spina bifida, fetus 5
O35.08X9                        Maternal care for (suspected) central nervous system malformation or damage in fetus, spina bifida, other fetus
O35.09X0                        Maternal care for (suspected) other central nervous system malformation or damage in fetus, not applicable or unspecified
O35.09X1                        Maternal care for (suspected) other central nervous system malformation or damage in fetus, fetus 1
O35.09X2                        Maternal care for (suspected) other central nervous system malformation or damage in fetus, fetus 2
O35.09X3                        Maternal care for (suspected) other central nervous system malformation or damage in fetus, fetus 3
O35.09X4                        Maternal care for (suspected) other central nervous system malformation or damage in fetus, fetus 4
O35.09X5                        Maternal care for (suspected) other central nervous system malformation or damage in fetus, fetus 5
O35.09X9                        Maternal care for (suspected) other central nervous system malformation or damage in fetus, other fetus
O35.10X0                        Maternal care for (suspected) chromosomal abnormality in fetus, unspecified, not applicable or unspecified
O35.10X1                        Maternal care for (suspected) chromosomal abnormality in fetus, unspecified, fetus 1
O35.10X2                        Maternal care for (suspected) chromosomal abnormality in fetus, unspecified, fetus 2
O35.10X3                        Maternal care for (suspected) chromosomal abnormality in fetus, unspecified, fetus 3
O35.10X4                        Maternal care for (suspected) chromosomal abnormality in fetus, unspecified, fetus 4
O35.10X5                        Maternal care for (suspected) chromosomal abnormality in fetus, unspecified, fetus 5
O35.10X9                        Maternal care for (suspected) chromosomal abnormality in fetus, unspecified, other fetus
O35.11X0                        Maternal care for (suspected) chromosomal abnormality in fetus, Trisomy 13, not applicable or unspecified
O35.11X1                        Maternal care for (suspected) chromosomal abnormality in fetus, Trisomy 13, fetus 1
O35.11X2                        Maternal care for (suspected) chromosomal abnormality in fetus, Trisomy 13, fetus 2
O35.11X3                        Maternal care for (suspected) chromosomal abnormality in fetus, Trisomy 13, fetus 3
O35.11X4                        Maternal care for (suspected) chromosomal abnormality in fetus, Trisomy 13, fetus 4
O35.11X5                        Maternal care for (suspected) chromosomal abnormality in fetus, Trisomy 13, fetus 5
O35.11X9                        Maternal care for (suspected) chromosomal abnormality in fetus, Trisomy 13, other fetus
O35.12X0                        Maternal care for (suspected) chromosomal abnormality in fetus, Trisomy 18, not applicable or unspecified
O35.12X1                        Maternal care for (suspected) chromosomal abnormality in fetus, Trisomy 18, fetus 1
O35.12X2                        Maternal care for (suspected) chromosomal abnormality in fetus, Trisomy 18, fetus 2
O35.12X3                        Maternal care for (suspected) chromosomal abnormality in fetus, Trisomy 18, fetus 3
O35.12X4                        Maternal care for (suspected) chromosomal abnormality in fetus, Trisomy 18, fetus 4
O35.12X5                        Maternal care for (suspected) chromosomal abnormality in fetus, Trisomy 18, fetus 5
O35.12X9                        Maternal care for (suspected) chromosomal abnormality in fetus, Trisomy 18, other fetus
O35.13X0                        Maternal care for (suspected) chromosomal abnormality in fetus, Trisomy 21, not applicable or unspecified
O35.13X1                        Maternal care for (suspected) chromosomal abnormality in fetus, Trisomy 21, fetus 1
O35.13X2                        Maternal care for (suspected) chromosomal abnormality in fetus, Trisomy 21, fetus 2
O35.13X3                        Maternal care for (suspected) chromosomal abnormality in fetus, Trisomy 21, fetus 3
O35.13X4                        Maternal care for (suspected) chromosomal abnormality in fetus, Trisomy 21, fetus 4
O35.13X5                        Maternal care for (suspected) chromosomal abnormality in fetus, Trisomy 21, fetus 5
O35.13X9                        Maternal care for (suspected) chromosomal abnormality in fetus, Trisomy 21, other fetus
O35.14X0                        Maternal care for (suspected) chromosomal abnormality in fetus, Turner Syndrome, not applicable or unspecified
O35.14X1                        Maternal care for (suspected) chromosomal abnormality in fetus, Turner Syndrome, fetus 1
O35.14X2                        Maternal care for (suspected) chromosomal abnormality in fetus, Turner Syndrome, fetus 2
O35.14X3                        Maternal care for (suspected) chromosomal abnormality in fetus, Turner Syndrome, fetus 3
O35.14X4                        Maternal care for (suspected) chromosomal abnormality in fetus, Turner Syndrome, fetus 4
O35.14X5                        Maternal care for (suspected) chromosomal abnormality in fetus, Turner Syndrome, fetus 5
O35.14X9                        Maternal care for (suspected) chromosomal abnormality in fetus, Turner Syndrome, other fetus
O35.15X0                        Maternal care for (suspected) chromosomal abnormality in fetus, sex chromosome abnormality, not applicable or unspecified
O35.15X1                        Maternal care for (suspected) chromosomal abnormality in fetus, sex chromosome abnormality, fetus 1
O35.15X2                        Maternal care for (suspected) chromosomal abnormality in fetus, sex chromosome abnormality, fetus 2
O35.15X3                        Maternal care for (suspected) chromosomal abnormality in fetus, sex chromosome abnormality, fetus 3
O35.15X4                        Maternal care for (suspected) chromosomal abnormality in fetus, sex chromosome abnormality, fetus 4
O35.15X5                        Maternal care for (suspected) chromosomal abnormality in fetus, sex chromosome abnormality, fetus 5
O35.15X9                        Maternal care for (suspected) chromosomal abnormality in fetus, sex chromosome abnormality, other fetus
O35.19X0                        Maternal care for (suspected) chromosomal abnormality in fetus, other chromosomal abnormality, not applicable or unspecified
O35.19X1                        Maternal care for (suspected) chromosomal abnormality in fetus, other chromosomal abnormality, fetus 1
O35.19X2                        Maternal care for (suspected) chromosomal abnormality in fetus, other chromosomal abnormality, fetus 2
O35.19X3                        Maternal care for (suspected) chromosomal abnormality in fetus, other chromosomal abnormality, fetus 3
O35.19X4                        Maternal care for (suspected) chromosomal abnormality in fetus, other chromosomal abnormality, fetus 4
O35.19X5                        Maternal care for (suspected) chromosomal abnormality in fetus, other chromosomal abnormality, fetus 5
O35.19X9                        Maternal care for (suspected) chromosomal abnormality in fetus, other chromosomal abnormality, other fetus
O35.AXX0                        Maternal care for other (suspected) fetal abnormality and damage, fetal facial anomalies, not applicable or unspecified
O35.AXX1                        Maternal care for other (suspected) fetal abnormality and damage, fetal facial anomalies, fetus 1
O35.AXX2                        Maternal care for other (suspected) fetal abnormality and damage, fetal facial anomalies, fetus 2
O35.AXX3                        Maternal care for other (suspected) fetal abnormality and damage, fetal facial anomalies, fetus 3
O35.AXX4                        Maternal care for other (suspected) fetal abnormality and damage, fetal facial anomalies, fetus 4
O35.AXX5                        Maternal care for other (suspected) fetal abnormality and damage, fetal facial anomalies, fetus 5
O35.AXX9                        Maternal care for other (suspected) fetal abnormality and damage, fetal facial anomalies, other fetus
O35.BXX0                        Maternal care for other (suspected) fetal abnormality and damage, fetal cardiac anomalies, not applicable or unspecified
O35.BXX1                        Maternal care for other (suspected) fetal abnormality and damage, fetal cardiac anomalies, fetus 1
O35.BXX2                        Maternal care for other (suspected) fetal abnormality and damage, fetal cardiac anomalies, fetus 2
O35.BXX3                        Maternal care for other (suspected) fetal abnormality and damage, fetal cardiac anomalies, fetus 3
O35.BXX4                        Maternal care for other (suspected) fetal abnormality and damage, fetal cardiac anomalies, fetus 4
O35.BXX5                        Maternal care for other (suspected) fetal abnormality and damage, fetal cardiac anomalies, fetus 5
O35.BXX9                        Maternal care for other (suspected) fetal abnormality and damage, fetal cardiac anomalies, other fetus
O35.CXX0                        Maternal care for other (suspected) fetal abnormality and damage, fetal pulmonary anomalies, not applicable or unspecified
O35.CXX1                        Maternal care for other (suspected) fetal abnormality and damage, fetal pulmonary anomalies, fetus 1
O35.CXX2                        Maternal care for other (suspected) fetal abnormality and damage, fetal pulmonary anomalies, fetus 2
O35.CXX3                        Maternal care for other (suspected) fetal abnormality and damage, fetal pulmonary anomalies, fetus 3
O35.CXX4                        Maternal care for other (suspected) fetal abnormality and damage, fetal pulmonary anomalies, fetus 4
O35.CXX5                        Maternal care for other (suspected) fetal abnormality and damage, fetal pulmonary anomalies, fetus 5
O35.CXX9                        Maternal care for other (suspected) fetal abnormality and damage, fetal pulmonary anomalies, other fetus
O35.DXX0                        Maternal care for other (suspected) fetal abnormality and damage, fetal gastrointestinal anomalies, not applicable or unspecified
O35.DXX1                        Maternal care for other (suspected) fetal abnormality and damage, fetal gastrointestinal anomalies, fetus 1
O35.DXX2                        Maternal care for other (suspected) fetal abnormality and damage, fetal gastrointestinal anomalies, fetus 2
O35.DXX3                        Maternal care for other (suspected) fetal abnormality and damage, fetal gastrointestinal anomalies, fetus 3
O35.DXX4                        Maternal care for other (suspected) fetal abnormality and damage, fetal gastrointestinal anomalies, fetus 4
O35.DXX5                        Maternal care for other (suspected) fetal abnormality and damage, fetal gastrointestinal anomalies, fetus 5
O35.DXX9                        Maternal care for other (suspected) fetal abnormality and damage, fetal gastrointestinal anomalies, other fetus
O35.EXX0                        Maternal care for other (suspected) fetal abnormality and damage, fetal genitourinary anomalies, not applicable or unspecified
O35.EXX1                        Maternal care for other (suspected) fetal abnormality and damage, fetal genitourinary anomalies, fetus 1
O35.EXX2                        Maternal care for other (suspected) fetal abnormality and damage, fetal genitourinary anomalies, fetus 2
O35.EXX3                        Maternal care for other (suspected) fetal abnormality and damage, fetal genitourinary anomalies, fetus 3
O35.EXX4                        Maternal care for other (suspected) fetal abnormality and damage, fetal genitourinary anomalies, fetus 4
O35.EXX5                        Maternal care for other (suspected) fetal abnormality and damage, fetal genitourinary anomalies, fetus 5
O35.EXX9                        Maternal care for other (suspected) fetal abnormality and damage, fetal genitourinary anomalies, other fetus
O35.FXX0                        Maternal care for other (suspected) fetal abnormality and damage, fetal musculoskeletal anomalies of trunk, not applicable or unspecified
O35.FXX1                        Maternal care for other (suspected) fetal abnormality and damage, fetal musculoskeletal anomalies of trunk, fetus 1
O35.FXX2                        Maternal care for other (suspected) fetal abnormality and damage, fetal musculoskeletal anomalies of trunk, fetus 2
O35.FXX3                        Maternal care for other (suspected) fetal abnormality and damage, fetal musculoskeletal anomalies of trunk, fetus 3
O35.FXX4                        Maternal care for other (suspected) fetal abnormality and damage, fetal musculoskeletal anomalies of trunk, fetus 4
O35.FXX5                        Maternal care for other (suspected) fetal abnormality and damage, fetal musculoskeletal anomalies of trunk, fetus 5
O35.FXX9                        Maternal care for other (suspected) fetal abnormality and damage, fetal musculoskeletal anomalies of trunk, other fetus
O35.GXX0                        Maternal care for other (suspected) fetal abnormality and damage, fetal upper extremities anomalies, not applicable or unspecified
O35.GXX1                        Maternal care for other (suspected) fetal abnormality and damage, fetal upper extremities anomalies, fetus 1
O35.GXX2                        Maternal care for other (suspected) fetal abnormality and damage, fetal upper extremities anomalies, fetus 2
O35.GXX3                        Maternal care for other (suspected) fetal abnormality and damage, fetal upper extremities anomalies, fetus 3
O35.GXX4                        Maternal care for other (suspected) fetal abnormality and damage, fetal upper extremities anomalies, fetus 4
O35.GXX5                        Maternal care for other (suspected) fetal abnormality and damage, fetal upper extremities anomalies, fetus 5
O35.GXX9                        Maternal care for other (suspected) fetal abnormality and damage, fetal upper extremities anomalies, other fetus
O35.HXX0                        Maternal care for other (suspected) fetal abnormality and damage, fetal lower extremities anomalies, not applicable or unspecified
O35.HXX1                        Maternal care for other (suspected) fetal abnormality and damage, fetal lower extremities anomalies, fetus 1
O35.HXX2                        Maternal care for other (suspected) fetal abnormality and damage, fetal lower extremities anomalies, fetus 2
O35.HXX3                        Maternal care for other (suspected) fetal abnormality and damage, fetal lower extremities anomalies, fetus 3
O35.HXX4                        Maternal care for other (suspected) fetal abnormality and damage, fetal lower extremities anomalies, fetus 4
O35.HXX5                        Maternal care for other (suspected) fetal abnormality and damage, fetal lower extremities anomalies, fetus 5
O35.HXX9                        Maternal care for other (suspected) fetal abnormality and damage, fetal lower extremities anomalies, other fetus
P28.30                          Primary sleep apnea of newborn, unspecified
P28.31                          Primary central sleep apnea of newborn
P28.33                          Primary mixed sleep apnea of newborn
P28.39                          Other primary sleep apnea of newborn
P28.40                          Unspecified apnea of newborn
P28.41                          Central neonatal apnea of newborn
P28.49                          Other apnea of newborn
S06.0XAA                        Concussion with loss of consciousness status unknown, initial encounter
S06.0XAD                        Concussion with loss of consciousness status unknown, subsequent encounter
S06.0XAS                        Concussion with loss of consciousness status unknown, sequela
S06.1XAA                        Traumatic cerebral edema with loss of consciousness status unknown, initial encounter
S06.1XAD                        Traumatic cerebral edema with loss of consciousness status unknown, subsequent encounter
S06.1XAS                        Traumatic cerebral edema with loss of consciousness status unknown, sequela
S06.2XAA                        Diffuse traumatic brain injury with loss of consciousness status unknown, initial encounter
S06.2XAD                        Diffuse traumatic brain injury with loss of consciousness status unknown, subsequent encounter
S06.2XAS                        Diffuse traumatic brain injury with loss of consciousness status unknown, sequela
S06.30AA                        Unspecified focal traumatic brain injury with loss of consciousness status unknown, initial encounter
S06.30AD                        Unspecified focal traumatic brain injury with loss of consciousness status unknown, subsequent encounter
S06.30AS                        Unspecified focal traumatic brain injury with loss of consciousness status unknown, sequela
S06.31AA                        Contusion and laceration of right cerebrum with loss of consciousness status unknown, initial encounter
S06.31AD                        Contusion and laceration of right cerebrum with loss of consciousness status unknown, subsequent encounter
S06.31AS                        Contusion and laceration of right cerebrum with loss of consciousness status unknown, sequela
S06.32AA                        Contusion and laceration of left cerebrum with loss of consciousness status unknown, initial encounter
S06.32AD                        Contusion and laceration of left cerebrum with loss of consciousness status unknown, subsequent encounter
S06.32AS                        Contusion and laceration of left cerebrum with loss of consciousness status unknown, sequela
S06.33AA                        Contusion and laceration of cerebrum, unspecified, with loss of consciousness status unknown, initial encounter
S06.33AD                        Contusion and laceration of cerebrum, unspecified, with loss of consciousness status unknown, subsequent encounter
S06.33AS                        Contusion and laceration of cerebrum, unspecified, with loss of consciousness status unknown, sequela
S06.34AA                        Traumatic hemorrhage of right cerebrum with loss of consciousness status unknown, initial encounter
S06.34AD                        Traumatic hemorrhage of right cerebrum with loss of consciousness status unknown, subsequent encounter
S06.34AS                        Traumatic hemorrhage of right cerebrum with loss of consciousness status unknown, sequela
S06.35AA                        Traumatic hemorrhage of left cerebrum with loss of consciousness status unknown, initial encounter
S06.35AD                        Traumatic hemorrhage of left cerebrum with loss of consciousness status unknown, subsequent encounter
S06.35AS                        Traumatic hemorrhage of left cerebrum with loss of consciousness status unknown, sequela
S06.36AA                        Traumatic hemorrhage of cerebrum, unspecified, with loss of consciousness status unknown, initial encounter
S06.36AD                        Traumatic hemorrhage of cerebrum, unspecified, with loss of consciousness status unknown, subsequent encounter
S06.36AS                        Traumatic hemorrhage of cerebrum, unspecified, with loss of consciousness status unknown, sequela
S06.37AA                        Contusion, laceration, and hemorrhage of cerebellum with loss of consciousness status unknown, initial encounter
S06.37AD                        Contusion, laceration, and hemorrhage of cerebellum with loss of consciousness status unknown, subsequent encounter
S06.37AS                        Contusion, laceration, and hemorrhage of cerebellum with loss of consciousness status unknown, sequela
S06.38AA                        Contusion, laceration, and hemorrhage of brainstem with loss of consciousness status unknown, initial encounter
S06.38AD                        Contusion, laceration, and hemorrhage of brainstem with loss of consciousness status unknown, subsequent encounter
S06.38AS                        Contusion, laceration, and hemorrhage of brainstem with loss of consciousness status unknown, sequela
S06.4XAA                        Epidural hemorrhage with loss of consciousness status unknown, initial encounter
S06.4XAD                        Epidural hemorrhage with loss of consciousness status unknown, subsequent encounter
S06.4XAS                        Epidural hemorrhage with loss of consciousness status unknown, sequela
S06.5XAA                        Traumatic subdural hemorrhage with loss of consciousness status unknown, initial encounter
S06.5XAD                        Traumatic subdural hemorrhage with loss of consciousness status unknown, subsequent encounter
S06.5XAS                        Traumatic subdural hemorrhage with loss of consciousness status unknown, sequela
S06.6XAA                        Traumatic subarachnoid hemorrhage with loss of consciousness status unknown, initial encounter
S06.6XAD                        Traumatic subarachnoid hemorrhage with loss of consciousness status unknown, subsequent encounter
S06.6XAS                        Traumatic subarachnoid hemorrhage with loss of consciousness status unknown, sequela
S06.81AA                        Injury of right internal carotid artery, intracranial portion, not elsewhere classified with loss of consciousness status unknown, initial encounter
S06.81AD                        Injury of right internal carotid artery, intracranial portion, not elsewhere classified with loss of consciousness status unknown, subsequent encounter
S06.81AS                        Injury of right internal carotid artery, intracranial portion, not elsewhere classified with loss of consciousness status unknown, sequela
S06.82AA                        Injury of left internal carotid artery, intracranial portion, not elsewhere classified with loss of consciousness status unknown, initial encounter
S06.82AD                        Injury of left internal carotid artery, intracranial portion, not elsewhere classified with loss of consciousness status unknown, subsequent encounter
S06.82AS                        Injury of left internal carotid artery, intracranial portion, not elsewhere classified with loss of consciousness status unknown, sequela
S06.89AA                        Other specified intracranial injury with loss of consciousness status unknown, initial encounter
S06.89AD                        Other specified intracranial injury with loss of consciousness status unknown, subsequent encounter
S06.89AS                        Other specified intracranial injury with loss of consciousness status unknown, sequela
S06.8A0A                        Primary blast injury of brain, not elsewhere classified without loss of consciousness, initial encounter
S06.8A0D                        Primary blast injury of brain, not elsewhere classified without loss of consciousness, subsequent encounter
S06.8A0S                        Primary blast injury of brain, not elsewhere classified without loss of consciousness, sequela
S06.8A1A                        Primary blast injury of brain, not elsewhere classified with loss of consciousness of 30 minutes or less, initial encounter
S06.8A1D                        Primary blast injury of brain, not elsewhere classified with loss of consciousness of 30 minutes or less, subsequent encounter
S06.8A1S                        Primary blast injury of brain, not elsewhere classified with loss of consciousness of 30 minutes or less, sequela
S06.8A2A                        Primary blast injury of brain, not elsewhere classified with loss of consciousness of 31 minutes to 59 minutes, initial encounter
S06.8A2D                        Primary blast injury of brain, not elsewhere classified with loss of consciousness of 31 minutes to 59 minutes, subsequent encounter
S06.8A2S                        Primary blast injury of brain, not elsewhere classified with loss of consciousness of 31 minutes to 59 minutes, sequela
S06.8A3A                        Primary blast injury of brain, not elsewhere classified with loss of consciousness of 1 hour to 5 hours 59 minutes, initial encounter
S06.8A3D                        Primary blast injury of brain, not elsewhere classified with loss of consciousness of 1 hour to 5 hours 59 minutes, subsequent encounter
S06.8A3S                        Primary blast injury of brain, not elsewhere classified with loss of consciousness of 1 hour to 5 hours 59 minutes, sequela
S06.8A4A                        Primary blast injury of brain, not elsewhere classified with loss of consciousness of 6 hours to 24 hours, initial encounter
S06.8A4D                        Primary blast injury of brain, not elsewhere classified with loss of consciousness of 6 hours to 24 hours, subsequent encounter
S06.8A4S                        Primary blast injury of brain, not elsewhere classified with loss of consciousness of 6 hours to 24 hours, sequela
S06.8A5A                        Primary blast injury of brain, not elsewhere classified with loss of consciousness greater than 24 hours with return to pre-existing conscious level, initial encounter
S06.8A5D                        Primary blast injury of brain, not elsewhere classified with loss of consciousness greater than 24 hours with return to pre-existing conscious level, subsequent encounter
S06.8A5S                        Primary blast injury of brain, not elsewhere classified with loss of consciousness greater than 24 hours with return to pre-existing conscious level, sequela
S06.8A6A                        Primary blast injury of brain, not elsewhere classified with loss of consciousness greater than 24 hours without return to pre-existing conscious level with patient surviving, initial encounter
S06.8A6D                        Primary blast injury of brain, not elsewhere classified with loss of consciousness greater than 24 hours without return to pre-existing conscious level with patient surviving, subsequent encounter
S06.8A6S                        Primary blast injury of brain, not elsewhere classified with loss of consciousness greater than 24 hours without return to pre-existing conscious level with patient surviving, sequela
S06.8A7A                        Primary blast injury of brain, not elsewhere classified with loss of consciousness of any duration with death due to brain injury prior to regaining consciousness, initial encounter
S06.8A8A                        Primary blast injury of brain, not elsewhere classified with loss of consciousness of any duration with death due to other cause prior to regaining consciousness, initial encounter
S06.8A9A                        Primary blast injury of brain, not elsewhere classified with loss of consciousness of unspecified duration, initial encounter
S06.8A9D                        Primary blast injury of brain, not elsewhere classified with loss of consciousness of unspecified duration, subsequent encounter
S06.8A9S                        Primary blast injury of brain, not elsewhere classified with loss of consciousness of unspecified duration, sequela
S06.8AAA                        Primary blast injury of brain, not elsewhere classified with loss of consciousness status unknown, initial encounter
S06.8AAD                        Primary blast injury of brain, not elsewhere classified with loss of consciousness status unknown, subsequent encounter
S06.8AAS                        Primary blast injury of brain, not elsewhere classified with loss of consciousness status unknown, sequela
S06.9XAA                        Unspecified intracranial injury with loss of consciousness status unknown, initial encounter
S06.9XAD                        Unspecified intracranial injury with loss of consciousness status unknown, subsequent encounter
S06.9XAS                        Unspecified intracranial injury with loss of consciousness status unknown, sequela
T43.651A                        Poisoning by methamphetamines accidental (unintentional), initial encounter
T43.651D                        Poisoning by methamphetamines accidental (unintentional), subsequent encounter
T43.651S                        Poisoning by methamphetamines accidental (unintentional), sequela
T43.652A                        Poisoning by methamphetamines intentional self-harm, initial encounter
T43.652D                        Poisoning by methamphetamines intentional self-harm, subsequent encounter
T43.652S                        Poisoning by methamphetamines intentional self-harm, sequela
T43.653A                        Poisoning by methamphetamines, assault, initial encounter
T43.653D                        Poisoning by methamphetamines, assault, subsequent encounter
T43.653S                        Poisoning by methamphetamines, assault, sequela
T43.654A                        Poisoning by methamphetamines, undetermined, initial encounter
T43.654D                        Poisoning by methamphetamines, undetermined, subsequent encounter
T43.654S                        Poisoning by methamphetamines, undetermined, sequela
T43.655A                        Adverse effect of methamphetamines, initial encounter
T43.655D                        Adverse effect of methamphetamines, subsequent encounter
T43.655S                        Adverse effect of methamphetamines, sequela
T43.656A                        Underdosing of methamphetamines, initial encounter
T43.656D                        Underdosing of methamphetamines, subsequent encounter
T43.656S                        Underdosing of methamphetamines, sequela
V20.01XA                        Electric (assisted) bicycle driver injured in collision with pedestrian or animal in nontraffic accident, initial encounter
V20.01XD                        Electric (assisted) bicycle driver injured in collision with pedestrian or animal in nontraffic accident, subsequent encounter
V20.01XS                        Electric (assisted) bicycle driver injured in collision with pedestrian or animal in nontraffic accident, sequela
V20.09XA                        Other motorcycle driver injured in collision with pedestrian or animal in nontraffic accident, initial encounter
V20.09XD                        Other motorcycle driver injured in collision with pedestrian or animal in nontraffic accident, subsequent encounter
V20.09XS                        Other motorcycle driver injured in collision with pedestrian or animal in nontraffic accident, sequela
V20.11XA                        Electric (assisted) bicycle passenger injured in collision with pedestrian or animal in nontraffic accident, initial encounter
V20.11XD                        Electric (assisted) bicycle passenger injured in collision with pedestrian or animal in nontraffic accident, subsequent encounter
V20.11XS                        Electric (assisted) bicycle passenger injured in collision with pedestrian or animal in nontraffic accident, sequela
V20.19XA                        Other motorcycle passenger injured in collision with pedestrian or animal in nontraffic accident, initial encounter
V20.19XD                        Other motorcycle passenger injured in collision with pedestrian or animal in nontraffic accident, subsequent encounter
V20.19XS                        Other motorcycle passenger injured in collision with pedestrian or animal in nontraffic accident, sequela
V20.21XA                        Unspecified electric (assisted) bicycle rider injured in collision with pedestrian or animal in nontraffic accident, initial encounter
V20.21XD                        Unspecified electric (assisted) bicycle rider injured in collision with pedestrian or animal in nontraffic accident, subsequent encounter
V20.21XS                        Unspecified electric (assisted) bicycle rider injured in collision with pedestrian or animal in nontraffic accident, sequela
V20.29XA                        Unspecified rider of other motorcycle injured in collision with pedestrian or animal in nontraffic accident, initial encounter
V20.29XD                        Unspecified rider of other motorcycle injured in collision with pedestrian or animal in nontraffic accident, subsequent encounter
V20.29XS                        Unspecified rider of other motorcycle injured in collision with pedestrian or animal in nontraffic accident, sequela
V20.31XA                        Person boarding or alighting an electric (assisted) bicycle injured in collision with pedestrian or animal, initial encounter
V20.31XD                        Person boarding or alighting an electric (assisted) bicycle injured in collision with pedestrian or animal, subsequent encounter
V20.31XS                        Person boarding or alighting an electric (assisted) bicycle injured in collision with pedestrian or animal, sequela
V20.39XA                        Person boarding or alighting other motorcycle injured in collision with pedestrian or animal, initial encounter
V20.39XD                        Person boarding or alighting other motorcycle injured in collision with pedestrian or animal, subsequent encounter
V20.39XS                        Person boarding or alighting other motorcycle injured in collision with pedestrian or animal, sequela
V20.41XA                        Electric (assisted) bicycle driver injured in collision with pedestrian or animal in traffic accident, initial encounter
V20.41XD                        Electric (assisted) bicycle driver injured in collision with pedestrian or animal in traffic accident, subsequent encounter
V20.41XS                        Electric (assisted) bicycle driver injured in collision with pedestrian or animal in traffic accident, sequela
V20.49XA                        Other motorcycle driver injured in collision with pedestrian or animal in traffic accident, initial encounter
V20.49XD                        Other motorcycle driver injured in collision with pedestrian or animal in traffic accident, subsequent encounter
V20.49XS                        Other motorcycle driver injured in collision with pedestrian or animal in traffic accident, sequela
V20.51XA                        Electric (assisted) bicycle passenger injured in collision with pedestrian or animal in traffic accident, initial encounter
V20.51XD                        Electric (assisted) bicycle passenger injured in collision with pedestrian or animal in traffic accident, subsequent encounter
V20.51XS                        Electric (assisted) bicycle passenger injured in collision with pedestrian or animal in traffic accident, sequela
V20.59XA                        Other motorcycle passenger injured in collision with pedestrian or animal in traffic accident, initial encounter
V20.59XD                        Other motorcycle passenger injured in collision with pedestrian or animal in traffic accident, subsequent encounter
V20.59XS                        Other motorcycle passenger injured in collision with pedestrian or animal in traffic accident, sequela
V20.91XA                        Unspecified electric (assisted) bicycle rider injured in collision with pedestrian or animal in traffic accident, initial encounter
V20.91XD                        Unspecified electric (assisted) bicycle rider injured in collision with pedestrian or animal in traffic accident, subsequent encounter
V20.91XS                        Unspecified electric (assisted) bicycle rider injured in collision with pedestrian or animal in traffic accident, sequela
V20.99XA                        Unspecified rider of other motorcycle injured in collision with pedestrian or animal in traffic accident, initial encounter
V20.99XD                        Unspecified rider of other motorcycle injured in collision with pedestrian or animal in traffic accident, subsequent encounter
V20.99XS                        Unspecified rider of other motorcycle injured in collision with pedestrian or animal in traffic accident, sequela
V21.01XA                        Electric (assisted) bicycle driver injured in collision with pedal cycle in nontraffic accident, initial encounter
V21.01XD                        Electric (assisted) bicycle driver injured in collision with pedal cycle in nontraffic accident, subsequent encounter
V21.01XS                        Electric (assisted) bicycle driver injured in collision with pedal cycle in nontraffic accident, sequela
V21.09XA                        Other motorcycle driver injured in collision with pedal cycle in nontraffic accident, initial encounter
V21.09XD                        Other motorcycle driver injured in collision with pedal cycle in nontraffic accident, subsequent encounter
V21.09XS                        Other motorcycle driver injured in collision with pedal cycle in nontraffic accident, sequela
V21.11XA                        Electric (assisted) bicycle passenger injured in collision with pedal cycle in nontraffic accident, initial encounter
V21.11XD                        Electric (assisted) bicycle passenger injured in collision with pedal cycle in nontraffic accident, subsequent encounter
V21.11XS                        Electric (assisted) bicycle passenger injured in collision with pedal cycle in nontraffic accident, sequela
V21.19XA                        Other motorcycle passenger injured in collision with pedal cycle in nontraffic accident, initial encounter
V21.19XD                        Other motorcycle passenger injured in collision with pedal cycle in nontraffic accident, subsequent encounter
V21.19XS                        Other motorcycle passenger injured in collision with pedal cycle in nontraffic accident, sequela
V21.21XA                        Unspecified electric (assisted) bicycle rider injured in collision with pedal cycle in nontraffic accident, initial encounter
V21.21XD                        Unspecified electric (assisted) bicycle rider injured in collision with pedal cycle in nontraffic accident, subsequent encounter
V21.21XS                        Unspecified electric (assisted) bicycle rider injured in collision with pedal cycle in nontraffic accident, sequela
V21.29XA                        Unspecified rider of other motorcycle injured in collision with pedal cycle in nontraffic accident, initial encounter
V21.29XD                        Unspecified rider of other motorcycle injured in collision with pedal cycle in nontraffic accident, subsequent encounter
V21.29XS                        Unspecified rider of other motorcycle injured in collision with pedal cycle in nontraffic accident, sequela
V21.31XA                        Person boarding or alighting an electric (assisted) bicycle injured in collision with pedal cycle, initial encounter
V21.31XD                        Person boarding or alighting an electric (assisted) bicycle injured in collision with pedal cycle, subsequent encounter
V21.31XS                        Person boarding or alighting an electric (assisted) bicycle injured in collision with pedal cycle, sequela
V21.39XA                        Person boarding or alighting other motorcycle injured in collision with pedal cycle, initial encounter
V21.39XD                        Person boarding or alighting other motorcycle injured in collision with pedal cycle, subsequent encounter
V21.39XS                        Person boarding or alighting other motorcycle injured in collision with pedal cycle, sequela
V21.41XA                        Electric (assisted) bicycle driver injured in collision with pedal cycle in traffic accident, initial encounter
V21.41XD                        Electric (assisted) bicycle driver injured in collision with pedal cycle in traffic accident, subsequent encounter
V21.41XS                        Electric (assisted) bicycle driver injured in collision with pedal cycle in traffic accident, sequela
V21.49XA                        Other motorcycle driver injured in collision with pedal cycle in traffic accident, initial encounter
V21.49XD                        Other motorcycle driver injured in collision with pedal cycle in traffic accident, subsequent encounter
V21.49XS                        Other motorcycle driver injured in collision with pedal cycle in traffic accident, sequela
V21.51XA                        Electric (assisted) bicycle passenger injured in collision with pedal cycle in traffic accident, initial encounter
V21.51XD                        Electric (assisted) bicycle passenger injured in collision with pedal cycle in traffic accident, subsequent encounter
V21.51XS                        Electric (assisted) bicycle passenger injured in collision with pedal cycle in traffic accident, sequela
V21.59XA                        Other motorcycle passenger injured in collision with pedal cycle in traffic accident, initial encounter
V21.59XD                        Other motorcycle passenger injured in collision with pedal cycle in traffic accident, subsequent encounter
V21.59XS                        Other motorcycle passenger injured in collision with pedal cycle in traffic accident, sequela
V21.91XA                        Unspecified electric (assisted) bicycle rider injured in collision with pedal cycle in traffic accident, initial encounter
V21.91XD                        Unspecified electric (assisted) bicycle rider injured in collision with pedal cycle in traffic accident, subsequent encounter
V21.91XS                        Unspecified electric (assisted) bicycle rider injured in collision with pedal cycle in traffic accident, sequela
V21.99XA                        Unspecified rider of other motorcycle injured in collision with pedal cycle in traffic accident, initial encounter
V21.99XD                        Unspecified rider of other motorcycle injured in collision with pedal cycle in traffic accident, subsequent encounter
V21.99XS                        Unspecified rider of other motorcycle injured in collision with pedal cycle in traffic accident, sequela
V22.01XA                        Electric (assisted) bicycle driver injured in collision with two- or three-wheeled motor vehicle in nontraffic accident, initial encounter
V22.01XD                        Electric (assisted) bicycle driver injured in collision with two- or three-wheeled motor vehicle in nontraffic accident, subsequent encounter
V22.01XS                        Electric (assisted) bicycle driver injured in collision with two- or three-wheeled motor vehicle in nontraffic accident, sequela
V22.09XA                        Other motorcycle driver injured in collision with two- or three-wheeled motor vehicle in nontraffic accident, initial encounter
V22.09XD                        Other motorcycle driver injured in collision with two- or three-wheeled motor vehicle in nontraffic accident, subsequent encounter
V22.09XS                        Other motorcycle driver injured in collision with two- or three-wheeled motor vehicle in nontraffic accident, sequela
V22.11XA                        Electric (assisted) bicycle passenger injured in collision with two- or three-wheeled motor vehicle in nontraffic accident, initial encounter
V22.11XD                        Electric (assisted) bicycle passenger injured in collision with two- or three-wheeled motor vehicle in nontraffic accident, subsequent encounter
V22.11XS                        Electric (assisted) bicycle passenger injured in collision with two- or three-wheeled motor vehicle in nontraffic accident, sequela
V22.19XA                        Other motorcycle passenger injured in collision with two- or three-wheeled motor vehicle in nontraffic accident, initial encounter
V22.19XD                        Other motorcycle passenger injured in collision with two- or three-wheeled motor vehicle in nontraffic accident, subsequent encounter
V22.19XS                        Other motorcycle passenger injured in collision with two- or three-wheeled motor vehicle in nontraffic accident, sequela
V22.21XA                        Unspecified electric (assisted) bicycle rider injured in collision with two- or three-wheeled motor vehicle in nontraffic accident, initial encounter
V22.21XD                        Unspecified electric (assisted) bicycle rider injured in collision with two- or three-wheeled motor vehicle in nontraffic accident, subsequent encounter
V22.21XS                        Unspecified electric (assisted) bicycle rider injured in collision with two- or three-wheeled motor vehicle in nontraffic accident, sequela
V22.29XA                        Unspecified rider of other motorcycle injured in collision with two- or three-wheeled motor vehicle in nontraffic accident, initial encounter
V22.29XD                        Unspecified rider of other motorcycle injured in collision with two- or three-wheeled motor vehicle in nontraffic accident, subsequent encounter
V22.29XS                        Unspecified rider of other motorcycle injured in collision with two- or three-wheeled motor vehicle in nontraffic accident, sequela
V22.31XA                        Person boarding or alighting an electric (assisted) bicycle injured in collision with two- or three-wheeled motor vehicle, initial encounter
V22.31XD                        Person boarding or alighting an electric (assisted) bicycle injured in collision with two- or three-wheeled motor vehicle, subsequent encounter
V22.31XS                        Person boarding or alighting an electric (assisted) bicycle injured in collision with two- or three-wheeled motor vehicle, sequela
V22.39XA                        Person boarding or alighting other motorcycle injured in collision with two- or three-wheeled motor vehicle, initial encounter
V22.39XD                        Person boarding or alighting other motorcycle injured in collision with two- or three-wheeled motor vehicle, subsequent encounter
V22.39XS                        Person boarding or alighting other motorcycle injured in collision with two- or three-wheeled motor vehicle, sequela
V22.41XA                        Electric (assisted) bicycle driver injured in collision with two- or three-wheeled motor vehicle in traffic accident, initial encounter
V22.41XD                        Electric (assisted) bicycle driver injured in collision with two- or three-wheeled motor vehicle in traffic accident, subsequent encounter
V22.41XS                        Electric (assisted) bicycle driver injured in collision with two- or three-wheeled motor vehicle in traffic accident, sequela
V22.49XA                        Other motorcycle driver injured in collision with two- or three-wheeled motor vehicle in traffic accident, initial encounter
V22.49XD                        Other motorcycle driver injured in collision with two- or three-wheeled motor vehicle in traffic accident, subsequent encounter
V22.49XS                        Other motorcycle driver injured in collision with two- or three-wheeled motor vehicle in traffic accident, sequela
V22.51XA                        Electric (assisted) bicycle passenger injured in collision with two- or three-wheeled motor vehicle in traffic accident, initial encounter
V22.51XD                        Electric (assisted) bicycle passenger injured in collision with two- or three-wheeled motor vehicle in traffic accident, subsequent encounter
V22.51XS                        Electric (assisted) bicycle passenger injured in collision with two- or three-wheeled motor vehicle in traffic accident, sequela
V22.59XA                        Other motorcycle passenger injured in collision with two- or three-wheeled motor vehicle in traffic accident, initial encounter
V22.59XD                        Other motorcycle passenger injured in collision with two- or three-wheeled motor vehicle in traffic accident, subsequent encounter
V22.59XS                        Other motorcycle passenger injured in collision with two- or three-wheeled motor vehicle in traffic accident, sequela
V22.91XA                        Unspecified electric (assisted) bicycle rider injured in collision with two- or three-wheeled motor vehicle in traffic accident, initial encounter
V22.91XD                        Unspecified electric (assisted) bicycle rider injured in collision with two- or three-wheeled motor vehicle in traffic accident, subsequent encounter
V22.91XS                        Unspecified electric (assisted) bicycle rider injured in collision with two- or three-wheeled motor vehicle in traffic accident, sequela
V22.99XA                        Unspecified rider of other motorcycle injured in collision with two- or three-wheeled motor vehicle in traffic accident, initial encounter
V22.99XD                        Unspecified rider of other motorcycle injured in collision with two- or three-wheeled motor vehicle in traffic accident, subsequent encounter
V22.99XS                        Unspecified rider of other motorcycle injured in collision with two- or three-wheeled motor vehicle in traffic accident, sequela
V23.01XA                        Electric (assisted) bicycle driver injured in collision with car, pick-up truck or van in nontraffic accident, initial encounter
V23.01XD                        Electric (assisted) bicycle driver injured in collision with car, pick-up truck or van in nontraffic accident, subsequent encounter
V23.01XS                        Electric (assisted) bicycle driver injured in collision with car, pick-up truck or van in nontraffic accident, sequela
V23.09XA                        Other motorcycle driver injured in collision with car, pick-up truck or van in nontraffic accident, initial encounter
V23.09XD                        Other motorcycle driver injured in collision with car, pick-up truck or van in nontraffic accident, subsequent encounter
V23.09XS                        Other motorcycle driver injured in collision with car, pick-up truck or van in nontraffic accident, sequela
V23.11XA                        Electric (assisted) bicycle passenger injured in collision with car, pick-up truck or van in nontraffic accident, initial encounter
V23.11XD                        Electric (assisted) bicycle passenger injured in collision with car, pick-up truck or van in nontraffic accident, subsequent encounter
V23.11XS                        Electric (assisted) bicycle passenger injured in collision with car, pick-up truck or van in nontraffic accident, sequela
V23.19XA                        Other motorcycle passenger injured in collision with car, pick-up truck or van in nontraffic accident, initial encounter
V23.19XD                        Other motorcycle passenger injured in collision with car, pick-up truck or van in nontraffic accident, subsequent encounter
V23.19XS                        Other motorcycle passenger injured in collision with car, pick-up truck or van in nontraffic accident, sequela
V23.21XA                        Unspecified electric (assisted) bicycle rider injured in collision with car, pick-up truck or van in nontraffic accident, initial encounter
V23.21XD                        Unspecified electric (assisted) bicycle rider injured in collision with car, pick-up truck or van in nontraffic accident, subsequent encounter
V23.21XS                        Unspecified electric (assisted) bicycle rider injured in collision with car, pick-up truck or van in nontraffic accident, sequela
V23.29XA                        Unspecified rider of other motorcycle injured in collision with car, pick-up truck or van in nontraffic accident, initial encounter
V23.29XD                        Unspecified rider of other motorcycle injured in collision with car, pick-up truck or van in nontraffic accident, subsequent encounter
V23.29XS                        Unspecified rider of other motorcycle injured in collision with car, pick-up truck or van in nontraffic accident, sequela
V23.31XA                        Person boarding or alighting an electric (assisted) bicycle injured in collision with car, pick-up truck or van, initial encounter
V23.31XD                        Person boarding or alighting an electric (assisted) bicycle injured in collision with car, pick-up truck or van, subsequent encounter
V23.31XS                        Person boarding or alighting an electric (assisted) bicycle injured in collision with car, pick-up truck or van, sequela
V23.39XA                        Person boarding or alighting other motorcycle injured in collision with car, pick-up truck or van, initial encounter
V23.39XD                        Person boarding or alighting other motorcycle injured in collision with car, pick-up truck or van, subsequent encounter
V23.39XS                        Person boarding or alighting other motorcycle injured in collision with car, pick-up truck or van, sequela
V23.41XA                        Electric (assisted) bicycle driver injured in collision with car, pick-up truck or van in traffic accident, initial encounter
V23.41XD                        Electric (assisted) bicycle driver injured in collision with car, pick-up truck or van in traffic accident, subsequent encounter
V23.41XS                        Electric (assisted) bicycle driver injured in collision with car, pick-up truck or van in traffic accident, sequela
V23.49XA                        Other motorcycle driver injured in collision with car, pick-up truck or van in traffic accident, initial encounter
V23.49XD                        Other motorcycle driver injured in collision with car, pick-up truck or van in traffic accident, subsequent encounter
V23.49XS                        Other motorcycle driver injured in collision with car, pick-up truck or van in traffic accident, sequela
V23.51XA                        Electric (assisted) bicycle passenger injured in collision with car, pick-up truck or van in traffic accident, initial encounter
V23.51XD                        Electric (assisted) bicycle passenger injured in collision with car, pick-up truck or van in traffic accident, subsequent encounter
V23.51XS                        Electric (assisted) bicycle passenger injured in collision with car, pick-up truck or van in traffic accident, sequela
V23.59XA                        Other motorcycle passenger injured in collision with car, pick-up truck or van in traffic accident, initial encounter
V23.59XD                        Other motorcycle passenger injured in collision with car, pick-up truck or van in traffic accident, subsequent encounter
V23.59XS                        Other motorcycle passenger injured in collision with car, pick-up truck or van in traffic accident, sequela
V23.91XA                        Unspecified electric (assisted) bicycle rider injured in collision with car, pick-up truck or van in traffic accident, initial encounter
V23.91XD                        Unspecified electric (assisted) bicycle rider injured in collision with car, pick-up truck or van in traffic accident, subsequent encounter
V23.91XS                        Unspecified electric (assisted) bicycle rider injured in collision with car, pick-up truck or van in traffic accident, sequela
V23.99XA                        Unspecified rider of other motorcycle injured in collision with car, pick-up truck or van in traffic accident, initial encounter
V23.99XD                        Unspecified rider of other motorcycle injured in collision with car, pick-up truck or van in traffic accident, subsequent encounter
V23.99XS                        Unspecified rider of other motorcycle injured in collision with car, pick-up truck or van in traffic accident, sequela
V24.01XA                        Electric (assisted) bicycle driver injured in collision with heavy transport vehicle or bus in nontraffic accident, initial encounter
V24.01XD                        Electric (assisted) bicycle driver injured in collision with heavy transport vehicle or bus in nontraffic accident, subsequent encounter
V24.01XS                        Electric (assisted) bicycle driver injured in collision with heavy transport vehicle or bus in nontraffic accident, sequela
V24.09XA                        Other motorcycle driver injured in collision with heavy transport vehicle or bus in nontraffic accident, initial encounter
V24.09XD                        Other motorcycle driver injured in collision with heavy transport vehicle or bus in nontraffic accident, subsequent encounter
V24.09XS                        Other motorcycle driver injured in collision with heavy transport vehicle or bus in nontraffic accident, sequela
V24.11XA                        Electric (assisted) bicycle passenger injured in collision with heavy transport vehicle or bus in nontraffic accident, initial encounter
V24.11XD                        Electric (assisted) bicycle passenger injured in collision with heavy transport vehicle or bus in nontraffic accident, subsequent encounter
V24.11XS                        Electric (assisted) bicycle passenger injured in collision with heavy transport vehicle or bus in nontraffic accident, sequela
V24.19XA                        Other motorcycle passenger injured in collision with heavy transport vehicle or bus in nontraffic accident, initial encounter
V24.19XD                        Other motorcycle passenger injured in collision with heavy transport vehicle or bus in nontraffic accident, subsequent encounter
V24.19XS                        Other motorcycle passenger injured in collision with heavy transport vehicle or bus in nontraffic accident, sequela
V24.21XA                        Unspecified electric (assisted) bicycle rider injured in collision with heavy transport vehicle or bus in nontraffic accident, initial encounter
V24.21XD                        Unspecified electric (assisted) bicycle rider injured in collision with heavy transport vehicle or bus in nontraffic accident, subsequent encounter
V24.21XS                        Unspecified electric (assisted) bicycle rider injured in collision with heavy transport vehicle or bus in nontraffic accident, sequela
V24.29XA                        Unspecified rider of other motorcycle injured in collision with heavy transport vehicle or bus in nontraffic accident, initial encounter
V24.29XD                        Unspecified rider of other motorcycle injured in collision with heavy transport vehicle or bus in nontraffic accident, subsequent encounter
V24.29XS                        Unspecified rider of other motorcycle injured in collision with heavy transport vehicle or bus in nontraffic accident, sequela
V24.31XA                        Person boarding or alighting an electric (assisted) bicycle injured in collision with heavy transport vehicle or bus, initial encounter
V24.31XD                        Person boarding or alighting an electric (assisted) bicycle injured in collision with heavy transport vehicle or bus, subsequent encounter
V24.31XS                        Person boarding or alighting an electric (assisted) bicycle injured in collision with heavy transport vehicle or bus, sequela
V24.39XA                        Person boarding or alighting other motorcycle injured in collision with heavy transport vehicle or bus, initial encounter
V24.39XD                        Person boarding or alighting other motorcycle injured in collision with heavy transport vehicle or bus, subsequent encounter
V24.39XS                        Person boarding or alighting other motorcycle injured in collision with heavy transport vehicle or bus, sequela
V24.41XA                        Electric (assisted) bicycle driver injured in collision with heavy transport vehicle or bus in traffic accident, initial encounter
V24.41XD                        Electric (assisted) bicycle driver injured in collision with heavy transport vehicle or bus in traffic accident, subsequent encounter
V24.41XS                        Electric (assisted) bicycle driver injured in collision with heavy transport vehicle or bus in traffic accident, sequela
V24.49XA                        Other motorcycle driver injured in collision with heavy transport vehicle or bus in traffic accident, initial encounter
V24.49XD                        Other motorcycle driver injured in collision with heavy transport vehicle or bus in traffic accident, subsequent encounter
V24.49XS                        Other motorcycle driver injured in collision with heavy transport vehicle or bus in traffic accident, sequela
V24.51XA                        Electric (assisted) bicycle passenger injured in collision with heavy transport vehicle or bus in traffic accident, initial encounter
V24.51XD                        Electric (assisted) bicycle passenger injured in collision with heavy transport vehicle or bus in traffic accident, subsequent encounter
V24.51XS                        Electric (assisted) bicycle passenger injured in collision with heavy transport vehicle or bus in traffic accident, sequela
V24.59XA                        Other motorcycle passenger injured in collision with heavy transport vehicle or bus in traffic accident, initial encounter
V24.59XD                        Other motorcycle passenger injured in collision with heavy transport vehicle or bus in traffic accident, subsequent encounter
V24.59XS                        Other motorcycle passenger injured in collision with heavy transport vehicle or bus in traffic accident, sequela
V24.91XA                        Unspecified electric (assisted) bicycle rider injured in collision with heavy transport vehicle or bus in traffic accident, initial encounter
V24.91XD                        Unspecified electric (assisted) bicycle rider injured in collision with heavy transport vehicle or bus in traffic accident, subsequent encounter
V24.91XS                        Unspecified electric (assisted) bicycle rider injured in collision with heavy transport vehicle or bus in traffic accident, sequela
V24.99XA                        Unspecified rider of other motorcycle injured in collision with heavy transport vehicle or bus in traffic accident, initial encounter
V24.99XD                        Unspecified rider of other motorcycle injured in collision with heavy transport vehicle or bus in traffic accident, subsequent encounter
V24.99XS                        Unspecified rider of other motorcycle injured in collision with heavy transport vehicle or bus in traffic accident, sequela
V25.01XA                        Electric (assisted) bicycle driver injured in collision with railway train or railway vehicle in nontraffic accident, initial encounter
V25.01XD                        Electric (assisted) bicycle driver injured in collision with railway train or railway vehicle in nontraffic accident, subsequent encounter
V25.01XS                        Electric (assisted) bicycle driver injured in collision with railway train or railway vehicle in nontraffic accident, sequela
V25.09XA                        Other motorcycle driver injured in collision with railway train or railway vehicle in nontraffic accident, initial encounter
V25.09XD                        Other motorcycle driver injured in collision with railway train or railway vehicle in nontraffic accident, subsequent encounter
V25.09XS                        Other motorcycle driver injured in collision with railway train or railway vehicle in nontraffic accident, sequela
V25.11XA                        Electric (assisted) bicycle passenger injured in collision with railway train or railway vehicle in nontraffic accident, initial encounter
V25.11XD                        Electric (assisted) bicycle passenger injured in collision with railway train or railway vehicle in nontraffic accident, subsequent encounter
V25.11XS                        Electric (assisted) bicycle passenger injured in collision with railway train or railway vehicle in nontraffic accident, sequela
V25.19XA                        Other motorcycle passenger injured in collision with railway train or railway vehicle in nontraffic accident, initial encounter
V25.19XD                        Other motorcycle passenger injured in collision with railway train or railway vehicle in nontraffic accident, subsequent encounter
V25.19XS                        Other motorcycle passenger injured in collision with railway train or railway vehicle in nontraffic accident, sequela
V25.21XA                        Unspecified electric (assisted) bicycle rider injured in collision with railway train or railway vehicle in nontraffic accident, initial encounter
V25.21XD                        Unspecified electric (assisted) bicycle rider injured in collision with railway train or railway vehicle in nontraffic accident, subsequent encounter
V25.21XS                        Unspecified electric (assisted) bicycle rider injured in collision with railway train or railway vehicle in nontraffic accident, sequela
V25.29XA                        Unspecified rider of other motorcycle injured in collision with railway train or railway vehicle in nontraffic accident, initial encounter
V25.29XD                        Unspecified rider of other motorcycle injured in collision with railway train or railway vehicle in nontraffic accident, subsequent encounter
V25.29XS                        Unspecified rider of other motorcycle injured in collision with railway train or railway vehicle in nontraffic accident, sequela
V25.31XA                        Person boarding or alighting an electric (assisted) bicycle injured in collision with railway train or railway vehicle, initial encounter
V25.31XD                        Person boarding or alighting an electric (assisted) bicycle injured in collision with railway train or railway vehicle, subsequent encounter
V25.31XS                        Person boarding or alighting an electric (assisted) bicycle injured in collision with railway train or railway vehicle, sequela
V25.39XA                        Person boarding or alighting other motorcycle injured in collision with railway train or railway vehicle, initial encounter
V25.39XD                        Person boarding or alighting other motorcycle injured in collision with railway train or railway vehicle, subsequent encounter
V25.39XS                        Person boarding or alighting other motorcycle injured in collision with railway train or railway vehicle, sequela
V25.41XA                        Electric (assisted) bicycle driver injured in collision with railway train or railway vehicle in traffic accident, initial encounter
V25.41XD                        Electric (assisted) bicycle driver injured in collision with railway train or railway vehicle in traffic accident, subsequent encounter
V25.41XS                        Electric (assisted) bicycle driver injured in collision with railway train or railway vehicle in traffic accident, sequela
V25.49XA                        Other motorcycle driver injured in collision with railway train or railway vehicle in traffic accident, initial encounter
V25.49XD                        Other motorcycle driver injured in collision with railway train or railway vehicle in traffic accident, subsequent encounter
V25.49XS                        Other motorcycle driver injured in collision with railway train or railway vehicle in traffic accident, sequela
V25.51XA                        Electric (assisted) bicycle passenger injured in collision with railway train or railway vehicle in traffic accident, initial encounter
V25.51XD                        Electric (assisted) bicycle passenger injured in collision with railway train or railway vehicle in traffic accident, subsequent encounter
V25.51XS                        Electric (assisted) bicycle passenger injured in collision with railway train or railway vehicle in traffic accident, sequela
V25.59XA                        Other motorcycle passenger injured in collision with railway train or railway vehicle in traffic accident, initial encounter
V25.59XD                        Other motorcycle passenger injured in collision with railway train or railway vehicle in traffic accident, subsequent encounter
V25.59XS                        Other motorcycle passenger injured in collision with railway train or railway vehicle in traffic accident, sequela
V25.91XA                        Unspecified electric (assisted) bicycle rider injured in collision with railway train or railway vehicle in traffic accident, initial encounter
V25.91XD                        Unspecified electric (assisted) bicycle rider injured in collision with railway train or railway vehicle in traffic accident, subsequent encounter
V25.91XS                        Unspecified electric (assisted) bicycle rider injured in collision with railway train or railway vehicle in traffic accident, sequela
V25.99XA                        Unspecified rider of other motorcycle injured in collision with railway train or railway vehicle in traffic accident, initial encounter
V25.99XD                        Unspecified rider of other motorcycle injured in collision with railway train or railway vehicle in traffic accident, subsequent encounter
V25.99XS                        Unspecified rider of other motorcycle injured in collision with railway train or railway vehicle in traffic accident, sequela
V26.01XA                        Electric (assisted) bicycle driver injured in collision with other nonmotor vehicle in nontraffic accident, initial encounter
V26.01XD                        Electric (assisted) bicycle driver injured in collision with other nonmotor vehicle in nontraffic accident, subsequent encounter
V26.01XS                        Electric (assisted) bicycle driver injured in collision with other nonmotor vehicle in nontraffic accident, sequela
V26.09XA                        Other motorcycle driver injured in collision with other nonmotor vehicle in nontraffic accident, initial encounter
V26.09XD                        Other motorcycle driver injured in collision with other nonmotor vehicle in nontraffic accident, subsequent encounter
V26.09XS                        Other motorcycle driver injured in collision with other nonmotor vehicle in nontraffic accident, sequela
V26.11XA                        Electric (assisted) bicycle passenger injured in collision with other nonmotor vehicle in nontraffic accident, initial encounter
V26.11XD                        Electric (assisted) bicycle passenger injured in collision with other nonmotor vehicle in nontraffic accident, subsequent encounter
V26.11XS                        Electric (assisted) bicycle passenger injured in collision with other nonmotor vehicle in nontraffic accident, sequela
V26.19XA                        Other motorcycle passenger injured in collision with other nonmotor vehicle in nontraffic accident, initial encounter
V26.19XD                        Other motorcycle passenger injured in collision with other nonmotor vehicle in nontraffic accident, subsequent encounter
V26.19XS                        Other motorcycle passenger injured in collision with other nonmotor vehicle in nontraffic accident, sequela
V26.21XA                        Unspecified electric (assisted) bicycle rider injured in collision with other nonmotor vehicle in nontraffic accident, initial encounter
V26.21XD                        Unspecified electric (assisted) bicycle rider injured in collision with other nonmotor vehicle in nontraffic accident, subsequent encounter
V26.21XS                        Unspecified electric (assisted) bicycle rider injured in collision with other nonmotor vehicle in nontraffic accident, sequela
V26.29XA                        Unspecified rider of other motorcycle injured in collision with other nonmotor vehicle in nontraffic accident, initial encounter
V26.29XD                        Unspecified rider of other motorcycle injured in collision with other nonmotor vehicle in nontraffic accident, subsequent encounter
V26.29XS                        Unspecified rider of other motorcycle injured in collision with other nonmotor vehicle in nontraffic accident, sequela
V26.31XA                        Person boarding or alighting an electric (assisted) bicycle injured in collision with other nonmotor vehicle, initial encounter
V26.31XD                        Person boarding or alighting an electric (assisted) bicycle injured in collision with other nonmotor vehicle, subsequent encounter
V26.31XS                        Person boarding or alighting an electric (assisted) bicycle injured in collision with other nonmotor vehicle, sequela
V26.39XA                        Person boarding or alighting other motorcycle injured in collision with other nonmotor vehicle, initial encounter
V26.39XD                        Person boarding or alighting other motorcycle injured in collision with other nonmotor vehicle, subsequent encounter
V26.39XS                        Person boarding or alighting other motorcycle injured in collision with other nonmotor vehicle, sequela
V26.41XA                        Electric (assisted) bicycle driver injured in collision with other nonmotor vehicle in traffic accident, initial encounter
V26.41XD                        Electric (assisted) bicycle driver injured in collision with other nonmotor vehicle in traffic accident, subsequent encounter
V26.41XS                        Electric (assisted) bicycle driver injured in collision with other nonmotor vehicle in traffic accident, sequela
V26.49XA                        Other motorcycle driver injured in collision with other nonmotor vehicle in traffic accident, initial encounter
V26.49XD                        Other motorcycle driver injured in collision with other nonmotor vehicle in traffic accident, subsequent encounter
V26.49XS                        Other motorcycle driver injured in collision with other nonmotor vehicle in traffic accident, sequela
V26.51XA                        Electric (assisted) bicycle passenger injured in collision with other nonmotor vehicle in traffic accident, initial encounter
V26.51XD                        Electric (assisted) bicycle passenger injured in collision with other nonmotor vehicle in traffic accident, subsequent encounter
V26.51XS                        Electric (assisted) bicycle passenger injured in collision with other nonmotor vehicle in traffic accident, sequela
V26.59XA                        Other motorcycle passenger injured in collision with other nonmotor vehicle in traffic accident, initial encounter
V26.59XD                        Other motorcycle passenger injured in collision with other nonmotor vehicle in traffic accident, subsequent encounter
V26.59XS                        Other motorcycle passenger injured in collision with other nonmotor vehicle in traffic accident, sequela
V26.91XA                        Unspecified electric (assisted) bicycle rider injured in collision with other nonmotor vehicle in traffic accident, initial encounter
V26.91XD                        Unspecified electric (assisted) bicycle rider injured in collision with other nonmotor vehicle in traffic accident, subsequent encounter
V26.91XS                        Unspecified electric (assisted) bicycle rider injured in collision with other nonmotor vehicle in traffic accident, sequela
V26.99XA                        Unspecified rider of other motorcycle injured in collision with other nonmotor vehicle in traffic accident, initial encounter
V26.99XD                        Unspecified rider of other motorcycle injured in collision with other nonmotor vehicle in traffic accident, subsequent encounter
V26.99XS                        Unspecified rider of other motorcycle injured in collision with other nonmotor vehicle in traffic accident, sequela
V27.01XA                        Electric (assisted) bicycle driver injured in collision with fixed or stationary object in nontraffic accident, initial encounter
V27.01XD                        Electric (assisted) bicycle driver injured in collision with fixed or stationary object in nontraffic accident, subsequent encounter
V27.01XS                        Electric (assisted) bicycle driver injured in collision with fixed or stationary object in nontraffic accident, sequela
V27.09XA                        Other motorcycle driver injured in collision with fixed or stationary object in nontraffic accident, initial encounter
V27.09XD                        Other motorcycle driver injured in collision with fixed or stationary object in nontraffic accident, subsequent encounter
V27.09XS                        Other motorcycle driver injured in collision with fixed or stationary object in nontraffic accident, sequela
V27.11XA                        Electric (assisted) bicycle passenger injured in collision with fixed or stationary object in nontraffic accident, initial encounter
V27.11XD                        Electric (assisted) bicycle passenger injured in collision with fixed or stationary object in nontraffic accident, subsequent encounter
V27.11XS                        Electric (assisted) bicycle passenger injured in collision with fixed or stationary object in nontraffic accident, sequela
V27.19XA                        Other motorcycle passenger injured in collision with fixed or stationary object in nontraffic accident, initial encounter
V27.19XD                        Other motorcycle passenger injured in collision with fixed or stationary object in nontraffic accident, subsequent encounter
V27.19XS                        Other motorcycle passenger injured in collision with fixed or stationary object in nontraffic accident, sequela
V27.21XA                        Unspecified electric (assisted) bicycle rider injured in collision with fixed or stationary object in nontraffic accident, initial encounter
V27.21XD                        Unspecified electric (assisted) bicycle rider injured in collision with fixed or stationary object in nontraffic accident, subsequent encounter
V27.21XS                        Unspecified electric (assisted) bicycle rider injured in collision with fixed or stationary object in nontraffic accident, sequela
V27.29XA                        Unspecified rider of other motorcycle injured in collision with fixed or stationary object in nontraffic accident, initial encounter
V27.29XD                        Unspecified rider of other motorcycle injured in collision with fixed or stationary object in nontraffic accident, subsequent encounter
V27.29XS                        Unspecified rider of other motorcycle injured in collision with fixed or stationary object in nontraffic accident, sequela
V27.31XA                        Person boarding or alighting an electric (assisted) bicycle injured in collision with fixed or stationary object, initial encounter
V27.31XD                        Person boarding or alighting an electric (assisted) bicycle injured in collision with fixed or stationary object, subsequent encounter
V27.31XS                        Person boarding or alighting an electric (assisted) bicycle injured in collision with fixed or stationary object, sequela
V27.39XA                        Person boarding or alighting other motorcycle injured in collision with fixed or stationary object, initial encounter
V27.39XD                        Person boarding or alighting other motorcycle injured in collision with fixed or stationary object, subsequent encounter
V27.39XS                        Person boarding or alighting other motorcycle injured in collision with fixed or stationary object, sequela
V27.41XA                        Electric (assisted) bicycle driver injured in collision with fixed or stationary object in traffic accident, initial encounter
V27.41XD                        Electric (assisted) bicycle driver injured in collision with fixed or stationary object in traffic accident, subsequent encounter
V27.41XS                        Electric (assisted) bicycle driver injured in collision with fixed or stationary object in traffic accident, sequela
V27.49XA                        Other motorcycle driver injured in collision with fixed or stationary object in traffic accident, initial encounter
V27.49XD                        Other motorcycle driver injured in collision with fixed or stationary object in traffic accident, subsequent encounter
V27.49XS                        Other motorcycle driver injured in collision with fixed or stationary object in traffic accident, sequela
V27.51XA                        Electric (assisted) bicycle passenger injured in collision with fixed or stationary object in traffic accident, initial encounter
V27.51XD                        Electric (assisted) bicycle passenger injured in collision with fixed or stationary object in traffic accident, subsequent encounter
V27.51XS                        Electric (assisted) bicycle passenger injured in collision with fixed or stationary object in traffic accident, sequela
V27.59XA                        Other motorcycle passenger injured in collision with fixed or stationary object in traffic accident, initial encounter
V27.59XD                        Other motorcycle passenger injured in collision with fixed or stationary object in traffic accident, subsequent encounter
V27.59XS                        Other motorcycle passenger injured in collision with fixed or stationary object in traffic accident, sequela
V27.91XA                        Unspecified electric (assisted) bicycle rider injured in collision with fixed or stationary object in traffic accident, initial encounter
V27.91XD                        Unspecified electric (assisted) bicycle rider injured in collision with fixed or stationary object in traffic accident, subsequent encounter
V27.91XS                        Unspecified electric (assisted) bicycle rider injured in collision with fixed or stationary object in traffic accident, sequela
V27.99XA                        Unspecified rider of other motorcycle injured in collision with fixed or stationary object in traffic accident, initial encounter
V27.99XD                        Unspecified rider of other motorcycle injured in collision with fixed or stationary object in traffic accident, subsequent encounter
V27.99XS                        Unspecified rider of other motorcycle injured in collision with fixed or stationary object in traffic accident, sequela
V28.01XA                        Electric (assisted) bicycle driver injured in noncollision transport accident in nontraffic accident, initial encounter
V28.01XD                        Electric (assisted) bicycle driver injured in noncollision transport accident in nontraffic accident, subsequent encounter
V28.01XS                        Electric (assisted) bicycle driver injured in noncollision transport accident in nontraffic accident, sequela
V28.09XA                        Other motorcycle driver injured in noncollision transport accident in nontraffic accident, initial encounter
V28.09XD                        Other motorcycle driver injured in noncollision transport accident in nontraffic accident, subsequent encounter
V28.09XS                        Other motorcycle driver injured in noncollision transport accident in nontraffic accident, sequela
V28.11XA                        Electric (assisted) bicycle passenger injured in noncollision transport accident in nontraffic accident, initial encounter
V28.11XD                        Electric (assisted) bicycle passenger injured in noncollision transport accident in nontraffic accident, subsequent encounter
V28.11XS                        Electric (assisted) bicycle passenger injured in noncollision transport accident in nontraffic accident, sequela
V28.19XA                        Other motorcycle passenger injured in noncollision transport accident in nontraffic accident, initial encounter
V28.19XD                        Other motorcycle passenger injured in noncollision transport accident in nontraffic accident, subsequent encounter
V28.19XS                        Other motorcycle passenger injured in noncollision transport accident in nontraffic accident, sequela
V28.21XA                        Unspecified electric (assisted) bicycle rider injured in noncollision transport accident in nontraffic accident, initial encounter
V28.21XD                        Unspecified electric (assisted) bicycle rider injured in noncollision transport accident in nontraffic accident, subsequent encounter
V28.21XS                        Unspecified electric (assisted) bicycle rider injured in noncollision transport accident in nontraffic accident, sequela
V28.29XA                        Unspecified rider of other motorcycle injured in noncollision transport accident in nontraffic accident, initial encounter
V28.29XD                        Unspecified rider of other motorcycle injured in noncollision transport accident in nontraffic accident, subsequent encounter
V28.29XS                        Unspecified rider of other motorcycle injured in noncollision transport accident in nontraffic accident, sequela
V28.31XA                        Person boarding or alighting an electric (assisted) bicycle injured in noncollision transport accident, initial encounter
V28.31XD                        Person boarding or alighting an electric (assisted) bicycle injured in noncollision transport accident, subsequent encounter
V28.31XS                        Person boarding or alighting an electric (assisted) bicycle injured in noncollision transport accident, sequela
V28.39XA                        Person boarding or alighting other motorcycle injured in noncollision transport accident, initial encounter
V28.39XD                        Person boarding or alighting other motorcycle injured in noncollision transport accident, subsequent encounter
V28.39XS                        Person boarding or alighting other motorcycle injured in noncollision transport accident, sequela
V28.41XA                        Electric (assisted) bicycle driver injured in noncollision transport accident in traffic accident, initial encounter
V28.41XD                        Electric (assisted) bicycle driver injured in noncollision transport accident in traffic accident, subsequent encounter
V28.41XS                        Electric (assisted) bicycle driver injured in noncollision transport accident in traffic accident, sequela
V28.49XA                        Other motorcycle driver injured in noncollision transport accident in traffic accident, initial encounter
V28.49XD                        Other motorcycle driver injured in noncollision transport accident in traffic accident, subsequent encounter
V28.49XS                        Other motorcycle driver injured in noncollision transport accident in traffic accident, sequela
V28.51XA                        Electric (assisted) bicycle passenger injured in noncollision transport accident in traffic accident, initial encounter
V28.51XD                        Electric (assisted) bicycle passenger injured in noncollision transport accident in traffic accident, subsequent encounter
V28.51XS                        Electric (assisted) bicycle passenger injured in noncollision transport accident in traffic accident, sequela
V28.59XA                        Other motorcycle passenger injured in noncollision transport accident in traffic accident, initial encounter
V28.59XD                        Other motorcycle passenger injured in noncollision transport accident in traffic accident, subsequent encounter
V28.59XS                        Other motorcycle passenger injured in noncollision transport accident in traffic accident, sequela
V28.91XA                        Unspecified electric (assisted) bicycle rider injured in noncollision transport accident in traffic accident, initial encounter
V28.91XD                        Unspecified electric (assisted) bicycle rider injured in noncollision transport accident in traffic accident, subsequent encounter
V28.91XS                        Unspecified electric (assisted) bicycle rider injured in noncollision transport accident in traffic accident, sequela
V28.99XA                        Unspecified rider of other motorcycle injured in noncollision transport accident in traffic accident, initial encounter
V28.99XD                        Unspecified rider of other motorcycle injured in noncollision transport accident in traffic accident, subsequent encounter
V28.99XS                        Unspecified rider of other motorcycle injured in noncollision transport accident in traffic accident, sequela
V29.001A                        Electric (assisted) bicycle driver injured in collision with unspecified motor vehicles in nontraffic accident, initial encounter
V29.001D                        Electric (assisted) bicycle driver injured in collision with unspecified motor vehicles in nontraffic accident, subsequent encounter
V29.001S                        Electric (assisted) bicycle driver injured in collision with unspecified motor vehicles in nontraffic accident, sequela
V29.008A                        Other motorcycle driver injured in collision with unspecified motor vehicles in nontraffic accident, initial encounter
V29.008D                        Other motorcycle driver injured in collision with unspecified motor vehicles in nontraffic accident, subsequent encounter
V29.008S                        Other motorcycle driver injured in collision with unspecified motor vehicles in nontraffic accident, sequela
V29.091A                        Electric (assisted) bicycle driver injured in collision with other motor vehicles in nontraffic accident, initial encounter
V29.091D                        Electric (assisted) bicycle driver injured in collision with other motor vehicles in nontraffic accident, subsequent encounter
V29.091S                        Electric (assisted) bicycle driver injured in collision with other motor vehicles in nontraffic accident, sequela
V29.098A                        Other motorcycle driver injured in collision with other motor vehicles in nontraffic accident, initial encounter
V29.098D                        Other motorcycle driver injured in collision with other motor vehicles in nontraffic accident, subsequent encounter
V29.098S                        Other motorcycle driver injured in collision with other motor vehicles in nontraffic accident, sequela
V29.101A                        Electric (assisted) bicycle passenger injured in collision with unspecified motor vehicles in nontraffic accident, initial encounter
V29.101D                        Electric (assisted) bicycle passenger injured in collision with unspecified motor vehicles in nontraffic accident, subsequent encounter
V29.101S                        Electric (assisted) bicycle passenger injured in collision with unspecified motor vehicles in nontraffic accident, sequela
V29.108A                        Other motorcycle passenger injured in collision with unspecified motor vehicles in nontraffic accident, initial encounter
V29.108D                        Other motorcycle passenger injured in collision with unspecified motor vehicles in nontraffic accident, subsequent encounter
V29.108S                        Other motorcycle passenger injured in collision with unspecified motor vehicles in nontraffic accident, sequela
V29.191A                        Electric (assisted) bicycle passenger injured in collision with other motor vehicles in nontraffic accident, initial encounter
V29.191D                        Electric (assisted) bicycle passenger injured in collision with other motor vehicles in nontraffic accident, subsequent encounter
V29.191S                        Electric (assisted) bicycle passenger injured in collision with other motor vehicles in nontraffic accident, sequela
V29.198A                        Other motorcycle passenger injured in collision with other motor vehicles in nontraffic accident, initial encounter
V29.198D                        Other motorcycle passenger injured in collision with other motor vehicles in nontraffic accident, subsequent encounter
V29.198S                        Other motorcycle passenger injured in collision with other motor vehicles in nontraffic accident, sequela
V29.201A                        Unspecified electric (assisted) bicycle rider injured in collision with unspecified motor vehicles in nontraffic accident, initial encounter
V29.201D                        Unspecified electric (assisted) bicycle rider injured in collision with unspecified motor vehicles in nontraffic accident, subsequent encounter
V29.201S                        Unspecified electric (assisted) bicycle rider injured in collision with unspecified motor vehicles in nontraffic accident, sequela
V29.208A                        Unspecified rider of other motorcycle injured in collision with unspecified motor vehicles in nontraffic accident, initial encounter
V29.208D                        Unspecified rider of other motorcycle injured in collision with unspecified motor vehicles in nontraffic accident, subsequent encounter
V29.208S                        Unspecified rider of other motorcycle injured in collision with unspecified motor vehicles in nontraffic accident, sequela
V29.291A                        Unspecified electric (assisted) bicycle rider injured in collision with other motor vehicles in nontraffic accident, initial encounter
V29.291D                        Unspecified electric (assisted) bicycle rider injured in collision with other motor vehicles in nontraffic accident, subsequent encounter
V29.291S                        Unspecified electric (assisted) bicycle rider injured in collision with other motor vehicles in nontraffic accident, sequela
V29.298A                        Unspecified rider of other motorcycle injured in collision with other motor vehicles in nontraffic accident, initial encounter
V29.298D                        Unspecified rider of other motorcycle injured in collision with other motor vehicles in nontraffic accident, subsequent encounter
V29.298S                        Unspecified rider of other motorcycle injured in collision with other motor vehicles in nontraffic accident, sequela
V29.31XA                        Electric (assisted) bicycle (driver) (passenger) injured in unspecified nontraffic accident, initial encounter
V29.31XD                        Electric (assisted) bicycle (driver) (passenger) injured in unspecified nontraffic accident, subsequent encounter
V29.31XS                        Electric (assisted) bicycle (driver) (passenger) injured in unspecified nontraffic accident, sequela
V29.39XA                        Other motorcycle (driver) (passenger) injured in unspecified nontraffic accident, initial encounter
V29.39XD                        Other motorcycle (driver) (passenger) injured in unspecified nontraffic accident, subsequent encounter
V29.39XS                        Other motorcycle (driver) (passenger) injured in unspecified nontraffic accident, sequela
V29.401A                        Electric (assisted) bicycle driver injured in collision with unspecified motor vehicles in traffic accident, initial encounter
V29.401D                        Electric (assisted) bicycle driver injured in collision with unspecified motor vehicles in traffic accident, subsequent encounter
V29.401S                        Electric (assisted) bicycle driver injured in collision with unspecified motor vehicles in traffic accident, sequela
V29.408A                        Other motorcycle driver injured in collision with unspecified motor vehicles in traffic accident, initial encounter
V29.408D                        Other motorcycle driver injured in collision with unspecified motor vehicles in traffic accident, subsequent encounter
V29.408S                        Other motorcycle driver injured in collision with unspecified motor vehicles in traffic accident, sequela
V29.491A                        Electric (assisted) bicycle driver injured in collision with other motor vehicles in traffic accident, initial encounter
V29.491D                        Electric (assisted) bicycle driver injured in collision with other motor vehicles in traffic accident, subsequent encounter
V29.491S                        Electric (assisted) bicycle driver injured in collision with other motor vehicles in traffic accident, sequela
V29.498A                        Other motorcycle driver injured in collision with other motor vehicles in traffic accident, initial encounter
V29.498D                        Other motorcycle driver injured in collision with other motor vehicles in traffic accident, subsequent encounter
V29.498S                        Other motorcycle driver injured in collision with other motor vehicles in traffic accident, sequela
V29.501A                        Electric (assisted) bicycle passenger injured in collision with unspecified motor vehicles in traffic accident, initial encounter
V29.501D                        Electric (assisted) bicycle passenger injured in collision with unspecified motor vehicles in traffic accident, subsequent encounter
V29.501S                        Electric (assisted) bicycle passenger injured in collision with unspecified motor vehicles in traffic accident, sequela
V29.508A                        Other motorcycle passenger injured in collision with unspecified motor vehicles in traffic accident, initial encounter
V29.508D                        Other motorcycle passenger injured in collision with unspecified motor vehicles in traffic accident, subsequent encounter
V29.508S                        Other motorcycle passenger injured in collision with unspecified motor vehicles in traffic accident, sequela
V29.591A                        Electric (assisted) bicycle passenger injured in collision with other motor vehicles in traffic accident, initial encounter
V29.591D                        Electric (assisted) bicycle passenger injured in collision with other motor vehicles in traffic accident, subsequent encounter
V29.591S                        Electric (assisted) bicycle passenger injured in collision with other motor vehicles in traffic accident, sequela
V29.598A                        Other motorcycle passenger injured in collision with other motor vehicles in traffic accident, initial encounter
V29.598D                        Other motorcycle passenger injured in collision with other motor vehicles in traffic accident, subsequent encounter
V29.598S                        Other motorcycle passenger injured in collision with other motor vehicles in traffic accident, sequela
V29.601A                        Unspecified electric (assisted) bicycle rider injured in collision with unspecified motor vehicles in traffic accident, initial encounter
V29.601D                        Unspecified electric (assisted) bicycle rider injured in collision with unspecified motor vehicles in traffic accident, subsequent encounter
V29.601S                        Unspecified electric (assisted) bicycle rider injured in collision with unspecified motor vehicles in traffic accident, sequela
V29.608A                        Unspecified rider of other motorcycle injured in collision with unspecified motor vehicles in traffic accident, initial encounter
V29.608D                        Unspecified rider of other motorcycle injured in collision with unspecified motor vehicles in traffic accident, subsequent encounter
V29.608S                        Unspecified rider of other motorcycle injured in collision with unspecified motor vehicles in traffic accident, sequela
V29.691A                        Unspecified electric (assisted) bicycle rider injured in collision with other motor vehicles in traffic accident, initial encounter
V29.691D                        Unspecified electric (assisted) bicycle rider injured in collision with other motor vehicles in traffic accident, subsequent encounter
V29.691S                        Unspecified electric (assisted) bicycle rider injured in collision with other motor vehicles in traffic accident, sequela
V29.698A                        Unspecified rider of other motorcycle injured in collision with other motor vehicles in traffic accident, initial encounter
V29.698D                        Unspecified rider of other motorcycle injured in collision with other motor vehicles in traffic accident, subsequent encounter
V29.698S                        Unspecified rider of other motorcycle injured in collision with other motor vehicles in traffic accident, sequela
V29.811A                        Electric (assisted) bicycle rider (driver) (passenger) injured in transport accident with military vehicle, initial encounter
V29.811D                        Electric (assisted) bicycle rider (driver) (passenger) injured in transport accident with military vehicle, subsequent encounter
V29.811S                        Electric (assisted) bicycle rider (driver) (passenger) injured in transport accident with military vehicle, sequela
V29.818A                        Rider (driver) (passenger) of other motorcycle injured in transport accident with military vehicle, initial encounter
V29.818D                        Rider (driver) (passenger) of other motorcycle injured in transport accident with military vehicle, subsequent encounter
V29.818S                        Rider (driver) (passenger) of other motorcycle injured in transport accident with military vehicle, sequela
V29.881A                        Electric (assisted) bicycle rider (driver) (passenger) injured in other specified transport accidents, initial encounter
V29.881D                        Electric (assisted) bicycle rider (driver) (passenger) injured in other specified transport accidents, subsequent encounter
V29.881S                        Electric (assisted) bicycle rider (driver) (passenger) injured in other specified transport accidents, sequela
V29.888A                        Rider (driver) (passenger) of other motorcycle injured in other specified transport accidents, initial encounter
V29.888D                        Rider (driver) (passenger) of other motorcycle injured in other specified transport accidents, subsequent encounter
V29.888S                        Rider (driver) (passenger) of other motorcycle injured in other specified transport accidents, sequela
V29.91XA                        Electric (assisted) bicycle rider (driver) (passenger) injured in unspecified traffic accident, initial encounter
V29.91XD                        Electric (assisted) bicycle rider (driver) (passenger) injured in unspecified traffic accident, subsequent encounter
V29.91XS                        Electric (assisted) bicycle rider (driver) (passenger) injured in unspecified traffic accident, sequela
V29.99XA                        Rider (driver) (passenger) of other motorcycle injured in unspecified traffic accident, initial encounter
V29.99XD                        Rider (driver) (passenger) of other motorcycle injured in unspecified traffic accident, subsequent encounter
V29.99XS                        Rider (driver) (passenger) of other motorcycle injured in unspecified traffic accident, sequela
W23.2XXA                        Caught, crushed, jammed or pinched between a moving and stationary object, initial encounter
W23.2XXD                        Caught, crushed, jammed or pinched between a moving and stationary object, subsequent encounter
W23.2XXS                        Caught, crushed, jammed or pinched between a moving and stationary object, sequela
Z03.83                          Encounter for observation for suspected conditions related to home physiologic monitoring device ruled out
Z59.82                          Transportation insecurity
Z59.86                          Financial insecurity
Z59.87                          Material hardship
Z71.87                          Encounter for pediatric-to-adult transition counseling
Z71.88                          Encounter for counseling for socioeconomic factors
Z72.823                         Risk of suffocation (smothering) under another while sleeping
Z79.60                          Long term (current) use of unspecified immunomodulators and immunosuppressants
Z79.61                          Long term (current) use of immunomodulator
Z79.620                         Long term (current) use of immunosuppressive biologic
Z79.621                         Long term (current) use of calcineurin inhibitor
Z79.622                         Long term (current) use of Janus kinase inhibitor
Z79.623                         Long term (current) use of mammalian target of rapamycin (mTOR) inhibitor
Z79.624                         Long term (current) use of inhibitors of nucleotide synthesis
Z79.630                         Long term (current) use of alkylating agent
Z79.631                         Long term (current) use of antimetabolite agent
Z79.632                         Long term (current) use of antitumor antibiotic
Z79.633                         Long term (current) use of mitotic inhibitor
Z79.634                         Long term (current) use of topoisomerase inhibitor
Z79.64                          Long term (current) use of myelosuppressive agent
Z79.69                          Long term (current) use of other immunomodulators and immunosuppressants
Z79.85                          Long-term (current) use of injectable non-insulin antidiabetic drugs
Z87.61                          Personal history of (corrected) necrotizing enterocolitis of newborn
Z87.68                          Personal history of other (corrected) conditions arising in the perinatal period
Z87.731                         Personal history of (corrected) tracheoesophageal fistula or atresia
Z87.732                         Personal history of (corrected) persistent cloaca or cloacal malformations
Z87.760                         Personal history of (corrected) congenital diaphragmatic hernia or other congenital diaphragm malformations
Z87.761                         Personal history of (corrected) gastroschisis
Z87.762                         Personal history of (corrected) prune belly malformation
Z87.763                         Personal history of other (corrected) congenital abdominal wall malformations
Z87.768                         Personal history of other specified (corrected) congenital malformations of integument, limbs and musculoskeletal system
Z91.110                         Patients noncompliance with dietary regimen due to financial hardship
Z91.118                         Patients noncompliance with dietary regimen for other reason
Z91.119                         Patients noncompliance with dietary regimen due to unspecified reason
Z91.190                         Patients noncompliance with other medical treatment and regimen due to financial hardship
Z91.198                         Patients noncompliance with other medical treatment and regimen for other reason
Z91.199                         Patients noncompliance with other medical treatment and regimen due to unspecified reason
Z91.A10                         Caregivers noncompliance with patients dietary regimen due to financial hardship
Z91.A18                         Caregivers noncompliance with patients dietary regimen for other reason
Z91.A20                         Caregivers intentional underdosing of patients medication regimen due to financial hardship
Z91.A28                         Caregivers intentional underdosing of medication regimen for other reason
Z91.A3                          Caregivers unintentional underdosing of patients medication regimen
Z91.A4                          Caregivers other noncompliance with patients medication regimen
Z91.A5                          Caregivers noncompliance with patients renal dialysis
Z91.A9                          Caregivers noncompliance with patients other medical treatment and regimen
F43.11                          Post-Traumatic Stress Disorder, Acute
G43.001                         Migraine Without Aura and With Status Migrainosus, Not Intractable
P07.03                          Extremely low birth weight
P07.1                           Low Birth Weight
P07.25                          Extreme prematurity, 26 completed weeks
P07.30                          History of prematurity
V61.20                          Parent-Child Relational Problem
V61.8                           Sibling Relational Problem
Z62.810                         History of physical abuse in childhood
Z62.812                         Personal history of neglect in early childhood
A41.54                          Sepsis due to Acinetobacter baumannii
B96.83                          Acinetobacter baumannii as the cause of diseases classified elsewhere
D13.9                           Benign neoplasm of ill-defined sites within the digestive system
G20                             Parkinsons disease
H36                             Retinal disorders in diseases classified elsewhere
G20.A1                          Parkinsons disease without dyskinesia, without mention of fluctuations
G20.A2                          Parkinsons disease without dyskinesia, with fluctuations
G20.B1                          Parkinsons disease with dyskinesia, without mention of fluctuations
G20.B2                          Parkinsons disease with dyskinesia, with fluctuations
G20.C                           Parkinsonism, unspecified
G93.44                          Adult-onset leukodystrophy with axonal spheroids
H50.621                         Inferior oblique muscle entrapment, right eye
H50.622                         Inferior oblique muscle entrapment, left eye
H50.629                         Inferior oblique muscle entrapment, unspecified eye
H50.631                         Inferior rectus muscle entrapment, right eye
H50.632                         Inferior rectus muscle entrapment, left eye
H50.639                         Inferior rectus muscle entrapment, unspecified eye
H50.641                         Lateral rectus muscle entrapment, right eye
H50.642                         Lateral rectus muscle entrapment, left eye
H50.649                         Lateral rectus muscle entrapment, unspecified eye
H50.651                         Medial rectus muscle entrapment, right eye
H50.652                         Medial rectus muscle entrapment, left eye
H50.659                         Medial rectus muscle entrapment, unspecified eye
H50.661                         Superior oblique muscle entrapment, right eye
H50.662                         Superior oblique muscle entrapment, left eye
H50.669                         Superior oblique muscle entrapment, unspecified eye
H50.671                         Superior rectus muscle entrapment, right eye
H50.672                         Superior rectus muscle entrapment, left eye
H50.679                         Superior rectus muscle entrapment, unspecified eye
H50.681                         Extraocular muscle entrapment, unspecified, right eye
H50.682                         Extraocular muscle entrapment, unspecified, left eye
H50.689                         Extraocular muscle entrapment, unspecified, unspecified eye
H57.8A1                         Foreign body sensation, right eye
H57.8A2                         Foreign body sensation, left eye
H57.8A3                         Foreign body sensation, bilateral eyes
H57.8A9                         Foreign body sensation, unspecified eye
I20.8                           Other forms of angina pectoris
I20.81                          Angina pectoris with coronary microvascular dysfunction
I20.89                          Other forms of angina pectoris
I21.B                           Myocardial infarction with coronary microvascular dysfunction
I24.8                           Other forms of acute ischemic heart disease
I24.81                          Acute coronary microvascular dysfunction
I24.89                          Other forms of acute ischemic heart disease
J15.6                           Pneumonia due to other Gram-negative bacteria
J15.61                          Pneumonia due to Acinetobacter baumannii
J15.69                          Pneumonia due to other Gram-negative bacteria
J44.81                          Bronchiolitis obliterans and bronchiolitis obliterans syndrome
J44.89                          Other specified chronic obstructive pulmonary disease
K35.20                          Acute appendicitis with generalized peritonitis, without abscess
K35.200                         Acute appendicitis with generalized peritonitis, without perforation or abscess
K35.201                         Acute appendicitis with generalized peritonitis, with perforation, without abscess
K35.209                         Acute appendicitis with generalized peritonitis, without abscess, unspecified as to perforation
K35.21                          Acute appendicitis with generalized peritonitis, with abscess
K35.210                         Acute appendicitis with generalized peritonitis, without perforation, with abscess
K35.211                         Acute appendicitis with generalized peritonitis, with perforation and abscess
K35.219                         Acute appendicitis with generalized peritonitis, with abscess, unspecified as to perforation
K63.8211                        Small intestinal bacterial overgrowth, hydrogen-subtype
K63.8212                        Small intestinal bacterial overgrowth, hydrogen sulfide-subtype
K63.8219                        Small intestinal bacterial overgrowth, unspecified
K63.822                         Small intestinal fungal overgrowth
K63.829                         Intestinal methanogen overgrowth, unspecified
K68.2                           Retroperitoneal fibrosis
K68.3                           Retroperitoneal hematoma
M80.0B1A                        Age-related osteoporosis with current pathological fracture, right pelvis, initial encounter for fracture
M80.0B1D                        Age-related osteoporosis with current pathological fracture, right pelvis, subsequent encounter for fracture with routine healing
M80.0B1G                        Age-related osteoporosis with current pathological fracture, right pelvis, subsequent encounter for fracture with delayed healing
M80.0B1K                        Age-related osteoporosis with current pathological fracture, right pelvis, subsequent encounter for fracture with nonunion
M80.0B1P                        Age-related osteoporosis with current pathological fracture, right pelvis, subsequent encounter for fracture with malunion
M80.0B1S                        Age-related osteoporosis with current pathological fracture, right pelvis, sequela
M80.0B2A                        Age-related osteoporosis with current pathological fracture, left pelvis, initial encounter for fracture
M80.0B2D                        Age-related osteoporosis with current pathological fracture, left pelvis, subsequent encounter for fracture with routine healing
M80.0B2G                        Age-related osteoporosis with current pathological fracture, left pelvis, subsequent encounter for fracture with delayed healing
M80.0B2K                        Age-related osteoporosis with current pathological fracture, left pelvis, subsequent encounter for fracture with nonunion
M80.0B2P                        Age-related osteoporosis with current pathological fracture, left pelvis, subsequent encounter for fracture with malunion
M80.0B2S                        Age-related osteoporosis with current pathological fracture, left pelvis, sequela
M80.0B9A                        Age-related osteoporosis with current pathological fracture, unspecified pelvis, initial encounter for fracture
M80.0B9D                        Age-related osteoporosis with current pathological fracture, unspecified pelvis, subsequent encounter for fracture with routine healing
M80.0B9G                        Age-related osteoporosis with current pathological fracture, unspecified pelvis, subsequent encounter for fracture with delayed healing
M80.0B9K                        Age-related osteoporosis with current pathological fracture, unspecified pelvis, subsequent encounter for fracture with nonunion
M80.0B9P                        Age-related osteoporosis with current pathological fracture, unspecified pelvis, subsequent encounter for fracture with malunion
M80.0B9S                        Age-related osteoporosis with current pathological fracture, unspecified pelvis, sequela
M80.8B1A                        Other osteoporosis with current pathological fracture, right pelvis, initial encounter for fracture
M80.8B1D                        Other osteoporosis with current pathological fracture, right pelvis, subsequent encounter for fracture with routine healing
M80.8B1G                        Other osteoporosis with current pathological fracture, right pelvis, subsequent encounter for fracture with delayed healing
M80.8B1K                        Other osteoporosis with current pathological fracture, right pelvis, subsequent encounter for fracture with nonunion
M80.8B1P                        Other osteoporosis with current pathological fracture, right pelvis, subsequent encounter for fracture with malunion
M80.8B1S                        Other osteoporosis with current pathological fracture, right pelvis, sequela
M80.8B2A                        Other osteoporosis with current pathological fracture, left pelvis, initial encounter for fracture
M80.8B2D                        Other osteoporosis with current pathological fracture, left pelvis, subsequent encounter for fracture with routine healing
M80.8B2G                        Other osteoporosis with current pathological fracture, left pelvis, subsequent encounter for fracture with delayed healing
M80.8B2K                        Other osteoporosis with current pathological fracture, left pelvis, subsequent encounter for fracture with nonunion
M80.8B2P                        Other osteoporosis with current pathological fracture, left pelvis, subsequent encounter for fracture with malunion
M80.8B2S                        Other osteoporosis with current pathological fracture, left pelvis, sequela
M80.8B9A                        Other osteoporosis with current pathological fracture, unspecified pelvis, initial encounter for fracture
M80.8B9D                        Other osteoporosis with current pathological fracture, unspecified pelvis, subsequent encounter for fracture with routine healing
M80.8B9G                        Other osteoporosis with current pathological fracture, unspecified pelvis, subsequent encounter for fracture with delayed healing
M80.8B9K                        Other osteoporosis with current pathological fracture, unspecified pelvis, subsequent encounter for fracture with nonunion
M80.8B9P                        Other osteoporosis with current pathological fracture, unspecified pelvis, subsequent encounter for fracture with malunion
M80.8B9S                        Other osteoporosis with current pathological fracture, unspecified pelvis, sequela
O26.641                         Intrahepatic cholestasis of pregnancy, first trimester
O26.642                         Intrahepatic cholestasis of pregnancy, second trimester
O26.643                         Intrahepatic cholestasis of pregnancy, third trimester
O26.649                         Intrahepatic cholestasis of pregnancy, unspecified trimester
O90.4                           Postpartum acute kidney failure
O90.41                          Hepatorenal syndrome following labor and delivery
O90.49                          Other postpartum acute kidney failure
R09.A0                          Foreign body sensation, unspecified
R09.A1                          Foreign body sensation, nose
R09.A2                          Foreign body sensation, throat
R09.A9                          Foreign body sensation, other site
R92.30                          Dense breasts, unspecified
R92.311                         Mammographic fatty tissue density, right breast
R92.312                         Mammographic fatty tissue density, left breast
R92.313                         Mammographic fatty tissue density, bilateral breasts
R92.321                         Mammographic fibroglandular density, right breast
R92.322                         Mammographic fibroglandular density, left breast
R92.323                         Mammographic fibroglandular density, bilateral breasts
R92.331                         Mammographic heterogeneous density, right breast
R92.332                         Mammographic heterogeneous density, left breast
R92.333                         Mammographic heterogeneous density, bilateral breasts
R92.341                         Mammographic extreme density, right breast
R92.342                         Mammographic extreme density, left breast
R92.343                         Mammographic extreme density, bilateral breasts
T56.821A                        Toxic effect of gadolinium, accidental (unintentional), initial encounter
T56.821D                        Toxic effect of gadolinium, accidental (unintentional), subsequent encounter
T56.821S                        Toxic effect of gadolinium, accidental (unintentional), sequela
T56.822A                        Toxic effect of gadolinium, intentional self-harm, initial encounter
T56.822D                        Toxic effect of gadolinium, intentional self-harm, subsequent encounter
T56.822S                        Toxic effect of gadolinium, intentional self-harm, sequela
T56.823A                        Toxic effect of gadolinium, assault, initial encounter
T56.823D                        Toxic effect of gadolinium, assault, subsequent encounter
T56.823S                        Toxic effect of gadolinium, assault, sequela
T56.824A                        Toxic effect of gadolinium, undetermined, initial encounter
T56.824D                        Toxic effect of gadolinium, undetermined, subsequent encounter
T56.824S                        Toxic effect of gadolinium, undetermined, sequela
W44.8XXA                        Other foreign body entering into or through a natural orifice, initial encounter
W44.8XXD                        Other foreign body entering into or through a natural orifice, subsequent encounter
W44.8XXS                        Other foreign body entering into or through a natural orifice, sequela
W44.9XXA                        Unspecified foreign body entering into or through a natural orifice, initial encounter
W44.9XXD                        Unspecified foreign body entering into or through a natural orifice, subsequent encounter
W44.9XXS                        Unspecified foreign body entering into or through a natural orifice, sequela
W44.A0XA                        Battery unspecified, entering into or through a natural orifice, initial encounter
W44.A0XD                        Battery unspecified, entering into or through a natural orifice, subsequent encounter
W44.A0XS                        Battery unspecified, entering into or through a natural orifice, sequela
W44.A1XA                        Button battery entering into or through a natural orifice, initial encounter
W44.A1XD                        Button battery entering into or through a natural orifice, subsequent encounter
W44.A1XS                        Button battery entering into or through a natural orifice, sequela
W44.A9XA                        Other batteries entering into or through a natural orifice, initial encounter
W44.A9XD                        Other batteries entering into or through a natural orifice, subsequent encounter
W44.A9XS                        Other batteries entering into or through a natural orifice, sequela
W44.B0XA                        Plastic object unspecified, entering into or through a natural orifice, initial encounter
W44.B0XD                        Plastic object unspecified, entering into or through a natural orifice, subsequent encounter
W44.B0XS                        Plastic object unspecified, entering into or through a natural orifice, sequela
W44.B1XA                        Plastic bead entering into or through a natural orifice, initial encounter
W44.B1XD                        Plastic bead entering into or through a natural orifice, subsequent encounter
W44.B1XS                        Plastic bead entering into or through a natural orifice, sequela
W44.B2XA                        Plastic coin entering into or through a natural orifice, initial encounter
W44.B2XD                        Plastic coin entering into or through a natural orifice, subsequent encounter
W44.B2XS                        Plastic coin entering into or through a natural orifice, sequela
W44.B3XA                        Plastic toy and toy part entering into or through a natural orifice, initial encounter
W44.B3XD                        Plastic toy and toy part entering into or through a natural orifice, subsequent encounter
W44.B3XS                        Plastic toy and toy part entering into or through a natural orifice, sequela
W44.B4XA                        Plastic jewelry entering into or through a natural orifice, initial encounter
W44.B4XD                        Plastic jewelry entering into or through a natural orifice, subsequent encounter
W44.B4XS                        Plastic jewelry entering into or through a natural orifice, sequela
W44.B5XA                        Plastic bottle entering into or through a natural orifice, initial encounter
W44.B5XD                        Plastic bottle entering into or through a natural orifice, subsequent encounter
W44.B5XS                        Plastic bottle entering into or through a natural orifice, sequela
W44.B9XA                        Other plastic object entering into or through a natural orifice, initial encounter
W44.B9XD                        Other plastic object entering into or through a natural orifice, subsequent encounter
W44.B9XS                        Other plastic object entering into or through a natural orifice, sequela
W44.C0XA                        Glass unspecified, entering into or through a natural orifice, initial encounter
W44.C0XD                        Glass unspecified, entering into or through a natural orifice, subsequent encounter
W44.C0XS                        Glass unspecified, entering into or through a natural orifice, sequela
W44.C1XA                        Sharp glass entering into or through a natural orifice, initial encounter
W44.C1XD                        Sharp glass entering into or through a natural orifice, subsequent encounter
W44.C1XS                        Sharp glass entering into or through a natural orifice, sequela
W44.C2XA                        Intact glass entering into or through a natural orifice, initial encounter
W44.C2XD                        Intact glass entering into or through a natural orifice, subsequent encounter
W44.C2XS                        Intact glass entering into or through a natural orifice, sequela
W44.D0XA                        Magnetic metal object unspecified, entering into or through a natural orifice, initial encounter
W44.D0XD                        Magnetic metal object unspecified, entering into or through a natural orifice, subsequent encounter
W44.D0XS                        Magnetic metal object unspecified, entering into or through a natural orifice, sequela
W44.D1XA                        Magnetic metal bead entering into or through a natural orifice, initial encounter
W44.D1XD                        Magnetic metal bead entering into or through a natural orifice, subsequent encounter
W44.D1XS                        Magnetic metal bead entering into or through a natural orifice, sequela
W44.D2XA                        Magnetic metal coin entering into or through a natural orifice, initial encounter
W44.D2XD                        Magnetic metal coin entering into or through a natural orifice, subsequent encounter
W44.D2XS                        Magnetic metal coin entering into or through a natural orifice, sequela
W44.D3XA                        Magnetic metal toy entering into or through a natural orifice, initial encounter
W44.D3XD                        Magnetic metal toy entering into or through a natural orifice, subsequent encounter
W44.D3XS                        Magnetic metal toy entering into or through a natural orifice, sequela
W44.D4XA                        Magnetic metal jewelry entering into or through a natural orifice, initial encounter
W44.D4XD                        Magnetic metal jewelry entering into or through a natural orifice, subsequent encounter
W44.D4XS                        Magnetic metal jewelry entering into or through a natural orifice, sequela
W44.D9XA                        Other magnetic metal objects entering into or through a natural orifice, initial encounter
W44.D9XD                        Other magnetic metal objects entering into or through a natural orifice, subsequent encounter
W44.D9XS                        Other magnetic metal objects entering into or through a natural orifice, sequela
W44.E0XA                        Non-magnetic metal object unspecified, entering into or through a natural orifice, initial encounter
W44.E0XD                        Non-magnetic metal object unspecified, entering into or through a natural orifice, subsequent encounter
W44.E0XS                        Non-magnetic metal object unspecified, entering into or through a natural orifice, sequela
W44.E1XA                        Non-magnetic metal bead entering into or through a natural orifice, initial encounter
W44.E1XD                        Non-magnetic metal bead entering into or through a natural orifice, subsequent encounter
W44.E1XS                        Non-magnetic metal bead entering into or through a natural orifice, sequela
W44.E2XA                        Non-magnetic metal coin entering into or through a natural orifice, initial encounter
W44.E2XD                        Non-magnetic metal coin entering into or through a natural orifice, subsequent encounter
W44.E2XS                        Non-magnetic metal coin entering into or through a natural orifice, sequela
W44.E3XA                        Non-magnetic metal toy entering into or through a natural orifice, initial encounter
W44.E3XD                        Non-magnetic metal toy entering into or through a natural orifice, subsequent encounter
W44.E3XS                        Non-magnetic metal toy entering into or through a natural orifice, sequela
W44.E4XA                        Non-magnetic metal jewelry entering into or through a natural orifice, initial encounter
W44.E4XD                        Non-magnetic metal jewelry entering into or through a natural orifice, subsequent encounter
W44.E4XS                        Non-magnetic metal jewelry entering into or through a natural orifice, sequela
W44.E9XA                        Other non-magnetic metal objects entering into or through a natural orifice, initial encounter
W44.E9XD                        Other non-magnetic metal objects entering into or through a natural orifice, subsequent encounter
W44.E9XS                        Other non-magnetic metal objects entering into or through a natural orifice, sequela
W44.F0XA                        Objects of natural or organic material unspecified, entering into or through a natural orifice, initial encounter
W44.F0XD                        Objects of natural or organic material unspecified, entering into or through a natural orifice, subsequent encounter
W44.F0XS                        Objects of natural or organic material unspecified, entering into or through a natural orifice, sequela
W44.F1XA                        Bezoar entering into or through a natural orifice, initial encounter
W44.F1XD                        Bezoar entering into or through a natural orifice, subsequent encounter
W44.F1XS                        Bezoar entering into or through a natural orifice, sequela
W44.F2XA                        Rubber band entering into or through a natural orifice, initial encounter
W44.F2XD                        Rubber band entering into or through a natural orifice, subsequent encounter
W44.F2XS                        Rubber band entering into or through a natural orifice, sequela
W44.F3XA                        Food entering into or through a natural orifice, initial encounter
W44.F3XD                        Food entering into or through a natural orifice, subsequent encounter
W44.F3XS                        Food entering into or through a natural orifice, sequela
W44.F4XA                        Insect entering into or through a natural orifice, initial encounter
W44.F4XD                        Insect entering into or through a natural orifice, subsequent encounter
W44.F4XS                        Insect entering into or through a natural orifice, sequela
W44.F9XA                        Other object of natural or organic material, entering into or through a natural orifice, initial encounter
W44.F9XD                        Other object of natural or organic material, entering into or through a natural orifice, subsequent encounter
W44.F9XS                        Other object of natural or organic material, entering into or through a natural orifice, sequela
W44.G0XA                        Other non-organic objects unspecified, entering into or through a natural orifice, initial encounter
W44.G0XD                        Other non-organic objects unspecified, entering into or through a natural orifice, subsequent encounter
W44.G0XS                        Other non-organic objects unspecified, entering into or through a natural orifice, sequela
W44.G1XA                        Audio device entering into or through a natural orifice, initial encounter
W44.G1XD                        Audio device entering into or through a natural orifice, subsequent encounter
W44.G1XS                        Audio device entering into or through a natural orifice, sequela
W44.G2XA                        Combination metal and plastic toy and toy part entering into or through natural orifice, initial encounter
W44.G2XD                        Combination metal and plastic toy and toy part entering into or through natural orifice, subsequent encounter
W44.G2XS                        Combination metal and plastic toy and toy part entering into or through natural orifice, sequela
W44.G3XA                        Combination metal and plastic jewelry entering into or through a natural orifice, initial encounter
W44.G3XD                        Combination metal and plastic jewelry entering into or through a natural orifice, subsequent encounter
W44.G3XS                        Combination metal and plastic jewelry entering into or through a natural orifice, sequela
W44.G9XA                        Other non-organic objects entering into or through a natural orifice, initial encounter
W44.G9XD                        Other non-organic objects entering into or through a natural orifice, subsequent encounter
W44.G9XS                        Other non-organic objects entering into or through a natural orifice, sequela
W44.H0XA                        Other sharp object unspecified, entering into or through a natural orifice, initial encounter
W44.H0XD                        Other sharp object unspecified, entering into or through a natural orifice, subsequent encounter
W44.H0XS                        Other sharp object unspecified, entering into or through a natural orifice, sequela
W44.H1XA                        Needle entering into or through a natural orifice, initial encounter
W44.H1XD                        Needle entering into or through a natural orifice, subsequent encounter
W44.H1XS                        Needle entering into or through a natural orifice, sequela
W44.H2XA                        Knife, sword or dagger entering into or through a natural orifice, initial encounter
W44.H2XD                        Knife, sword or dagger entering into or through a natural orifice, subsequent encounter
W44.H2XS                        Knife, sword or dagger entering into or through a natural orifice, sequela
Z02.84                          Encounter for child welfare exam
Z05.8                           Observation and evaluation of newborn for other specified suspected condition ruled out
Z05.81                          Observation and evaluation of newborn for suspected condition related to home physiologic monitoring device ruled out
Z05.89                          Observation and evaluation of newborn for other specified suspected condition ruled out
Z16.13                          Resistance to carbapenem
Z22.340                         Carrier of carbapenem-resistant Acinetobacter baumannii
Z22.341                         Carrier of carbapenem-sensitive Acinetobacter baumannii
Z22.349                         Carrier of Acinetobacter baumannii, unspecified
Z22.350                         Carrier of carbapenem-resistant Enterobacterales
Z22.358                         Carrier of other Enterobacterales
Z22.359                         Carrier of Enterobacterales, unspecified
Z29.8                           Encounter for other specified prophylactic measures
Z29.81                          Encounter for HIV pre-exposure prophylaxis
Z29.89                          Encounter for other specified prophylactic measures
Z62.23                          Child in custody of non-parental relative
Z62.24                          Child in custody of non-relative guardian
Z62.823                         Parent-step child conflict
Z62.831                         Non-parental relative-child conflict
Z62.832                         Non-relative guardian-child conflict
Z62.833                         Group home staff-child conflict
Z62.892                         Runaway [from current living environment]
Z83.71                          Family history of colonic polyps
Z83.710                         Family history of adenomatous and serrated polyps
Z83.711                         Family history of hyperplastic colon polyps
Z83.718                         Other family history of colon polyps
Z83.719                         Family history of colon polyps, unspecified
Z91.85                          Personal history of military service
Z91.A41                         Caregivers other noncompliance with patients medication regimen due to financial hardship
Z91.A48                         Caregivers other noncompliance with patients medication regimen for other reason
Z91.A51                         Caregivers noncompliance with patients renal dialysis due to financial hardship
Z91.A58                         Caregivers noncompliance with patients renal dialysis for other reason
Z91.A91                         Caregivers noncompliance with patients other medical treatment and regimen due to financial hardship
Z91.A98                         Caregivers noncompliance with patients other medical treatment and regimen for other reason
T66.XXXA                        Radiation sickness, unspecified, initial encounter
T66.XXXD                        Radiation sickness, unspecified, subsequent encounter
T50.9                           Poisoning by, adverse effect of and underdosing of other and unspecified drugs, medicaments and biological substances
T50.90                          Poisoning by, adverse effect of and underdosing of unspecified drugs, medicaments and biological substances
T50.901                         Poisoning by unspecified drugs, medicaments and biological substances, accidental (unintentional)
T50.901A                        Poisoning by unspecified drugs, medicaments and biological substances, accidental (unintentional), initial encounter
T50.901D                        Poisoning by unspecified drugs, medicaments and biological substances, accidental (unintentional), subsequent encounter
T50.901S                        Poisoning by unspecified drugs, medicaments and biological substances, accidental (unintentional), sequela
T50.902                         Poisoning by unspecified drugs, medicaments and biological substances, intentional self-harm
T50.902A                        Poisoning by unspecified drugs, medicaments and biological substances, intentional self-harm, initial encounter
T50.902D                        Poisoning by unspecified drugs, medicaments and biological substances, intentional self-harm, subsequent encounter
T50.902S                        Poisoning by unspecified drugs, medicaments and biological substances, intentional self-harm, sequela
T50.903                         Poisoning by unspecified drugs, medicaments and biological substances, assault
T50.903A                        Poisoning by unspecified drugs, medicaments and biological substances, assault, initial encounter
T50.903D                        Poisoning by unspecified drugs, medicaments and biological substances, assault, subsequent encounter
T50.903S                        Poisoning by unspecified drugs, medicaments and biological substances, assault, sequela
T50.904                         Poisoning by unspecified drugs, medicaments and biological substances, undetermined
T50.904A                        Poisoning by unspecified drugs, medicaments and biological substances, undetermined, initial encounter
T50.904D                        Poisoning by unspecified drugs, medicaments and biological substances, undetermined, subsequent encounter
T50.904S                        Poisoning by unspecified drugs, medicaments and biological substances, undetermined, sequela
T50.905                         Adverse effect of unspecified drugs, medicaments and biological substances
T50.905A                        Adverse effect of unspecified drugs, medicaments and biological substances, initial encounter
T50.905D                        Adverse effect of unspecified drugs, medicaments and biological substances, subsequent encounter
T50.905S                        Adverse effect of unspecified drugs, medicaments and biological substances, sequela
T50.906                         Underdosing of unspecified drugs, medicaments and biological substances
T50.906A                        Underdosing of unspecified drugs, medicaments and biological substances, initial encounter
T50.906D                        Underdosing of unspecified drugs, medicaments and biological substances, subsequent encounter
T50.906S                        Underdosing of unspecified drugs, medicaments and biological substances, sequela
T50.99                          Poisoning by, adverse effect of and underdosing of other drugs, medicaments and biological substances
T50.991                         Poisoning by other drugs, medicaments and biological substances, accidental (unintentional)
T50.991A                        Poisoning by other drugs, medicaments and biological substances, accidental (unintentional), initial encounter
T50.991D                        Poisoning by other drugs, medicaments and biological substances, accidental (unintentional), subsequent encounter
T50.991S                        Poisoning by other drugs, medicaments and biological substances, accidental (unintentional), sequela
T50.992                         Poisoning by other drugs, medicaments and biological substances, intentional self-harm
T50.992A                        Poisoning by other drugs, medicaments and biological substances, intentional self-harm, initial encounter
T50.992D                        Poisoning by other drugs, medicaments and biological substances, intentional self-harm, subsequent encounter
T50.992S                        Poisoning by other drugs, medicaments and biological substances, intentional self-harm, sequela
T50.993                         Poisoning by other drugs, medicaments and biological substances, assault
T50.993A                        Poisoning by other drugs, medicaments and biological substances, assault, initial encounter
T50.993D                        Poisoning by other drugs, medicaments and biological substances, assault, subsequent encounter
T50.993S                        Poisoning by other drugs, medicaments and biological substances, assault, sequela
T50.994                         Poisoning by other drugs, medicaments and biological substances, undetermined
T50.994A                        Poisoning by other drugs, medicaments and biological substances, undetermined, initial encounter
T50.994D                        Poisoning by other drugs, medicaments and biological substances, undetermined, subsequent encounter
T50.994S                        Poisoning by other drugs, medicaments and biological substances, undetermined, sequela
T50.995                         Adverse effect of other drugs, medicaments and biological substances
T50.995A                        Adverse effect of other drugs, medicaments and biological substances, initial encounter
T50.995D                        Adverse effect of other drugs, medicaments and biological substances, subsequent encounter
T50.995S                        Adverse effect of other drugs, medicaments and biological substances, sequela
T50.996                         Underdosing of other drugs, medicaments and biological substances
T50.996A                        Underdosing of other drugs, medicaments and biological substances, initial encounter
T50.996D                        Underdosing of other drugs, medicaments and biological substances, subsequent encounter
T50.996S                        Underdosing of other drugs, medicaments and biological substances, sequela
Z92.0                           Personal history of contraception
Z92.2                           Personal history of drug therapy
Z92.22                          Personal history of monoclonal drug therapy
Z92.23                          Personal history of estrogen therapy
Z92.24                          Personal history of steroid therapy
Z92.240                         Personal history of inhaled steroid therapy
Z92.241                         Personal history of systemic steroid therapy
Z92.29                          Personal history of other drug therapy
Z92.4                           Personal history of surgery, not elsewhere classified
Z92.8                           Personal history of other medical treatment
Z92.81                          Personal history of extracorporeal membrane oxygenation (ECMO)
Z92.83                          Personal history of failed moderate sedation
Z92.84                          Personal history of unintended awareness under general anesthesia
Z92.89                          Personal history of other medical treatment
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
T66.XXXS  malignancy            n/a Radiation sickness, unspecified, sequela
Z92.25    immunological         no  Personal history of immunosupression therapy
Z92.3     malignancy            n/a Personal history of irradiation
Z92.6     malignancy            n/a Personal history of chemotherapy for neoplastic disease
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
G71.00    musculoskeletal       yes Muscular dystrophy, unspecified
G71.01    musculoskeletal       yes Duchenne or Becker muscular dystrophy
G71.02    musculoskeletal       no  Facioscapulohumeral muscular dystrophy
G71.09    musculoskeletal       yes Other specified muscular dystrophies
G71.20    musculoskeletal       yes Congenital myopathy, unspecifed
G71.21    musculoskeletal       yes Nemaline myopathy
G71.220   musculoskeletal       yes X-linked myotubular myopathy
G71.228   musculoskeletal       yes Other centronuclear myopathy
G71.29    musculoskeletal       yes Other congenital myopathy
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
C56.3     malignancy            yes Malignant neoplasm of bilateral ovaries
C79.63    malignancy            yes Secondary malignant neoplasm of bilateral ovaries
C84.7A    malignancy            yes Anaplastic large cell lymphoma, ALK-negative, breast
D55.21    hematological         no  Anemia due to pyruvate kinase deficiency
D55.29    hematological         no  Anemia due to other disorders of glycolytic enzymes
E75.240   metabolic             yes Niemann-Pick disease type A
E75.241   metabolic             yes Niemann-Pick disease type B
E75.242   metabolic             yes Niemann-Pick disease type C
E75.243   metabolic             yes Niemann-Pick disease type D
E75.244   metabolic             yes Niemann-Pick disease type A/B
F32.A     mental health         no  Depression, unspecified
F78.A1    neurological          yes SYNGAP1-related intellectual disability
F78.A9    neurological          yes Other genetic related intellectual disability
K22.81    gastrointestinal      no  Esophageal polyp
K22.82    gastrointestinal      no  Esophagogastric junction polyp
K22.89    gastrointestinal      no  Other specified disease of esophagus
K31.A0    gastrointestinal      yes Gastric intestinal metaplasia, unspecified
K31.A11   gastrointestinal      yes Gastric intestinal metaplasia without dysplasia, involving the antrum
K31.A12   gastrointestinal      yes Gastric intestinal metaplasia without dysplasia, involving the body (corpus)
K31.A13   gastrointestinal      yes Gastric intestinal metaplasia without dysplasia, involving the fundus
K31.A14   gastrointestinal      yes Gastric intestinal metaplasia without dysplasia, involving the cardia
K31.A15   gastrointestinal      yes Gastric intestinal metaplasia without dysplasia, involving multiple sites
K31.A19   gastrointestinal      yes Gastric intestinal metaplasia without dysplasia, unspecified site
K31.A21   gastrointestinal      yes Gastric intestinal metaplasia with low grade dysplasia
K31.A22   gastrointestinal      yes Gastric intestinal metaplasia with high grade dysplasia
K31.A29   gastrointestinal      yes Gastric intestinal metaplasia with dysplasia, unspecified
M31.10    immunological         yes Thrombotic microangiopathy, unspecified
M31.11    immunological         yes Hematopoietic stem cell transplantation-associated thrombotic microangiopathy [HSCT-TMA]
M31.19    immunological         yes Other thrombotic microangiopathy
M35.01    immunological         no  Sjogren syndrome with keratoconjunctivitis
M35.02    immunological         no  Sjogren syndrome with lung involvement
M35.03    immunological         no  Sjogren syndrome with myopathy
M35.04    immunological         no  Sjogren syndrome with tubulo-interstitial nephropathy
M35.05    immunological         no  Sjogren syndrome with inflammatory arthritis
M35.06    immunological         no  Sjogren syndrome with peripheral nervous system involvement
M35.07    immunological         no  Sjogren syndrome with central nervous system involvement
M35.08    immunological         no  Sjogren syndrome with gastrointestinal involvement
M35.09    immunological         no  Sjogren syndrome with other organ involvement
M35.0A    immunological         no  Sjogren syndrome with glomerular disease
M35.0B    immunological         no  Sjogren syndrome with vasculitis
M35.0C    immunological         no  Sjogren syndrome with dental involvement
U09.9     immunological         no  Post COVID-19 condition, unspecified
D59.32    immunological         yes Hereditary hemolytic-uremic syndrome
D68.00    hematological         no  Von Willebrand disease, unspecified
D68.01    hematological         no  Von Willebrand disease, type 1
D68.020   hematological         no  Von Willebrand disease, type 2A
D68.021   hematological         no  Von Willebrand disease, type 2B
D68.022   hematological         no  Von Willebrand disease, type 2M
D68.023   hematological         no  Von Willebrand disease, type 2N
D68.029   hematological         no  Von Willebrand disease, type 2, unspecified
D68.03    hematological         yes Von Willebrand disease, type 3
D68.04    hematological         no  Acquired von Willebrand disease
D68.09    hematological         no  Other von Willebrand disease
D81.82    immunological         yes Activated Phosphoinositide 3-kinase Delta Syndrome [APDS]
E34.30    endocrinological      no  Short stature due to endocrine disorder, unspecified
E34.321   endocrinological      no  Primary insulin-like growth factor-1 (IGF-1) deficiency
E34.322   endocrinological      no  Insulin-like growth factor-1 (IGF-1) resistance
E34.328   endocrinological      no  Other genetic causes of short stature
E34.329   endocrinological      no  Unspecified genetic causes of short stature
E34.39    endocrinological      no  Other short stature due to endocrine disorder
E87.22    metabolic             no  Chronic metabolic acidosis
F02.811   neurological          yes Dementia in other diseases classified elsewhere, unspecified severity, with agitation
F02.818   neurological          yes Dementia in other diseases classified elsewhere, unspecified severity, with other behavioral disturbance
F02.82    neurological          yes Dementia in other diseases classified elsewhere, unspecified severity, with psychotic disturbance
F02.83    neurological          yes Dementia in other diseases classified elsewhere, unspecified severity, with mood disturbance
F02.84    neurological          yes Dementia in other diseases classified elsewhere, unspecified severity, with anxiety
F02.A0    neurological          yes Dementia in other diseases classified elsewhere, mild, without behavioral disturbance, psychotic disturbance, mood disturbance, and anxiety
F02.A11   neurological          yes Dementia in other diseases classified elsewhere, mild, with agitation
F02.A18   neurological          yes Dementia in other diseases classified elsewhere, mild, with other behavioral disturbance
F02.A2    neurological          yes Dementia in other diseases classified elsewhere, mild, with psychotic disturbance
F02.A3    neurological          yes Dementia in other diseases classified elsewhere, mild, with mood disturbance
F02.A4    neurological          yes Dementia in other diseases classified elsewhere, mild, with anxiety
F02.B0    neurological          yes Dementia in other diseases classified elsewhere, moderate, without behavioral disturbance, psychotic disturbance, mood disturbance, and anxiety
F02.B11   neurological          yes Dementia in other diseases classified elsewhere, moderate, with agitation
F02.B18   neurological          yes Dementia in other diseases classified elsewhere, moderate, with other behavioral disturbance
F02.B2    neurological          yes Dementia in other diseases classified elsewhere, moderate, with psychotic disturbance
F02.B3    neurological          yes Dementia in other diseases classified elsewhere, moderate, with mood disturbance
F02.B4    neurological          yes Dementia in other diseases classified elsewhere, moderate, with anxiety
F02.C0    neurological          yes Dementia in other diseases classified elsewhere, severe, without behavioral disturbance, psychotic disturbance, mood disturbance, and anxiety
F02.C11   neurological          yes Dementia in other diseases classified elsewhere, severe, with agitation
F02.C18   neurological          yes Dementia in other diseases classified elsewhere, severe, with other behavioral disturbance
F02.C2    neurological          yes Dementia in other diseases classified elsewhere, severe, with psychotic disturbance
F02.C3    neurological          yes Dementia in other diseases classified elsewhere, severe, with mood disturbance
F02.C4    neurological          yes Dementia in other diseases classified elsewhere, severe, with anxiety
F03.911   neurological          yes Unspecified dementia, unspecified severity, with agitation
F03.918   neurological          yes Unspecified dementia, unspecified severity, with other behavioral disturbance
F03.92    neurological          yes Unspecified dementia, unspecified severity, with psychotic disturbance
F03.93    neurological          yes Unspecified dementia, unspecified severity, with mood disturbance
F03.94    neurological          yes Unspecified dementia, unspecified severity, with anxiety
F03.A0    neurological          yes Unspecified dementia, mild, without behavioral disturbance, psychotic disturbance, mood disturbance, and anxiety
F03.A11   neurological          yes Unspecified dementia, mild, with agitation
F03.A18   neurological          yes Unspecified dementia, mild, with other behavioral disturbance
F03.A2    neurological          yes Unspecified dementia, mild, with psychotic disturbance
F03.A3    neurological          yes Unspecified dementia, mild, with mood disturbance
F03.A4    neurological          yes Unspecified dementia, mild, with anxiety
F03.B0    neurological          yes Unspecified dementia, moderate, without behavioral disturbance, psychotic disturbance, mood disturbance, and anxiety
F03.B11   neurological          yes Unspecified dementia, moderate, with agitation
F03.B18   neurological          yes Unspecified dementia, moderate, with other behavioral disturbance
F03.B2    neurological          yes Unspecified dementia, moderate, with psychotic disturbance
F03.B3    neurological          yes Unspecified dementia, moderate, with mood disturbance
F03.B4    neurological          yes Unspecified dementia, moderate, with anxiety
F03.C0    neurological          yes Unspecified dementia, severe, without behavioral disturbance, psychotic disturbance, mood disturbance, and anxiety
F03.C11   neurological          yes Unspecified dementia, severe, with agitation
F03.C18   neurological          yes Unspecified dementia, severe, with other behavioral disturbance
F03.C2    neurological          yes Unspecified dementia, severe, with psychotic disturbance
F03.C3    neurological          yes Unspecified dementia, severe, with mood disturbance
F03.C4    neurological          yes Unspecified dementia, severe, with anxiety
F06.70    neurological          no  Mild neurocognitive disorder due to known physiological condition without behavioral disturbance
F06.71    neurological          no  Mild neurocognitive disorder due to known physiological condition with behavioral disturbance
F43.81    mental health         no  Prolonged grief disorder
G71.031   musculoskeletal       yes Autosomal dominant limb girdle muscular dystrophy
G71.032   musculoskeletal       yes Autosomal recessive limb girdle muscular dystrophy due to calpain-3 dysfunction
G71.033   musculoskeletal       yes Limb girdle muscular dystrophy due to dysferlin dysfunction
G71.0340  musculoskeletal       yes Limb girdle muscular dystrophy due to sarcoglycan dysfunction, unspecified
G71.0341  musculoskeletal       yes Limb girdle muscular dystrophy due to alpha sarcoglycan dysfunction
G71.0342  musculoskeletal       yes Limb girdle muscular dystrophy due to beta sarcoglycan dysfunction
G71.0349  musculoskeletal       yes Limb girdle muscular dystrophy due to other sarcoglycan dysfunction
G71.035   musculoskeletal       yes Limb girdle muscular dystrophy due to anoctamin-5 dysfunction
G71.038   musculoskeletal       yes Other limb girdle muscular dystrophy
G71.039   musculoskeletal       yes Limb girdle muscular dystrophy, unspecified
G90.A     cardiac               no  Postural orthostatic tachycardia syndrome [POTS]
G93.32    neurological          no  Myalgic encephalomyelitis/chronic fatigue syndrome
I34.89    cardiac               no  Other nonrheumatic mitral valve disorders
I47.20    cardiac               no  Ventricular tachycardia, unspecified
I47.21    cardiac               no  Torsades de pointes
I47.29    cardiac               no  Other ventricular tachycardia
I71.20    cardiac               no  Thoracic aortic aneurysm, without rupture, unspecified
I71.21    cardiac               no  Aneurysm of the ascending aorta, without rupture
I71.22    cardiac               no  Aneurysm of the aortic arch, without rupture
I71.23    cardiac               no  Aneurysm of the descending thoracic aorta, without rupture
I71.40    cardiac               no  Abdominal aortic aneurysm, without rupture, unspecified
I71.41    cardiac               no  Pararenal abdominal aortic aneurysm, without rupture
I71.42    cardiac               no  Juxtarenal abdominal aortic aneurysm, without rupture
I71.43    cardiac               no  Infrarenal abdominal aortic aneurysm, without rupture
I71.61    cardiac               no  Supraceliac aneurysm of the abdominal aorta, without rupture
I71.62    cardiac               no  Paravisceral aneurysm of the abdominal aorta, without rupture
I77.82    cardiac               no  Antineutrophilic cytoplasmic antibody [ANCA] vasculitis
M51.A0    musculoskeletal       no  Intervertebral annulus fibrosus defect, lumbar region, unspecified size
M51.A1    musculoskeletal       no  Intervertebral annulus fibrosus defect, small, lumbar region
M51.A2    musculoskeletal       no  Intervertebral annulus fibrosus defect, large, lumbar region
M51.A3    musculoskeletal       no  Intervertebral annulus fibrosus defect, lumbosacral region, unspecified size
M51.A4    musculoskeletal       no  Intervertebral annulus fibrosus defect, small, lumbosacral region
M51.A5    musculoskeletal       no  Intervertebral annulus fibrosus defect, large, lumbosacral region
M62.5A0   musculoskeletal       no  Muscle wasting and atrophy, not elsewhere classified, back, cervical
M62.5A1   musculoskeletal       no  Muscle wasting and atrophy, not elsewhere classified, back, thoracic
M62.5A2   musculoskeletal       no  Muscle wasting and atrophy, not elsewhere classified, back, lumbosacral
M62.5A9   musculoskeletal       no  Muscle wasting and atrophy, not elsewhere classified, back, unspecified level
M93.024   musculoskeletal       no  Chronic slipped upper femoral epiphysis, stable (nontraumatic), bilateral hips
N80.00    genitourinary         no  Endometriosis of the uterus, unspecified
N80.01    genitourinary         no  Superficial endometriosis of the uterus
N80.02    genitourinary         no  Deep endometriosis of the uterus
N80.03    genitourinary         no  Adenomyosis of the uterus
N80.101   genitourinary         no  Endometriosis of right ovary, unspecified depth
N80.102   genitourinary         no  Endometriosis of left ovary, unspecified depth
N80.103   genitourinary         no  Endometriosis of bilateral ovaries, unspecified depth
N80.109   genitourinary         no  Endometriosis of ovary, unspecified side, unspecified depth
N80.111   genitourinary         no  Superficial endometriosis of right ovary
N80.112   genitourinary         no  Superficial endometriosis of left ovary
N80.113   genitourinary         no  Superficial endometriosis of bilateral ovaries
N80.119   genitourinary         no  Superficial endometriosis of ovary, unspecified ovary
N80.121   genitourinary         no  Deep endometriosis of right ovary
N80.122   genitourinary         no  Deep endometriosis of left ovary
N80.123   genitourinary         no  Deep endometriosis of bilateral ovaries
N80.129   genitourinary         no  Deep endometriosis of ovary, unspecified ovary
N80.201   genitourinary         no  Endometriosis of right fallopian tube, unspecified depth
N80.202   genitourinary         no  Endometriosis of left fallopian tube, unspecified depth
N80.203   genitourinary         no  Endometriosis of bilateral fallopian tubes, unspecified depth
N80.209   genitourinary         no  Endometriosis of unspecified fallopian tube, unspecified depth
N80.211   genitourinary         no  Superficial endometriosis of right fallopian tube
N80.212   genitourinary         no  Superficial endometriosis of left fallopian tube
N80.213   genitourinary         no  Superficial endometriosis of bilateral fallopian tubes
N80.219   genitourinary         no  Superficial endometriosis of unspecified fallopian tube
N80.221   genitourinary         no  Deep endometriosis of right fallopian tube
N80.222   genitourinary         no  Deep endometriosis of left fallopian tube
N80.223   genitourinary         no  Deep endometriosis of bilateral fallopian tubes
N80.229   genitourinary         no  Deep endometriosis of unspecified fallopian tube
N80.30    genitourinary         no  Endometriosis of pelvic peritoneum, unspecified
N80.311   genitourinary         no  Superficial endometriosis of the anterior cul-de-sac
N80.312   genitourinary         no  Deep endometriosis of the anterior cul-de-sac
N80.319   genitourinary         no  Endometriosis of the anterior cul-de-sac, unspecified depth
N80.321   genitourinary         no  Superficial endometriosis of the posterior cul-de-sac
N80.322   genitourinary         no  Deep endometriosis of the posterior cul-de-sac
N80.329   genitourinary         no  Endometriosis of the posterior cul-de-sac, unspecified depth
N80.331   genitourinary         no  Superficial endometriosis of the right pelvic sidewall
N80.332   genitourinary         no  Superficial endometriosis of the left pelvic sidewall
N80.333   genitourinary         no  Superficial endometriosis of bilateral pelvic sidewall
N80.339   genitourinary         no  Superficial endometriosis of pelvic sidewall, unspecified side
N80.341   genitourinary         no  Deep endometriosis of the right pelvic sidewall
N80.342   genitourinary         no  Deep endometriosis of the left pelvic sidewall
N80.343   genitourinary         no  Deep endometriosis of the bilateral pelvic sidewall
N80.349   genitourinary         no  Deep endometriosis of the pelvic sidewall, unspecified side
N80.351   genitourinary         no  Endometriosis of the right pelvic sidewall, unspecified depth
N80.352   genitourinary         no  Endometriosis of the left pelvic sidewall, unspecified depth
N80.353   genitourinary         no  Endometriosis of bilateral pelvic sidewall, unspecified depth
N80.359   genitourinary         no  Endometriosis of pelvic sidewall, unspecified side, unspecified depth
N80.361   genitourinary         no  Superficial endometriosis of the right pelvic brim
N80.362   genitourinary         no  Superficial endometriosis of the left pelvic brim
N80.363   genitourinary         no  Superficial endometriosis of bilateral pelvic brim
N80.369   genitourinary         no  Superficial endometriosis of the pelvic brim, unspecified side
N80.371   genitourinary         no  Deep endometriosis of the right pelvic brim
N80.372   genitourinary         no  Deep endometriosis of the left pelvic brim
N80.373   genitourinary         no  Deep endometriosis of bilateral pelvic brim
N80.379   genitourinary         no  Deep endometriosis of the pelvic brim, unspecified side
N80.381   genitourinary         no  Endometriosis of the right pelvic brim, unspecified depth
N80.382   genitourinary         no  Endometriosis of the left pelvic brim, unspecified depth
N80.383   genitourinary         no  Endometriosis of bilateral pelvic brim, unspecified depth
N80.389   genitourinary         no  Endometriosis of the pelvic brim, unspecified side, unspecified depth
N80.391   genitourinary         no  Superficial endometriosis of the pelvic peritoneum, other specified sites
N80.392   genitourinary         no  Deep endometriosis of the pelvic peritoneum, other specified sites
N80.399   genitourinary         no  Endometriosis of the pelvic peritoneum, other specified sites, unspecified depth
N80.3A1   genitourinary         no  Superficial endometriosis of the right uterosacral ligament
N80.3A2   genitourinary         no  Superficial endometriosis of the left uterosacral ligament
N80.3A3   genitourinary         no  Superficial endometriosis of the bilateral uterosacral ligament(s)
N80.3A9   genitourinary         no  Superficial endometriosis of the uterosacral ligament(s), unspecified side
N80.3B1   genitourinary         no  Deep endometriosis of the right uterosacral ligament
N80.3B2   genitourinary         no  Deep endometriosis of the left uterosacral ligament
N80.3B3   genitourinary         no  Deep endometriosis of bilateral uterosacral ligament(s)
N80.3B9   genitourinary         no  Deep endometriosis of the uterosacral ligament(s), unspecified side
N80.3C1   genitourinary         no  Endometriosis of the right uterosacral ligament, unspecified depth
N80.3C2   genitourinary         no  Endometriosis of the left uterosacral ligament, unspecified depth
N80.3C3   genitourinary         no  Endometriosis of bilateral uterosacral ligament(s), unspecified depth
N80.3C9   genitourinary         no  Endometriosis of the uterosacral ligament(s), unspecified side, unspecified depth
N80.40    genitourinary         no  Endometriosis of rectovaginal septum, unspecified involvement of vagina
N80.41    genitourinary         no  Endometriosis of rectovaginal septum without involvement of vagina
N80.42    genitourinary         no  Endometriosis of rectovaginal septum with involvement of vagina
N80.50    genitourinary         no  Endometriosis of intestine, unspecified
N80.511   genitourinary         no  Superficial endometriosis of the rectum
N80.512   genitourinary         no  Deep endometriosis of the rectum
N80.519   genitourinary         no  Endometriosis of the rectum, unspecified depth
N80.521   genitourinary         no  Superficial endometriosis of the sigmoid colon
N80.522   genitourinary         no  Deep endometriosis of the sigmoid colon
N80.529   genitourinary         no  Endometriosis of the sigmoid colon, unspecified depth
N80.531   genitourinary         no  Superficial endometriosis of the cecum
N80.532   genitourinary         no  Deep endometriosis of the cecum
N80.539   genitourinary         no  Endometriosis of the cecum, unspecified depth
N80.541   genitourinary         no  Superficial endometriosis of the appendix
N80.542   genitourinary         no  Deep endometriosis of the appendix
N80.549   genitourinary         no  Endometriosis of the appendix, unspecified depth
N80.551   genitourinary         no  Superficial endometriosis of other parts of the colon
N80.552   genitourinary         no  Deep endometriosis of other parts of the colon
N80.559   genitourinary         no  Endometriosis of other parts of the colon, unspecified depth
N80.561   genitourinary         no  Superficial endometriosis of the small intestine
N80.562   genitourinary         no  Deep endometriosis of the small intestine
N80.569   genitourinary         no  Endometriosis of the small intestine, unspecified depth
N80.A0    genitourinary         no  Endometriosis of bladder, unspecified depth
N80.A1    genitourinary         no  Superficial endometriosis of bladder
N80.A2    genitourinary         no  Deep endometriosis of bladder
N80.A41   genitourinary         no  Superficial endometriosis of right ureter
N80.A42   genitourinary         no  Superficial endometriosis of left ureter
N80.A43   genitourinary         no  Superficial endometriosis of bilateral ureters
N80.A49   genitourinary         no  Superficial endometriosis of unspecified ureter
N80.A51   genitourinary         no  Deep endometriosis of right ureter
N80.A52   genitourinary         no  Deep endometriosis of left ureter
N80.A53   genitourinary         no  Deep endometriosis of bilateral ureters
N80.A59   genitourinary         no  Deep endometriosis of unspecified ureter
N80.A61   genitourinary         no  Endometriosis of right ureter, unspecified depth
N80.A62   genitourinary         no  Endometriosis of left ureter, unspecified depth
N80.A63   genitourinary         no  Endometriosis of bilateral ureters, unspecified depth
N80.A69   genitourinary         no  Endometriosis of unspecified ureter, unspecified depth
N80.B1    genitourinary         no  Endometriosis of pleura
N80.B2    genitourinary         no  Endometriosis of lung
N80.B31   genitourinary         no  Superficial endometriosis of diaphragm
N80.B32   genitourinary         no  Deep endometriosis of diaphragm
N80.B39   genitourinary         no  Endometriosis of diaphragm, unspecified depth
N80.B4    genitourinary         no  Endometriosis of the pericardial space
N80.B5    genitourinary         no  Endometriosis of the mediastinal space
N80.B6    genitourinary         no  Endometriosis of cardiothoracic space
N80.C0    genitourinary         no  Endometriosis of the abdomen, unspecified
N80.C10   genitourinary         no  Endometriosis of the anterior abdominal wall, subcutaneous tissue
N80.C11   genitourinary         no  Endometriosis of the anterior abdominal wall, fascia and muscular layers
N80.C19   genitourinary         no  Endometriosis of the anterior abdominal wall, unspecified depth
N80.C2    genitourinary         no  Endometriosis of the umbilicus
N80.C3    genitourinary         no  Endometriosis of the inguinal canal
N80.C4    genitourinary         no  Endometriosis of extra-pelvic abdominal peritoneum
N80.C9    genitourinary         no  Endometriosis of other site of abdomen
N80.D0    genitourinary         no  Endometriosis of the pelvic nerves, unspecified
N80.D1    genitourinary         no  Endometriosis of the sacral splanchnic nerves
N80.D2    genitourinary         no  Endometriosis of the sacral nerve roots
N80.D3    genitourinary         no  Endometriosis of the obturator nerve
N80.D4    genitourinary         no  Endometriosis of the sciatic nerve
N80.D5    genitourinary         no  Endometriosis of the pudendal nerve
N80.D6    genitourinary         no  Endometriosis of the femoral nerve
N80.D9    genitourinary         no  Endometriosis of other pelvic nerve
N85.A     genitourinary         no  Isthmocele
P28.32    pulmonary/respiratory no  Primary obstructive sleep apnea of newborn
P28.42    pulmonary/respiratory no  Obstructive apnea of newborn
P28.43    pulmonary/respiratory no  Mixed neonatal apnea of newborn
Q21.10    cardiac               no  Atrial septal defect, unspecified
Q21.11    cardiac               no  Secundum atrial septal defect
Q21.12    cardiac               no  Patent foramen ovale
Q21.13    cardiac               no  Coronary sinus atrial septal defect
Q21.14    cardiac               no  Superior sinus venosus atrial septal defect
Q21.15    cardiac               no  Inferior sinus venosus atrial septal defect
Q21.16    cardiac               no  Sinus venosus atrial septal defect, unspecified
Q21.19    cardiac               no  Other specified atrial septal defect
Q21.20    cardiac               no  Atrioventricular septal defect, unspecified as to partial or complete
Q21.21    cardiac               no  Partial atrioventricular septal defect
Q21.22    cardiac               no  Transitional atrioventricular septal defect
Q21.23    cardiac               no  Complete atrioventricular septal defect
Q85.81    malignancy            yes PTEN tumor syndrome
Q85.82    malignancy            yes Other Cowden syndrome
Q85.83    malignancy            yes Von Hippel-Lindau syndrome
Q85.89    neurological          yes Other phakomatoses, not elsewhere classified
F34.8     mental health         no  Disruptive Mood Dysregulation Disorder
F34.81    mental health         no  Disruptive mood dysregulation disorder
F40.10    mental health         no  Social anxiety disorder
F41.1     mental health         no  Generalized anxiety disorder (by history)
F41.8     mental health         no  Mixed Anxiety and Depressive Disorder
F41.9     mental health         no  Unspecified Anxiety Disorder
F43.10    mental health         no  Posttraumatic Stress Disorder, Chronic
F43.22    mental health         no  Adjustment disorder with anxiety
F43.23    mental health         no  Adjustment Disorder, with Mixed Anxiety and Depressed Mood
F64.2     mental health         no  Gender dysphoria in pediatric patient
F80       mental health         no  Articulation disorder
F80.2     neurological          no  Mixed receptive-expressive language disorder
F80.4     neurological          no  Speech and language development delay due to hearing loss
F80.9     mental health         no  Unspecified Communication Disorder
F93.0     mental health         no  Separation Anxiety Disorder
F98.9     mental health         no  Unspecified, Disruptive, Impulse Control, and Conduct Disorder
G31.84    mental health         no  Mild Neurocognitive Disorder Due To Another Medical Condition
G93.0     neurological          no  Arachnoid Cyst
G93.40    neurological          yes Encephalopathy, Unspecified
G93.49    neurological          yes Static Encephalopathy
Q86.0     neurological          yes Fetal alcohol spectrum disorder: alcohol-related neurodevelopmental disorder (FASD:ARND)
R41.844   neurological          yes Frontal lobe and executive function deficit
R41.9     neurological          no  Neurocognitive Disorder associated with medical condition (myotonic dystrophy)
R47.02    neurological          no  Language disorder
R48.0     neurological          no  Acquired Dyslexia
R62.51    metabolic             no  Failure to thrive
S06.309S  neurological          yes Late Effects of Intracranial Injury, Left Parietal Skull Fracture
Z86.73    neurological          yes History of CVA (cerebrovascular accident)
Z87.730   craniofacial          no  History of corrected cleft lip and palate
Z87.82    neurological          yes History of Multiple Concussions
Z92.21    malignancy            n/a Status Post-Chemotherapy
D13.91    gastrointestinal      no  Familial adenomatous polyposis
D13.99    gastrointestinal      no  Benign neoplasm of ill-defined sites within the digestive system
D48.1     malignancy            yes Neoplasm of uncertain behavior of connective and other soft tissue
D48.110   malignancy            yes Desmoid tumor of head and neck
D48.111   malignancy            yes Desmoid tumor of chest wall
D48.112   malignancy            yes Desmoid tumor, intrathoracic
D48.113   malignancy            yes Desmoid tumor of abdominal wall
D48.114   malignancy            yes Desmoid tumor, intraabdominal
D48.115   malignancy            yes Desmoid tumor of upper extremity and shoulder girdle
D48.116   malignancy            yes Desmoid tumor of lower extremity and pelvic girdle
D48.117   malignancy            yes Desmoid tumor of back
D48.118   malignancy            yes Desmoid tumor of other site
D48.119   malignancy            yes Desmoid tumor of unspecified site
D48.19    malignancy            yes Other specified neoplasm of uncertain behavior of connective and other soft tissue
D57.04    hematological         yes Hb-SS disease with dactylitis
D57.214   hematological         yes Sickle-cell/Hb-C disease with dactylitis
D57.414   hematological         yes Sickle-cell thalassemia, unspecified, with dactylitis
D57.434   hematological         yes Sickle-cell thalassemia beta zero with dactylitis
D57.454   hematological         yes Sickle-cell thalassemia beta plus with dactylitis
D57.814   hematological         yes Other sickle-cell disorders with dactylitis
D61.02    hematological         yes Shwachman-Diamond syndrome
D89.84    immunological         yes IgG4-related disease
E20.8     endocrinological      no  Other hypoparathyroidism
E20.810   endocrinological      no  Autosomal dominant hypocalcemia
E20.811   endocrinological      no  Secondary hypoparathyroidism in diseases classified elsewhere
E20.812   endocrinological      no  Autoimmune hypoparathyroidism
E20.818   endocrinological      no  Other specified hypoparathyroidism due to impaired parathyroid hormone secretion
E20.819   endocrinological      no  Hypoparathyroidism due to impaired parathyroid hormone secretion, unspecified
E20.89    endocrinological      no  Other specified hypoparathyroidism
E74.05    metabolic             yes Lysosome-associated membrane protein 2 [LAMP2] deficiency
E79.8     metabolic             yes Other disorders of purine and pyrimidine metabolism
E79.82    metabolic             no  Hereditary xanthinuria
E79.89    metabolic             yes Other specified disorders of purine and pyrimidine metabolism
E88.43    metabolic             yes Disorders of mitochondrial tRNA synthetases
E88.81    metabolic             no  Metabolic syndrome
E88.810   metabolic             no  Metabolic syndrome
E88.811   metabolic             no  Insulin resistance syndrome, Type A
E88.818   metabolic             no  Other insulin resistance
E88.819   metabolic             no  Insulin resistance, unspecified
E79.81    immunological         yes Aicardi-Goutieres syndrome
G37.81    immunological         no  Myelin oligodendrocyte glycoprotein antibody disease
E88.A     metabolic             no  Wasting disease (syndrome) due to underlying condition
G11.5     neurological          yes Hypomyelination - hypogonadotropic hypogonadism - hypodontia
G11.6     neurological          yes Leukodystrophy with vanishing white matter disease
G23.3     neurological          yes Hypomyelination with atrophy of the basal ganglia and cerebellum
G31.80    neurological          yes Leukodystrophy, unspecified
G31.86    neurological          yes Alexander disease
G37.8     neurological          yes Other specified demyelinating diseases of central nervous system
E75.27    neurological          yes Pelizaeus-Merzbacher disease
E75.28    neurological          yes Canavan disease
G37.89    neurological          yes Other specified demyelinating diseases of central nervous system
G40.C01   neurological          yes Lafora progressive myoclonus epilepsy, not intractable, with status epilepticus
G40.C09   neurological          yes Lafora progressive myoclonus epilepsy, not intractable, without status epilepticus
G40.C11   neurological          yes Lafora progressive myoclonus epilepsy, intractable, with status epilepticus
G40.C19   neurological          yes Lafora progressive myoclonus epilepsy, intractable, without status epilepticus
G43.E01   neurological          no  Chronic migraine with aura, not intractable, with status migrainosus
G43.E09   neurological          no  Chronic migraine with aura, not intractable, without status migrainosus
G43.E11   neurological          no  Chronic migraine with aura, intractable, with status migrainosus
G43.E19   neurological          no  Chronic migraine with aura, intractable, without status migrainosus
G90.B     neurological          yes LMNB1-related autosomal dominant leukodystrophy
G93.42    neurological          yes Megaloencephalic leukoencephalopathy with subcortical cysts
G93.43    neurological          yes Leukoencephalopathy with calcifications and cysts
H36.811   ophthalmological      no  Nonproliferative sickle-cell retinopathy, right eye
H36.812   ophthalmological      no  Nonproliferative sickle-cell retinopathy, left eye
H36.813   ophthalmological      no  Nonproliferative sickle-cell retinopathy, bilateral
H36.819   ophthalmological      no  Nonproliferative sickle-cell retinopathy, unspecified eye
H36.821   ophthalmological      no  Proliferative sickle-cell retinopathy, right eye
H36.822   ophthalmological      no  Proliferative sickle-cell retinopathy, left eye
H36.823   ophthalmological      no  Proliferative sickle-cell retinopathy, bilateral
H36.829   ophthalmological      no  Proliferative sickle-cell retinopathy, unspecified eye
H36.89    ophthalmological      no  Other retinal disorders in diseases classified elsewhere
I1A.0     cardiac               no  Resistant hypertension
I25.85    cardiac               yes Chronic coronary microvascular dysfunction
I47.1     cardiac               no  Supraventricular tachycardia
I47.10    cardiac               no  Supraventricular tachycardia, unspecified
I47.11    cardiac               no  Inappropriate sinus tachycardia, so stated
I47.19    cardiac               no  Other supraventricular tachycardia
J4A.0     pulmonary/respiratory yes Restrictive allograft syndrome
J4A.8     pulmonary/respiratory yes Other chronic lung allograft dysfunction
J4A.9     pulmonary/respiratory yes Chronic lung allograft dysfunction, unspecified
N02.B1    renal                 yes Recurrent and persistent immunoglobulin A nephropathy with glomerular lesion
N02.B2    renal                 yes Recurrent and persistent immunoglobulin A nephropathy with focal and segmental glomerular lesion
N02.B3    renal                 yes Recurrent and persistent immunoglobulin A nephropathy with diffuse membranoproliferative glomerulonephritis
N02.B4    renal                 yes Recurrent and persistent immunoglobulin A nephropathy with diffuse membranous glomerulonephritis
N02.B5    renal                 yes Recurrent and persistent immunoglobulin A nephropathy with diffuse mesangial proliferative glomerulonephritis
N02.B6    renal                 yes Recurrent and persistent immunoglobulin A nephropathy with diffuse mesangiocapillary glomerulonephritis
N02.B9    renal                 yes Other recurrent and persistent immunoglobulin A nephropathy
N04.2     renal                 yes Nephrotic syndrome with diffuse membranous glomerulonephritis
N04.20    renal                 yes Nephrotic syndrome with diffuse membranous glomerulonephritis, unspecified
N04.21    renal                 yes Primary membranous nephropathy with nephrotic syndrome
N04.22    renal                 yes Secondary membranous nephropathy with nephrotic syndrome
N04.29    renal                 yes Other nephrotic syndrome with diffuse membranous glomerulonephritis
N06.2     renal                 yes Isolated proteinuria with diffuse membranous glomerulonephritis
N06.20    renal                 yes Isolated proteinuria with diffuse membranous glomerulonephritis, unspecified
N06.21    renal                 yes Primary membranous nephropathy with isolated proteinuria
N06.22    renal                 yes Secondary membranous nephropathy with isolated proteinuria
N06.29    renal                 yes Other isolated proteinuria with diffuse membranous glomerulonephritis
Q87.83    renal                 yes Bardet-Biedl syndrome
Q87.84    renal                 yes Laurence-Moon syndrome
K90.821   gastrointestinal      yes Short bowel syndrome with colon in continuity
K90.822   gastrointestinal      yes Short bowel syndrome without colon in continuity
K90.829   gastrointestinal      yes Short bowel syndrome, unspecified
K90.83    gastrointestinal      yes Intestinal failure
Q44.7     gastrointestinal      yes Other congenital malformations of liver
Q44.70    gastrointestinal      yes Other congenital malformation of liver, unspecified
Q44.71    gastrointestinal      yes Alagille syndrome
Q44.79    gastrointestinal      yes Other congenital malformations of liver
Q75.0     craniofacial          no  Craniosynostosis
Q75.001   craniofacial          no  Craniosynostosis unspecified, unilateral
Q75.002   craniofacial          no  Craniosynostosis unspecified, bilateral
Q75.009   craniofacial          no  Craniosynostosis unspecified
Q75.01    craniofacial          no  Sagittal craniosynostosis
Q75.021   craniofacial          no  Coronal craniosynostosis unilateral
Q75.022   craniofacial          no  Coronal craniosynostosis bilateral
Q75.029   craniofacial          no  Coronal craniosynostosis unspecified
Q75.03    craniofacial          no  Metopic craniosynostosis
Q75.041   craniofacial          no  Lambdoid craniosynostosis, unilateral
Q75.042   craniofacial          no  Lambdoid craniosynostosis, bilateral
Q75.049   craniofacial          no  Lambdoid craniosynostosis, unspecified
Q75.051   craniofacial          yes Cloverleaf skull
Q75.052   craniofacial          no  Pansynostosis
Q75.058   craniofacial          no  Other multi-suture craniosynostosis
Q75.08    craniofacial          no  Other single-suture craniosynostosis
Q87.85    neurological          yes MED13L syndrome
Q93.52    neurological          no  Phelan-McDermid syndrome
R40.2A    neurological          yes Nontraumatic coma due to underlying condition
I42       cardiac               yes CARDIOMYOPATHY
Q20       cardiac               yes CONGENITAL MALFORMATIONS OF CARDIAC CHAMBERS AND CNNECTIONS
Q20.9     cardiac               yes CONGENITAL MALFORMATION OF CARDIAC CHAMBERS AND CONNECTIONS, UNSPECIFI
Q21       cardiac               no  CONGENITAL MALFORMATIONS OF CARDIAC SEPTA
Q22       cardiac               no  CONGENITAL MALFORMATIONS OF PULMONARY AND TRICUSPID VALVES
Q22.6     cardiac               yes HYPOPLASTIC RIGHT HEART SYNDROME
Q22.8     cardiac               yes OTHER CONGENITAL MALFORMATIONS OF TRICUSPID VALVE
Q23       cardiac               no  CONGENITAL MALFORMATIONS OF AORTIC AND MITRAL VALVES
Q24       cardiac               no  OTHER CONGENITAL MALFORMATIONS OF HEART
Q24.0     cardiac               no  DEXTROCARDIA
Q24.1     cardiac               yes LEVOCARDIA
Q25       cardiac               yes CONGENITAL MALFORMATIONS OF GREAT ARTERIES
Q25.0     cardiac               no  PATENT DUCTUS ARTERIOSUS
Q25.8     cardiac               yes OTHER CONGENITAL MALFORMATIONS OF OTHER GREAT ARTERIES
Q25.9     cardiac               yes CONGENITAL MALFORMATION OF GREAT ARTERIES, UNSPECIFIED
Q26       cardiac               no  CONGENITAL MALFORMATION OF GREAT VEINS
Q26.0     cardiac               yes CONGENITAL STENOSIS OF VENA CAVA
Q26.1     cardiac               no  PERSISTENT LEFT SUPERIOR VENA CAVA
Q26.2     cardiac               yes TOTAL ANOMALOUS PULMONARY VENOUS CONNECTION
Q26.3     cardiac               yes PARTIAL ANOMALOUS PULMONARY VENOUS CONNECTION
Q26.4     cardiac               yes ANOMALOUS PULMONARY VENOUS CONNECTION, UNSPECIFIED
Q26.5     cardiac               no  ANOMALOUS PORTAL VENOUS CONNECTION
Q26.6     cardiac               yes PORTAL VEIN-HEPATIC ARTERY FISTULA
Q26.8     cardiac               yes OTHER CONGENITAL MALFORMATIONS OF GREAT VEINS
Q87       genetic               yes OTHER SPECIFIED CONGENITAL MALFORMATION SYNDROMES AFFECTING MULTIPLE S
Q87.8     genetic               yes OTHER SPECIFIED CONGENITAL MALFORMATION SYNDROMES, NOT ELSEWHERE CLASS
Q87.82    cardiac               yes Arterial tortuosity syndrome
;
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

ods _all_ close ;

