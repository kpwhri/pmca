################################
### 2020-10-13 converted to R
### 2021-11-02 modified code somewhat to make customization easier
### by Julie McGalliard
### Seattle Children's Hospital Research Institute
#######################clear the air
rm(list = ls())
gc()
####################################################################
start_time <- Sys.time()
start_date <- Sys.Date()
######################
#PACKAGES 
library(RCurl)
library(tidyverse)
library(lubridate)
library(xlsx)
library(readxl)
library(tidyr)
library(dplyr)
library(reshape2)

######### This section will need to be customized when the code is run in a different environment 
######### Or with a different data set 
######### 

### SET last date of the processing period
last_date <- as.Date("2021-09-30")
last_date_txt <- format(last_date,"%Y%m%d")

### SET WORKSPACE AND PATHS
basedir <- paste("c:/???",sep="") ### remember to set your directory before running the code

setwd(basedir)

in_path <- paste(basedir,"raw_data/",sep="")
check_path <- paste(basedir,"check_data/",sep="")
out_path <- paste(basedir,"out_data/",sep="")

### Get patient data 
### expects an Excel file with the columns: 
# ENC_ID : Encounter identifier
# DIAG_CD : ICD9 or ICD10 code 
# DIAG_DESC : Description of code 
# DIAG_SEQ_KEY : will be -1 if no diagnosis is entered, these records are dropped
# HSP_ACCT_ID : Unique claim
# ENC_ADMIT_DT : Encounter admit date
# MRN_ID : Unique individual

### If data will come in a different format, please adjust code accordingly
### Or format the data before loading here

### Combine patient information 
### Historic file with data up to FY 2014
xfile_old <- "ERG_PMCA_DX_FY09_FY14.xlsx"
sh3 <- read_excel(paste(in_path,xfile_old,sep=""),sheet="Sheet1")

### Recently downloaded Excel file from BI Launchpad
xfile <- paste("ERG_PMCA_DX_FY15_",last_date_txt,".xlsx",sep="")
sh1 <- read_excel(paste(in_path,xfile,sep=""), sheet = "Sheet1")
### Sheet2 doesn't have any column names so paste those before inputting
sh2 <- read_excel(paste(in_path,xfile,sep=""), sheet = "Sheet2")

### Read in any additional datasets here
### rbind them into one dataset

df <- rbind(sh1,sh2,sh3)

### Get ICD9 and ICD10 codes with their PMCA systems assignment
### Expects an Excel sheet in format:
# start_code : the ICD code that will start the diagnosis
# system : the PMCA system the code belongs to
# no_chars : the number of characters in the start_code

icd9 <- read_excel(paste( basedir,"icd9_pmca_systems.xlsx",sep=""),sheet = "Sheet1")
icd10 <- read_excel(paste( basedir,"icd10_pmca_systems.xlsx",sep=""),sheet = "Sheet1")
              
######### The code below should not typically need to be changed 

# Body Systems of interest 
### create list of system codes

 systems <- data.frame("code" = "cardiac","label" = "cardiac","id"="")
 systems <- rbind(systems,data.frame("code" = "cranio","label" = "craniofacial","id"=""))
 systems <- rbind(systems,data.frame("label"="dermatological","code"="derm","id"=""))
 systems <- rbind(systems,data.frame("label"="endocrinological","code"="endo","id"=""))
 systems <- rbind(systems,data.frame("label"="gastrointestinal","code"="gastro","id"=""))
 systems <- rbind(systems,data.frame("label"="genetic","code"="genetic","id"=""))
 systems <- rbind(systems,data.frame("label"="genitourinary","code"="genito","id"=""))
 systems <- rbind(systems,data.frame("label"="hematological","code"="hemato","id"=""))
 systems <- rbind(systems,data.frame("label"="immunological","code"="immuno","id"=""))
 systems <- rbind(systems,data.frame("label"="malignancy","code"="malign","id"=""))
 systems <- rbind(systems,data.frame("label"="mental health","code"="mh","id"=""))
 systems <- rbind(systems,data.frame("label"="metabolic","code"="metab","id"=""))
 systems <- rbind(systems,data.frame("label"="musculoskeletal","code"="musculo","id"=""))
 systems <- rbind(systems,data.frame("label"="neurological","code"="neuro","id"=""))
 systems <- rbind(systems,data.frame("label"="pulmonary-respiratory","code"="pulresp","id"=""))
 systems <- rbind(systems,data.frame("label"="renal","code"="renal","id"=""))
 systems <- rbind(systems,data.frame("label"="ophthalmological","code"="opthal","id"=""))
 systems <- rbind(systems,data.frame("label"="otologic","code"="otol","id"=""))
 systems <- rbind(systems,data.frame("label"="otolaryngological","code"="otolar","id"=""))
 systems <- rbind(systems,data.frame("label"="progressive","code"="progressive","id"=""))
 
 systems <- as.data.frame(systems, 
               stringsAsFactors = FALSE)
 

