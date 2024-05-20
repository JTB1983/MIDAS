#Population weights for MIDAS GP practices
#Age-sex-deprivation-ethnicity weights per practice using Feb 2023 age-sex 
#population structure of each practice
#Code can be adapted to different period or different practices

#George Peat (Sheffield Hallam University) and Dahai Yu (Keele University), April 2024
#Funded by Nuffield Foundation & Versus Arthritis (OBF/43390)

#Suggested citation: Peat G, Yu D. Deriving practice-specific age-sex-IMD-ethnicity weights for general practices in England [R code], April 2024. doi as per OSF/GitHub entry

library(tidyverse)
library(dplyr)
library(readxl)
library(readr)
library(ggplot2)
library(sf)
library(viridis)
library(plotly)
library("reshape")
library("reshape2")
library(openxlsx2)
library(readr)
library(data.table)

#import practice age-sex and select only MIDAS practices 
#source: https://digital.nhs.uk/data-and-information/publications/statistical/patients-registered-at-a-gp-practice
gp_reg_pat_prac_quin_age <- read_csv("gp-reg-pat-prac-quin-age.csv")
gp_reg_pat_prac_quin_age2 <- subset(gp_reg_pat_prac_quin_age, select = -c(PUBLICATION, EXTRACT_DATE, ORG_TYPE, ONS_CODE, POSTCODE))
gp_reg_pat_prac_quin_age3 <- subset(gp_reg_pat_prac_quin_age2, SEX!="ALL")
age_MIDAS30 <- subset(gp_reg_pat_prac_quin_age3, 
                        ORG_CODE=="M83004" |
                          ORG_CODE=="M83014" |
                          ORG_CODE=="M83015" |
                          ORG_CODE=="M83023" |
                          ORG_CODE=="M83025" |
                          ORG_CODE=="M83034" |
                          ORG_CODE=="M83038" |
                          ORG_CODE=="M83054" |
                          ORG_CODE=="M83056" |
                          ORG_CODE=="M83061" |
                          ORG_CODE=="M83068" |
                          ORG_CODE=="M83071" |
                          ORG_CODE=="M83075" |
                          ORG_CODE=="M83079" |
                          ORG_CODE=="M83090" |
                          ORG_CODE=="M83100" |
                          ORG_CODE=="M83122" |
                          ORG_CODE=="M83123" |
                          ORG_CODE=="M83126" |
                          ORG_CODE=="M83141" |
                          ORG_CODE=="M83143" |
                          ORG_CODE=="M83146" |
                          ORG_CODE=="M83625" |
                          ORG_CODE=="M83632" |
                          ORG_CODE=="M83650" |
                          ORG_CODE=="M83661" |
                          ORG_CODE=="M83682" |
                          ORG_CODE=="M83711" |
                          ORG_CODE=="Y02521" |
                          ORG_CODE=="Y02867")