####################### process the input data
### convert ENC_ADMIT_DT to real date
df$admit_dt <- as.Date(df$ENC_ADMIT_DT, format = "%Y-%m-%d")

### if DIAG_SEQ_KEY = -1, no diagnosis entered, drop

df <- subset(df, df$DIAG_SEQ_KEY != "-1")

### if admit date after end of this processing period, drop

df <- subset(df,df$admit_dt <= last_date)

### remove duplicate rows

df <- unique(df)

### get LAST admit date for each MRN

mrn_master <- subset(df,select = c("MRN_ID"))
mrn_master <- unique(mrn_master)

### latest admit date for each mrn
lastd <- df %>% group_by(MRN_ID) %>% arrange(admit_dt) %>% slice(n()) %>% ungroup

### get "earliest date" per mrn
### drop dates earlier than that

lastd$earliest <- as.Date(lastd$admit_dt - 1095) ### *365 x 3 = 1095
lastd <- subset(lastd,select= c("MRN_ID","earliest"))

df <- merge(x=df,y=lastd,by="MRN_ID",all.x=TRUE)

df$drop <- ifelse(df$admit_dt < df$earliest,1,0)

df <- subset(df,df$drop != '1')

#########################################################################################
### rename 

mydata <- df
colnames(mydata )[colnames(mydata)== "MRN_ID"] <- "mrn" ## unique person
colnames(mydata )[colnames(mydata)== "HSP_ACCT_ID"] <- "har" ## unique claim
colnames(mydata )[colnames(mydata)== "DIAG_CD"] <- "dx" ## variable containing icd 9 & 10 codes

### get unique har and dx set
har_dx <- subset(mydata,select = c("har","dx"))
har_dx <- unique(har_dx)

### start processing dx codes
### determine if ICD 9 or ICD 10