#reshape and tidy male age data for 30 MIDAS practices
age_MIDAS30_M <- subset(age_MIDAS30,SEX=="MALE")
age_MIDAS30_M <- pivot_wider(age_MIDAS30_M, id_cols=c("ORG_CODE", "SEX"), names_from=AGE_GROUP_5, values_from=NUMBER_OF_PATIENTS)
age_MIDAS30_M <- as_tibble(age_MIDAS30_M)
age_MIDAS30_M <- age_MIDAS30_M %>% rename_at('ORG_CODE', ~'PRACTICE_CODE')
age_MIDAS30_M <- age_MIDAS30_M %>% rename_at('0_4', ~'y0_4')
age_MIDAS30_M <- age_MIDAS30_M %>% rename_at('5_9', ~'y5_9')
age_MIDAS30_M <- age_MIDAS30_M %>% rename_at('10_14', ~'y10_14')
age_MIDAS30_M <- age_MIDAS30_M %>% rename_at('15_19', ~'y15_19')
age_MIDAS30_M <- age_MIDAS30_M %>% rename_at('20_24', ~'y20_24')
age_MIDAS30_M <- age_MIDAS30_M %>% rename_at('25_29', ~'y25_29')
age_MIDAS30_M <- age_MIDAS30_M %>% rename_at('30_34', ~'y30_34')
age_MIDAS30_M <- age_MIDAS30_M %>% rename_at('35_39', ~'y35_39')
age_MIDAS30_M <- age_MIDAS30_M %>% rename_at('40_44', ~'y40_44')
age_MIDAS30_M <- age_MIDAS30_M %>% rename_at('45_49', ~'y45_49')
age_MIDAS30_M <- age_MIDAS30_M %>% rename_at('50_54', ~'y50_54')
age_MIDAS30_M <- age_MIDAS30_M %>% rename_at('55_59', ~'y55_59')
age_MIDAS30_M <- age_MIDAS30_M %>% rename_at('60_64', ~'y60_64')
age_MIDAS30_M <- age_MIDAS30_M %>% rename_at('65_69', ~'y65_69')
age_MIDAS30_M <- age_MIDAS30_M %>% rename_at('70_74', ~'y70_74')
age_MIDAS30_M <- age_MIDAS30_M %>% rename_at('75_79', ~'y75_79')
age_MIDAS30_M <- age_MIDAS30_M %>% rename_at('80_84', ~'y80_84')
age_MIDAS30_M <- age_MIDAS30_M %>% rename_at('85_89', ~'y85_89')
age_MIDAS30_M <- age_MIDAS30_M %>% rename_at('90_94', ~'y90_94')
age_MIDAS30_M <- age_MIDAS30_M %>% rename_at('95+', ~'y95_')
age_MIDAS30_M <- age_MIDAS30_M %>% rename_at('ALL', ~'y0_')
age_MIDAS30_M <- age_MIDAS30_M %>% mutate(
  y0_34 = y0_4+y5_9+y10_14+y15_19+y20_24+y25_29+y30_34,
  y35_44 = y35_39+y40_44,
  y45_54 = y45_49+y50_54,
  y55_64 = y55_59+y60_64,
  y65_74 = y65_69+y70_74,
  y75_84 = y75_79+y80_84,
  y85_ = y85_89+y90_94+y95_,
  y35_ = y35_44+y45_54+y55_64+y65_74+y75_84+y85_)
age_MIDAS30_M <- subset(age_MIDAS30_M, select = -c(
  y0_4, y5_9, y10_14, y15_19, y20_24, y25_29, y30_34, y35_39, 
  y40_44, y45_49, y50_54, y55_59, y60_64, y65_69, y70_74, y75_79, 
  y80_84, y85_89, y90_94, y95_))
#reshape and tidy female age data for 30 MIDAS practices
age_MIDAS30_F <- subset(age_MIDAS30,SEX=="FEMALE")
age_MIDAS30_F <- pivot_wider(age_MIDAS30_F, id_cols=c("ORG_CODE", "SEX"), names_from=AGE_GROUP_5, values_from=NUMBER_OF_PATIENTS)
age_MIDAS30_F <- as_tibble(age_MIDAS30_F)
age_MIDAS30_F <- age_MIDAS30_F %>% rename_at('ORG_CODE', ~'PRACTICE_CODE')
age_MIDAS30_F <- age_MIDAS30_F %>% rename_at('0_4', ~'y0_4')
age_MIDAS30_F <- age_MIDAS30_F %>% rename_at('5_9', ~'y5_9')
age_MIDAS30_F <- age_MIDAS30_F %>% rename_at('10_14', ~'y10_14')
age_MIDAS30_F <- age_MIDAS30_F %>% rename_at('15_19', ~'y15_19')
age_MIDAS30_F <- age_MIDAS30_F %>% rename_at('20_24', ~'y20_24')
age_MIDAS30_F <- age_MIDAS30_F %>% rename_at('25_29', ~'y25_29')
age_MIDAS30_F <- age_MIDAS30_F %>% rename_at('30_34', ~'y30_34')
age_MIDAS30_F <- age_MIDAS30_F %>% rename_at('35_39', ~'y35_39')
age_MIDAS30_F <- age_MIDAS30_F %>% rename_at('40_44', ~'y40_44')
age_MIDAS30_F <- age_MIDAS30_F %>% rename_at('45_49', ~'y45_49')
age_MIDAS30_F <- age_MIDAS30_F %>% rename_at('50_54', ~'y50_54')
age_MIDAS30_F <- age_MIDAS30_F %>% rename_at('55_59', ~'y55_59')
age_MIDAS30_F <- age_MIDAS30_F %>% rename_at('60_64', ~'y60_64')
age_MIDAS30_F <- age_MIDAS30_F %>% rename_at('65_69', ~'y65_69')
age_MIDAS30_F <- age_MIDAS30_F %>% rename_at('70_74', ~'y70_74')
age_MIDAS30_F <- age_MIDAS30_F %>% rename_at('75_79', ~'y75_79')
age_MIDAS30_F <- age_MIDAS30_F %>% rename_at('80_84', ~'y80_84')
age_MIDAS30_F <- age_MIDAS30_F %>% rename_at('85_89', ~'y85_89')
age_MIDAS30_F <- age_MIDAS30_F %>% rename_at('90_94', ~'y90_94')
age_MIDAS30_F <- age_MIDAS30_F %>% rename_at('95+', ~'y95_')
age_MIDAS30_F <- age_MIDAS30_F %>% rename_at('ALL', ~'y0_')
age_MIDAS30_F <- age_MIDAS30_F %>% mutate(
  y0_34 = y0_4+y5_9+y10_14+y15_19+y20_24+y25_29+y30_34,
  y35_44 = y35_39+y40_44,
  y45_54 = y45_49+y50_54,
  y55_64 = y55_59+y60_64,
  y65_74 = y65_69+y70_74,
  y75_84 = y75_79+y80_84,
  y85_ = y85_89+y90_94+y95_,
  y35_ = y35_44+y45_54+y55_64+y65_74+y75_84+y85_)
age_MIDAS30_F <- subset(age_MIDAS30_F, select = -c(
  y0_4, y5_9, y10_14, y15_19, y20_24, y25_29, y30_34, y35_39, 
  y40_44, y45_49, y50_54, y55_59, y60_64, y65_69, y70_74, y75_79, 
  y80_84, y85_89, y90_94, y95_))
#join male and female age datasets together for MIDAS30
agesex_MIDAS30 <- full_join(age_MIDAS30_F, age_MIDAS30_M)
agesex_MIDAS30 <- subset(agesex_MIDAS30, select = -c(y0_, y0_34, y35_))
agesex_MIDAS30 <-
  pivot_longer(
    data = agesex_MIDAS30,
    cols = c(y35_44, y45_54, y55_64, y65_74, y75_84, y85_), 
    names_to = "Age_group", 
    values_to = "N")
#calculate total aged35+ and age-sex weights
agesex_MIDAS30TOT <- aggregate(cbind(N) ~PRACTICE_CODE, data = agesex_MIDAS30, FUN=sum, na.rm=TRUE)
agesex_MIDAS30TOT <- agesex_MIDAS30TOT %>% rename_at('N', ~'N35_')
agesex_MIDAS30 <- full_join(agesex_MIDAS30, agesex_MIDAS30TOT)
agesex_MIDAS30wt <- agesex_MIDAS30 %>% mutate(
                                          AgeSexWeight = N/N35_
                                            )
#check age-sex weights total 1
agesex_MIDAS30check <- aggregate(cbind(AgeSexWeight) ~PRACTICE_CODE, data = agesex_MIDAS30wt, FUN=sum, na.rm=TRUE)

rm(gp_reg_pat_prac_quin_age, 
   gp_reg_pat_prac_quin_age2,
   gp_reg_pat_prac_quin_age3,
   age_MIDAS30,
   age_MIDAS30_F,
   age_MIDAS30_M,
   agesex_MIDAS30,
   agesex_MIDAS30check,
   agesex_MIDAS30TOT,
   agesex_MIDAS30wts
   )