### remove the dot
har_dx$dx <- gsub("\\.","",har_dx$dx)
### get first character
har_dx$first <- substring(har_dx$dx,1,1)
### if first is A-Z excluding E and V codes -- definitely ICD 10
icd10list <- c('A', 'B', 'C', 'D', 'F', 'G' ,'H', 'I', 'J', 'K', 'L' ,'M', 'N',
               'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'W' ,'X' ,'Y', 'Z')

har_dx$icd10 <- ifelse(har_dx$first %in% icd10list,1,0)

### if first is 0-9 -- definitely ICD 9
icd9list <- c(0:9)
har_dx$icd9 <- ifelse(har_dx$first %in% icd9list,1,0)

### get if E
har_dx$icde <- ifelse(har_dx$first == 'E',1,0)

### unique datset of just mrn and har
mrn_har <- subset(mydata,select = c("mrn",'har'))
mrn_har <- unique(mrn_har)

har_icd <- har_dx %>% group_by(har) %>% summarize(icd10ct = sum(icd10),icd9ct = sum(icd9),icdect = sum(icde))

  har_icd$icd10codeset <- 0
  # if at least one ICD-10 code then mark entire claim;
  har_icd$icd10codeset <- ifelse(har_icd$icd10ct > 0,1,har_icd$icd10codeset)
  # if just one code and it is an E-code;
  har_icd$icd10codeset <- ifelse(har_icd$icd10ct == 0 
                                 & har_icd$icd9ct == 0 
                                 & har_icd$icdect == 1,1,har_icd$icd10codeset)
  
  ### all other cases leave as 0
  ### potential data check
  ### write.csv(har_icd ,file = paste(check_path,"/har_icd.csv",sep=""),row.names=FALSE,na="")
  
  ### merge the icd10codeset variable back into the har_dx recordset
  har_dx <- subset(har_dx,select = c("har","dx"))
  har_dx <- merge(x=har_dx,y=har_icd,by="har",all=TRUE)
  har_dx <- subset(har_dx,select= c("har","dx","icd10codeset"))
  har_dx10 <- subset(har_dx,har_dx$icd10codeset == 1)
  har_dx9 <- subset(har_dx,har_dx$icd10codeset!= 1)
  
  ### looping the icd codes 
  ### as a function
  getSystem <- function(icd_base,sys_code,har_base){
     sys_loop <- subset(icd_base,icd_base$system == sys_code)
     foundit <- data.frame("har"=00000,"dx"="dx")
     if (nrow(sys_loop) < 1){return(foundit)}
     for (row in 1:nrow(sys_loop)){
       start_code <- tolower(sys_loop$start_code[row])
       no_chars <- sys_loop$no_chars[row]
       tmp <- har_base
       tmp$test <- tolower(substring(tmp$dx,1,no_chars))
       tmp$found <- ifelse(tmp$test == start_code,1,0)
       tmp2 <- subset(tmp,tmp$found == 1,select=c("har","dx"))
       foundit <- rbind(foundit,tmp2)
     }
     return(foundit)
  }
  
  ### ICD 10 claims
  matches_10 <- har_dx10
  
  ### Loop systems
  for (row in 1:nrow(systems)){
    mysystem <- systems$code[row]
    print(mysystem)
    matches <- getSystem(icd10,mysystem,har_dx10)
    matches$result <- 1
    colnames(matches)[colnames(matches)== "result"] <- as.character(mysystem)
    colnames((matches))
    matches_10 <- merge(x=matches_10,y=matches,by=c("har","dx"),all.x=TRUE)
  }
  
  ### Potential data check
  ### write.csv(matches_10 ,file = paste(check_path,"/matches_10.csv",sep=""),row.names=FALSE,na="")
  
  ### ICD 9 claims
  matches_9 <- har_dx9
  
  ### loop through systems
  for (row in 1:nrow(systems)){
    mysystem <- systems$code[row]
    print(mysystem)
    matches <- getSystem(icd9,mysystem,har_dx9)
    matches$result <- 1
    colnames(matches)[colnames(matches)== "result"] <- as.character(mysystem)
    colnames((matches))
    matches_9 <- merge(x=matches_9,y=matches,by=c("har","dx"),all.x=TRUE)
  }
  
  ### Potential data check
  ### write.csv(matches_9 ,file = paste(check_path,"/matches_9.csv",sep=""),row.names=FALSE,na="")
  
  ### combine 9 and 10
  har_icd_final <- rbind(matches_9,matches_10)
  
  ### all NA to 0 
  har_icd_final[is.na(har_icd_final)] <- 0
  
  ### compress each claim into one
  ### using group_by 
  har_sum <- har_icd_final %>% group_by(har) %>% summarize(
    cardiac_t= sum(cardiac),
    cranio_t= sum(cranio),
    derm_t= sum(derm),
    endo_t= sum(endo),
    gastro_t= sum(gastro),
    genetic_t= sum(genetic),
    genito_t= sum(genito),
    hemato_t= sum(hemato),
    immuno_t= sum(immuno),
    malign_t= sum(malign),
    mh_t= sum(mh),
    metab_t= sum(metab),
    musculo_t= sum(musculo),
    neuro_t= sum(neuro),
    pulresp_t= sum(pulresp),
    renal_t= sum(renal),
    opthal_t= sum(opthal),
    otol_t= sum(otol),
    otolar_t= sum(otolar),
    progressive_t= sum(progressive))
  
  har_sum$cardiac_yn <- ifelse(har_sum$cardiac_t >0,1,0)
  har_sum$cranio_yn <- ifelse(har_sum$cranio_t >0,1,0)
  har_sum$derm_yn <- ifelse(har_sum$derm_t >0,1,0)
  har_sum$endo_yn <- ifelse(har_sum$endo_t >0,1,0)
  har_sum$gastro_yn <- ifelse(har_sum$gastro_t >0,1,0)
  har_sum$genetic_yn <- ifelse(har_sum$genetic_t >0,1,0)
  har_sum$genito_yn <- ifelse(har_sum$genito_t >0,1,0)
  har_sum$hemato_yn <- ifelse(har_sum$hemato_t >0,1,0)
  har_sum$immuno_yn <- ifelse(har_sum$immuno_t >0,1,0)
  har_sum$malign_yn <- ifelse(har_sum$malign_t >0,1,0)
  har_sum$mh_yn <- ifelse(har_sum$mh_t >0,1,0)
  har_sum$metab_yn <- ifelse(har_sum$metab_t >0,1,0)
  har_sum$musculo_yn <- ifelse(har_sum$musculo_t >0,1,0)
  har_sum$neuro_yn <- ifelse(har_sum$neuro_t >0,1,0)
  har_sum$pulresp_yn <- ifelse(har_sum$pulresp_t >0,1,0)
  har_sum$renal_yn <- ifelse(har_sum$renal_t >0,1,0)
  har_sum$opthal_yn <- ifelse(har_sum$opthal_t >0,1,0)
  har_sum$otol_yn <- ifelse(har_sum$otol_t >0,1,0)
  har_sum$otolar_yn <- ifelse(har_sum$otolar_t >0,1,0)
  har_sum$progressive_yn <- ifelse(har_sum$progressive_t >0,1,0)
    
   ### Potential data check
   ### write.csv(har_sum ,file = paste(check_path,"/har_sum.csv",sep=""),row.names=FALSE,na="")
  
   ### now get PMCA designations  
  
   ### first: join up har with mrn
       mrn_har_sum <- merge(x=mrn_har,y=har_sum,by="har",all.x=TRUE) 
    
   ### Potential data check
   ### write.csv(mrn_har_sum ,file = paste(check_path,"/mrn_har_sum.csv",sep=""),row.names=FALSE,na="")  
       
   #  Roll up to one record per person, with a single flag for each body system, a sum across claims for
   #  each body system, and presence of a progressive condition or malignancy. 
   #  Calculate final condition determinations.  
       
       ### get sum across claims
       
       mrn_sum <- mrn_har_sum %>% group_by(mrn) %>% summarize(
         cardiac_claims= sum(cardiac_yn),
         cranio_claims= sum(cranio_yn),
         derm_claims= sum(derm_yn),
         endo_claims= sum(endo_yn),
         gastro_claims= sum(gastro_yn),
         genetic_claims= sum(genetic_yn),
         genito_claims= sum(genito_yn),
         hemato_claims= sum(hemato_yn),
         immuno_claims= sum(immuno_yn),
         malign_claims= sum(malign_yn),
         mh_claims= sum(mh_yn),
         metab_claims= sum(metab_yn),
         musculo_claims= sum(musculo_yn),
         neuro_claims= sum(neuro_yn),
         pulresp_claims= sum(pulresp_yn),
         renal_claims= sum(renal_yn),
         opthal_claims= sum(opthal_yn),
         otol_claims= sum(otol_yn),
         otolar_claims= sum(otolar_yn),
         progressive_claims= sum(progressive_yn))
       
       ### indicator yn
       mrn_sum$cardiac_any <- ifelse(mrn_sum$cardiac_claims >0,1,0)
       mrn_sum$cranio_any <- ifelse(mrn_sum$cranio_claims >0,1,0)
       mrn_sum$derm_any <- ifelse(mrn_sum$derm_claims >0,1,0)
       mrn_sum$endo_any <- ifelse(mrn_sum$endo_claims >0,1,0)
       mrn_sum$gastro_any <- ifelse(mrn_sum$gastro_claims >0,1,0)
       mrn_sum$genetic_any <- ifelse(mrn_sum$genetic_claims >0,1,0)
       mrn_sum$genito_any <- ifelse(mrn_sum$genito_claims >0,1,0)
       mrn_sum$hemato_any <- ifelse(mrn_sum$hemato_claims >0,1,0)
       mrn_sum$immuno_any <- ifelse(mrn_sum$immuno_claims >0,1,0)
       mrn_sum$malign_any <- ifelse(mrn_sum$malign_claims >0,1,0)
       mrn_sum$mh_any <- ifelse(mrn_sum$mh_claims >0,1,0)
       mrn_sum$metab_any <- ifelse(mrn_sum$metab_claims >0,1,0)
       mrn_sum$musculo_any <- ifelse(mrn_sum$musculo_claims >0,1,0)
       mrn_sum$neuro_any <- ifelse(mrn_sum$neuro_claims >0,1,0)
       mrn_sum$pulresp_any <- ifelse(mrn_sum$pulresp_claims >0,1,0)
       mrn_sum$renal_any <- ifelse(mrn_sum$renal_claims >0,1,0)
       mrn_sum$opthal_any <- ifelse(mrn_sum$opthal_claims >0,1,0)
       mrn_sum$otol_any <- ifelse(mrn_sum$otol_claims >0,1,0)
       mrn_sum$otolar_any <- ifelse(mrn_sum$otolar_claims >0,1,0)
       mrn_sum$progressive_any <- ifelse(mrn_sum$progressive_claims >0,1,0)
       
       
       ### a row sum gives claims where more than one system was tagged
       mrn_sum$systems_any =  mrn_sum$cardiac_any+
         mrn_sum$cranio_any+
         mrn_sum$derm_any+
         mrn_sum$endo_any+
         mrn_sum$gastro_any+
         mrn_sum$genetic_any+
         mrn_sum$genito_any+
         mrn_sum$hemato_any+
         mrn_sum$immuno_any+
         ### malign is not a system 
         mrn_sum$mh_any+
         mrn_sum$metab_any+
         mrn_sum$musculo_any+
         mrn_sum$neuro_any+
         mrn_sum$pulresp_any+
         mrn_sum$renal_any+
         mrn_sum$opthal_any+
         mrn_sum$otol_any+
         mrn_sum$otolar_any
         ### progressive is not a system  

      ### Potential data check
      # write.csv(mrn_sum ,file = paste(check_path,"/mrn_sum.csv",sep=""),row.names=FALSE,na="")  
       
       ### use only cond_less, the less conservative algorithm
       
    #    'Complex Chronic':  1) more than one body system is involved, OR 
    #                     2) one or more conditions are progressive, OR 
    #                     3) one or more conditions are malignant
       
    mrn_sum$cc_3 <- ifelse(mrn_sum$systems_any >= 2 | mrn_sum$progressive_any >= 1 | mrn_sum$malign_any >= 1,1,0)
    
    # 'Non-complex Chronic': 1) only one body system is involved, AND 
    #                        2) the condition is not progressive or malignant
    # 
    
    mrn_sum$ncc_2 <- ifelse(mrn_sum$systems_any == 1 & mrn_sum$progressive_any < 1 & mrn_sum$malign_any < 1,1,0)
    
    # 'Non-Chronic': 		1) no body system indicators are present, AND 
    #                   2) the condition is not progressive or malignant
    
    mrn_sum$nc_1 <- ifelse(mrn_sum$systems_any < 1 & mrn_sum$progressive_any < 1 & mrn_sum$malign_any < 1,1,0)
    
    ### give text designation
    mrn_sum$PMCA_category <- ifelse(mrn_sum$cc_3 == 1,"Complex Chronic",
                                    ifelse(mrn_sum$ncc_2 == 1,"Non-complex Chronic","Non-chronic"))
    
    ### potential data check
    # write.csv(mrn_sum ,file = paste(check_path,"/mrn_sum.csv",sep=""),row.names=FALSE,na="")  
    
    ### now, the final stage! 
    ### output a file called pmca_end_YYYYMMDD.csv last_date_txt
    ### variables are mrn = mrn, PMCA_category text, Update_Date = m/d/yyyy
    mrn_pmca <- subset(mrn_sum, select=c("mrn","PMCA_category"))
    mrn_pmca$Update_Date <- format(last_date,"%m/%d/%Y")
    
    write.csv(mrn_pmca ,file = paste(out_path,"/pmca_end_",last_date_txt,".csv",sep=""),row.names=FALSE,na="")

##### how long did that take?
    end_time <- Sys.time()
    run_time <- end_time - start_time
    print(run_time)
##############################################################