#import IMD2019 data for all LSOAs and select only deciles
#source: https://www.gov.uk/government/statistics/english-indices-of-deprivation-2019
IMD2019 <- read_csv("All_IoD2019_Scores__Ranks__Deciles_and_Population_Denominators_3.csv")                                                         
IMD2019 <- IMD2019 %>% rename_at('LSOA code (2011)', ~'LSOA_CODE')
IMD2019 <- IMD2019 %>% rename_at('Index of Multiple Deprivation (IMD) Decile (where 1 is most deprived 10% of LSOAs)', ~'IMD2019d')
IMD2019d <- subset(IMD2019, select = c(LSOA_CODE, IMD2019d))

#import ethnicity by LSOA from Census 2021 via NOMIS TS021
#source: https://www.nomisweb.co.uk/datasets/c2021ts021
NOMIS_Ethnicity_LSOA_TS021 <- read_csv("NOMIS_Ethnicity_LSOA_TS021.csv")
NOMIS_Ethnicity_clean <- separate(NOMIS_Ethnicity_LSOA_TS021, LSOA, c("LSOA_CODE", "LSOA21NM"), sep = 9)
NOMIS_Ethnicity_clean <- NOMIS_Ethnicity_clean %>% rename_at('Asian%', ~'Asian_Percent')
NOMIS_Ethnicity_clean <- NOMIS_Ethnicity_clean %>% rename_at('Black%', ~'Black_Percent')
NOMIS_Ethnicity_clean <- NOMIS_Ethnicity_clean %>% rename_at('MixedMultiple%', ~'MixedMultiple_Percent')
NOMIS_Ethnicity_clean <- NOMIS_Ethnicity_clean %>% rename_at('White%', ~'White_Percent')
NOMIS_Ethnicity_clean <- NOMIS_Ethnicity_clean %>% rename_at('Other%', ~'Other_Percent')
NOMIS_Ethnicity_clean2 <- NOMIS_Ethnicity_clean %>% mutate(
  Asian_Prop = Asian_Percent/100,
  Black_Prop = Black_Percent/100,
  MixedMultiple_Prop = MixedMultiple_Percent/100,
  White_Prop = White_Percent/100,
  Other_Prop = Other_Percent/100)
NOMIS_Ethnicity_clean2 <- subset(NOMIS_Ethnicity_clean2, 
  select = c(LSOA_CODE, 
             Asian_Prop, 
             Black_Prop, 
             MixedMultiple_Prop, 
             White_Prop, 
             Other_Prop
             )) 
rm(IMD2019,
   NOMIS_Ethnicity_clean,
   NOMIS_Ethnicity_LSOA_TS021
   )
#import GP population by LSOA by sex, tidy, limit to MIDAS30 and merge M and F
gp_reg_pat_prac_lsoa_female <- read_csv("gp-reg-pat-prac-lsoa-female.csv")
gp_reg_pat_prac_lsoa_female2 <- subset(gp_reg_pat_prac_lsoa_female, select = -c(PUBLICATION, EXTRACT_DATE))
lsoa_MIDAS30_F <- subset(gp_reg_pat_prac_lsoa_female2, 
                        PRACTICE_CODE=="M83004" |
                        PRACTICE_CODE=="M83014" |
                        PRACTICE_CODE=="M83015" |
                        PRACTICE_CODE=="M83023" |
                        PRACTICE_CODE=="M83025" |
                        PRACTICE_CODE=="M83034" |
                        PRACTICE_CODE=="M83038" |
                        PRACTICE_CODE=="M83054" |
                        PRACTICE_CODE=="M83056" |
                        PRACTICE_CODE=="M83061" |
                        PRACTICE_CODE=="M83068" |
                        PRACTICE_CODE=="M83071" |
                        PRACTICE_CODE=="M83075" |
                        PRACTICE_CODE=="M83079" |
                        PRACTICE_CODE=="M83090" |
                        PRACTICE_CODE=="M83100" |
                        PRACTICE_CODE=="M83122" |
                        PRACTICE_CODE=="M83123" |
                        PRACTICE_CODE=="M83126" |
                        PRACTICE_CODE=="M83141" |
                        PRACTICE_CODE=="M83143" |
                        PRACTICE_CODE=="M83146" |
                        PRACTICE_CODE=="M83625" |
                        PRACTICE_CODE=="M83632" |
                        PRACTICE_CODE=="M83650" |
                        PRACTICE_CODE=="M83661" |
                        PRACTICE_CODE=="M83682" |
                        PRACTICE_CODE=="M83711" |
                        PRACTICE_CODE=="Y02521" |
                        PRACTICE_CODE=="Y02867")
gp_reg_pat_prac_lsoa_male <- read_csv("gp-reg-pat-prac-lsoa-male.csv")
gp_reg_pat_prac_lsoa_male2 <- subset(gp_reg_pat_prac_lsoa_male, select = -c(PUBLICATION, EXTRACT_DATE))
lsoa_MIDAS30_M <- subset(gp_reg_pat_prac_lsoa_male2, 
                              PRACTICE_CODE=="M83004" |
                                PRACTICE_CODE=="M83014" |
                                PRACTICE_CODE=="M83015" |
                                PRACTICE_CODE=="M83023" |
                                PRACTICE_CODE=="M83025" |
                                PRACTICE_CODE=="M83034" |
                                PRACTICE_CODE=="M83038" |
                                PRACTICE_CODE=="M83054" |
                                PRACTICE_CODE=="M83056" |
                                PRACTICE_CODE=="M83061" |
                                PRACTICE_CODE=="M83068" |
                                PRACTICE_CODE=="M83071" |
                                PRACTICE_CODE=="M83075" |
                                PRACTICE_CODE=="M83079" |
                                PRACTICE_CODE=="M83090" |
                                PRACTICE_CODE=="M83100" |
                                PRACTICE_CODE=="M83122" |
                                PRACTICE_CODE=="M83123" |
                                PRACTICE_CODE=="M83126" |
                                PRACTICE_CODE=="M83141" |
                                PRACTICE_CODE=="M83143" |
                                PRACTICE_CODE=="M83146" |
                                PRACTICE_CODE=="M83625" |
                                PRACTICE_CODE=="M83632" |
                                PRACTICE_CODE=="M83650" |
                                PRACTICE_CODE=="M83661" |
                                PRACTICE_CODE=="M83682" |
                                PRACTICE_CODE=="M83711" |
                                PRACTICE_CODE=="Y02521" |
                                PRACTICE_CODE=="Y02867")
lsoa_MIDAS30 <- full_join(lsoa_MIDAS30_F, lsoa_MIDAS30_M)

#join IMD2019d to practice LSOA by sex
lsoaIMD2019d_MIDAS30 <- merge(lsoa_MIDAS30, IMD2019d, by = "LSOA_CODE", all.x = TRUE)

#join ethnicity by LSOA to above
lsoaIMD2019dEthn_MIDAS30 <- merge(lsoaIMD2019d_MIDAS30, NOMIS_Ethnicity_clean2, by = "LSOA_CODE", all.x = TRUE)

#calculate estimated numbers of each ethnic group in each LSOA in each practice (all ages)
sexdepethnwt_MIDAS30 <- lsoaIMD2019dEthn_MIDAS30 %>% mutate(
  Asian_N = Asian_Prop * NUMBER_OF_PATIENTS,
  Black_N = Black_Prop * NUMBER_OF_PATIENTS,
  MixedMultiple_N = MixedMultiple_Prop * NUMBER_OF_PATIENTS,
  White_N = White_Prop * NUMBER_OF_PATIENTS,
  Other_N = Other_Prop * NUMBER_OF_PATIENTS)
sdesort <-  sexdepethnwt_MIDAS30 %>% as.data.frame() %>% arrange(PRACTICE_CODE, SEX, IMD2019d)
#calculate subtotals for sex-dep-ethnicity weights
sdesort2 <- aggregate(cbind(NUMBER_OF_PATIENTS, Asian_N, Black_N, MixedMultiple_N, White_N, Other_N) ~PRACTICE_CODE+SEX+IMD2019d, data = sdesort, FUN=sum, na.rm=TRUE)
sdesort2 <- sdesort2 %>% arrange(PRACTICE_CODE, SEX, IMD2019d)
TOTPAT <- aggregate(cbind(NUMBER_OF_PATIENTS) ~PRACTICE_CODE+SEX, data = sdesort2, FUN=sum, na.rm=TRUE)
names(TOTPAT)[names(TOTPAT) == "NUMBER_OF_PATIENTS"] <- "Total_Patients_Sex"
sdesort3 <- full_join(sdesort2, TOTPAT)
#calculate practice- and sex-specific deprivation weights 
sdesort4 <- sdesort3 %>% mutate(
  Deprivwt = NUMBER_OF_PATIENTS/Total_Patients_Sex)
#calculation practice- and sex- and deprivation decile-specific ethnicity weights
sde_MIDAS30 <-
  pivot_longer(
    data = sdesort4,
    cols = c(Asian_N, Black_N, MixedMultiple_N, White_N, Other_N), 
    names_to = "Ethnic_group", 
    values_to = "n")
sde_MIDAS30wt <- sde_MIDAS30 %>% mutate(
  Ethnicwt = n/NUMBER_OF_PATIENTS,
  DepxEthnicwt = Ethnicwt * Deprivwt)
sde_MIDAS30wt <- subset(sde_MIDAS30wt, select = c(PRACTICE_CODE, SEX, IMD2019d, Ethnic_group, DepxEthnicwt))
sde_MIDAS30wt$Ethnic_group <- recode(sde_MIDAS30wt$Ethnic_group, 
                                      Asian_N = 'Asian', 
                                      Black_N = 'Black',
                                      MixedMultiple_N = 'MixedMultiple',
                                      White_N = 'White',
                                      Other_N = 'Other',
                                      )
rm(gp_reg_pat_prac_lsoa_female,
   gp_reg_pat_prac_lsoa_female2,
   gp_reg_pat_prac_lsoa_male,
   gp_reg_pat_prac_lsoa_male2,
   IMD2019d,
   lsoa_MIDAS30,
   lsoa_MIDAS30_F,
   lsoa_MIDAS30_M,
   lsoaIMD2019d_MIDAS30,
   lsoaIMD2019dEthn_MIDAS30,
   NOMIS_Ethnicity_clean2,
   sde_MIDAS30,
   sde_MIDAS30check,
   sdesort,
   sdesort2,
   sdesort3,
   sdesort4,
   sexdepethnwt_MIDAS30,
   TOTPAT
   )
#merge datasets to combine age-sex weights with deprivation-ethnicity weights
FinalWeights_MIDAS30 <- full_join(agesex_MIDAS30wt, sde_MIDAS30wt)
FinalWeights_MIDAS30w <- FinalWeights_MIDAS30 %>% mutate(
  Weight = DepxEthnicwt * AgeSexWeight)
#check weights add to 1 for each practice
weightcheck <- aggregate(cbind(Weight) ~PRACTICE_CODE, data = FinalWeights_MIDAS30w, FUN=sum, na.rm=TRUE)
#final tidy up and export
FinalWeights_MIDAS30w$Age_group <- recode(FinalWeights_MIDAS30w$Age_group, 
                                  y35_44 = '35_44', 
                                  y45_54 = '45_54',
                                  y55_64 = '55_64',
                                  y65_74 = '65_74',
                                  y75_84 = '75_84',
                                  y85_ = '85_'
                                  )
FinalWeights_MIDAS30wt <-  FinalWeights_MIDAS30w %>% as.data.frame() %>% arrange(PRACTICE_CODE, SEX, Age_group, IMD2019d, Ethnic_group)
FinalWeights_MIDAS30wt <- subset(FinalWeights_MIDAS30wt, 
                                select = c(PRACTICE_CODE, 
                                           SEX, 
                                           Age_group,
                                           IMD2019d,
                                           Ethnic_group,
                                           Weight
                                ))
write_xlsx(FinalWeights_MIDAS30wt, "MIDAS30weights_Feb2023.xlsx")
