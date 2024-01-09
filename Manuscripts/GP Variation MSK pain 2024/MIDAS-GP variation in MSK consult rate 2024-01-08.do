***use "...MIDAS-GP Consult Rate Analysis Dataset 2024-01-08.dta"

***Describe range of values for MSK pop prevalence estimates and determinants
summ RegPop18FProp RegPop1865Prop RegPop1885Prop BAMEpercent wIMDPractice RegPop ClinStaffFTE QOFOverall2022 PositiveExpPercent2022 wPrevMSK_GPPS2022 wPrevChronicPain_PRELIM wPrevHICP_PRELIM QOFObesityPrev2021_2022 OpioidItem1000

***Outcome = Proportion consulting for MSK pain (no exclusions)
***List for Table 1 Results
list MIDAS_GPPID days RegPop18 NScreened NScreenMinusIA MSKProp1 MSKProp2, sum(days RegPop18 NScreened NScreenMinusIA) table
summ days RegPop18 NScreened NScreenMinusIA MSKProp1 MSKProp2, detail

***Relationship with recruitment period, before and after seasonal adjustment
mfp: regress MSKProp1 days
fracplot, mlabel(MIDAS_GPPID)
***Suppl D1
mfp: regress MSKProp1 days LiveInDec
fracplot, mlabel(MIDAS_GPPID)
***additional adjustment for sex and age composition
mfp: regress MSKProp1 days LiveInDec RegPop18FProp RegPop1865Prop
fracplot, mlabel(MIDAS_GPPID)

***Explore relation to underlying population prevalence estimates after adjusting for recruitment period, season, %F, %65+
***Figure 1A
mfp: regress MSKProp1 wPrevMSK_GPPS2022 days LiveInDec RegPop18FProp RegPop1865Prop
fracplot, mlabel(MIDAS_GPPID)
***Figure 1B
mfp: regress MSKProp1 wPrevChronicPain_PRELIM days LiveInDec RegPop18FProp RegPop1865Prop
fracplot, mlabel(MIDAS_GPPID)
***Figure 1C
mfp: regress MSKProp1 wPrevHICP_PRELIM days LiveInDec RegPop18FProp RegPop1865Prop
fracplot, mlabel(MIDAS_GPPID)

**Sensitivity analysis - average GPPS prevalence over 3 years (2021-2023)
mfp: regress MSKProp1 wPrevMSK_GPPS2021_3 days LiveInDec RegPop18FProp RegPop1865Prop
fracplot, mlabel(MIDAS_GPPID)

***Additional exploratory adjustments for quality of coding
mfp: regress MSKProp1 wPrevMSK_GPPS2022 days LiveInDec RegPop18FProp RegPop1865Prop Appointmentsper1000patients
fracplot, mlabel(MIDAS_GPPID)
mfp: regress MSKProp1 wPrevMSK_GPPS2022 days LiveInDec RegPop18FProp RegPop1865Prop GP
fracplot, mlabel(MIDAS_GPPID)
mfp: regress MSKProp1 wPrevMSK_GPPS2022 days LiveInDec RegPop18FProp RegPop1865Prop FacetoFace
fracplot, mlabel(MIDAS_GPPID)
mfp: regress MSKProp1 wPrevChronicPain_PRELIM days LiveInDec RegPop18FProp RegPop1865Prop Appointmentsper1000patients
fracplot, mlabel(MIDAS_GPPID)
mfp: regress MSKProp1 wPrevChronicPain_PRELIM days LiveInDec RegPop18FProp RegPop1865Prop GP
fracplot, mlabel(MIDAS_GPPID)
mfp: regress MSKProp1 wPrevChronicPain_PRELIM days LiveInDec RegPop18FProp RegPop1865Prop FacetoFace
fracplot, mlabel(MIDAS_GPPID)
mfp: regress MSKProp1 wPrevHICP_PRELIM days LiveInDec RegPop18FProp RegPop1865Prop Appointmentsper1000patients
fracplot, mlabel(MIDAS_GPPID)
mfp: regress MSKProp1 wPrevHICP_PRELIM days LiveInDec RegPop18FProp RegPop1865Prop GP
fracplot, mlabel(MIDAS_GPPID)
mfp: regress MSKProp1 wPrevHICP_PRELIM days LiveInDec RegPop18FProp RegPop1865Prop FacetoFace
fracplot, mlabel(MIDAS_GPPID)

mfp: regress MSKProp1 wPrevMSK_GPPS2021_3 days LiveInDec RegPop18FProp RegPop1865Prop Appointmentsper1000patients
fracplot, mlabel(MIDAS_GPPID)
mfp: regress MSKProp1 wPrevMSK_GPPS2021_3 days LiveInDec RegPop18FProp RegPop1865Prop GP
fracplot, mlabel(MIDAS_GPPID)
mfp: regress MSKProp1 wPrevMSK_GPPS2021_3 days LiveInDec RegPop18FProp RegPop1865Prop FacetoFace
fracplot, mlabel(MIDAS_GPPID)

***Plots for supplementary data
mfp: regress MSKProp1 RegPop18FProp days LiveInDec RegPop1865Prop
fracplot, mlabel(MIDAS_GPPID)
mfp: regress MSKProp1 RegPop1865Prop days LiveInDec RegPop18FProp
fracplot, mlabel(MIDAS_GPPID)
mfp: regress MSKProp1 RegPop1885Prop days LiveInDec RegPop18FProp
fracplot, mlabel(MIDAS_GPPID)
mfp: regress MSKProp1 BAMEpercent days LiveInDec RegPop18FProp RegPop1865Prop
fracplot, mlabel(MIDAS_GPPID)
mfp: regress MSKProp1 wIMDPractice days LiveInDec RegPop18FProp RegPop1865Prop
fracplot, mlabel(MIDAS_GPPID)
mfp: regress MSKProp1 RegPop days LiveInDec RegPop18FProp RegPop1865Prop
fracplot, mlabel(MIDAS_GPPID)
mfp: regress MSKProp1 ClinStaffFTE days LiveInDec RegPop18FProp RegPop1865Prop
fracplot, mlabel(MIDAS_GPPID)
mfp: regress MSKProp1 QOFOverall2022 days LiveInDec RegPop18FProp RegPop1865Prop
fracplot, mlabel(MIDAS_GPPID)
mfp: regress MSKProp1 PositiveExpPercent2022 days LiveInDec RegPop18FProp RegPop1865Prop
fracplot, mlabel(MIDAS_GPPID)
mfp: regress MSKProp1 QOFObesityPrev2021_2022 days LiveInDec RegPop18FProp RegPop1865Prop
fracplot, mlabel(MIDAS_GPPID)
mfp: regress MSKProp1 OpioidItem1000 days LiveInDec RegPop18FProp RegPop1865Prop
fracplot, mlabel(MIDAS_GPPID)


***Repeat analyses for outcome = proportion consulting after excluding inflammatory disease only
mfp: regress MSKProp2 days
fracplot, mlabel(MIDAS_GPPID)
mfp: regress MSKProp2 days LiveInDec
fracplot, mlabel(MIDAS_GPPID)

mfp: regress MSKProp2 wPrevMSK_GPPS2022 days LiveInDec
fracplot, mlabel(MIDAS_GPPID)
mfp: regress MSKProp2 wPrevChronicPain_PRELIM days LiveInDec
fracplot, mlabel(MIDAS_GPPID)
mfp: regress MSKProp2 wPrevHICP_PRELIM days LiveInDec
fracplot, mlabel(MIDAS_GPPID)

mfp: regress MSKProp2 RegPop18FProp days LiveInDec
fracplot, mlabel(MIDAS_GPPID)
mfp: regress MSKProp2 RegPop1865Prop days LiveInDec
fracplot, mlabel(MIDAS_GPPID)
mfp: regress MSKProp2 RegPop1885Prop days LiveInDec
fracplot, mlabel(MIDAS_GPPID)
mfp: regress MSKProp2 BAMEpercent days LiveInDec
fracplot, mlabel(MIDAS_GPPID)
mfp: regress MSKProp2 wIMDPractice days LiveInDec
fracplot, mlabel(MIDAS_GPPID)
mfp: regress MSKProp2 RegPop days LiveInDec
fracplot, mlabel(MIDAS_GPPID)
mfp: regress MSKProp2 ClinStaffFTE days LiveInDec
fracplot, mlabel(MIDAS_GPPID)
mfp: regress MSKProp2 QOFOverall2022 days LiveInDec
fracplot, mlabel(MIDAS_GPPID)
mfp: regress MSKProp2 PositiveExpPercent2022 days LiveInDec
fracplot, mlabel(MIDAS_GPPID)
mfp: regress MSKProp2 QOFObesityPrev2021_2022 days LiveInDec
fracplot, mlabel(MIDAS_GPPID)
mfp: regress MSKProp2 OpioidItem1000 days LiveInDec
fracplot, mlabel(MIDAS_GPPID)

***Repeat analyses adjusting for age and sex [outcome = proportion consulting after excluding inflammatory disease only]
mfp: regress MSKProp2 wPrevMSK_GPPS2022 days LiveInDec RegPop18FProp RegPop1865Prop
fracplot, mlabel(MIDAS_GPPID)
mfp: regress MSKProp2 wPrevChronicPain_PRELIM days LiveInDec RegPop18FProp RegPop1865Prop
fracplot, mlabel(MIDAS_GPPID)
mfp: regress MSKProp2 wPrevHICP_PRELIM days LiveInDec RegPop18FProp RegPop1865Prop
fracplot, mlabel(MIDAS_GPPID)

mfp: regress MSKProp2 RegPop18FProp days LiveInDec RegPop1865Prop
fracplot, mlabel(MIDAS_GPPID)
mfp: regress MSKProp2 RegPop1865Prop days LiveInDec RegPop18FProp
fracplot, mlabel(MIDAS_GPPID)
mfp: regress MSKProp2 RegPop1885Prop days LiveInDec RegPop18FProp
fracplot, mlabel(MIDAS_GPPID)
mfp: regress MSKProp2 BAMEpercent days LiveInDec RegPop18FProp RegPop1865Prop
fracplot, mlabel(MIDAS_GPPID)
mfp: regress MSKProp2 wIMDPractice days LiveInDec RegPop18FProp RegPop1865Prop
fracplot, mlabel(MIDAS_GPPID)
mfp: regress MSKProp2 RegPop days LiveInDec RegPop18FProp RegPop1865Prop
fracplot, mlabel(MIDAS_GPPID)
mfp: regress MSKProp2 ClinStaffFTE days LiveInDec RegPop18FProp RegPop1865Prop
fracplot, mlabel(MIDAS_GPPID)
mfp: regress MSKProp2 QOFOverall2022 days LiveInDec RegPop18FProp RegPop1865Prop
fracplot, mlabel(MIDAS_GPPID)
mfp: regress MSKProp2 PositiveExpPercent2022 days LiveInDec RegPop18FProp RegPop1865Prop
fracplot, mlabel(MIDAS_GPPID)
mfp: regress MSKProp2 QOFObesityPrev2021_2022 days LiveInDec RegPop18FProp RegPop1865Prop
fracplot, mlabel(MIDAS_GPPID)
mfp: regress MSKProp2 OpioidItem1000 days LiveInDec RegPop18FProp RegPop1865Prop
fracplot, mlabel(MIDAS_GPPID)
mfp: regress MSKProp2 Availableservtot days LiveInDec RegPop18FProp RegPop1865Prop
fracplot, mlabel(MIDAS_GPPID)
mfp: regress MSKProp2 CDSStot days LiveInDec RegPop18FProp RegPop1865Prop
fracplot, mlabel(MIDAS_GPPID)

***Check expected associations between prevalence estimates and covariates
mfp: regress OpioidItem1000 wPrevMSK_GPPS2022 days
fracplot, mlabel(MIDAS_GPPID)
mfp: regress OpioidItem1000 wPrevChronicPain_PRELIM days
fracplot, mlabel(MIDAS_GPPID)
mfp: regress OpioidItem1000 wPrevHICP_PRELIM days
fracplot, mlabel(MIDAS_GPPID)
mfp: regress wPrevMSK_GPPS2022 wIMDPractice days
fracplot, mlabel(MIDAS_GPPID)
mfp: regress wPrevChronicPain_PRELIM wIMDPractice days
fracplot, mlabel(MIDAS_GPPID)
mfp: regress wPrevHICP_PRELIM wIMDPractice days
fracplot, mlabel(MIDAS_GPPID)

***Likelihood ratio tests for regression models (outcome = MSK consult before exclusions)
mfp: regress MSKProp1 days LiveInDec RegPop1865Prop
estimates store A
mfp: regress MSKProp1 RegPop18FProp days LiveInDec RegPop1865Prop
estimates store B
lrtest A B
mfp: regress MSKProp1 RegPop18FProp days LiveInDec
estimates store C
mfp: regress MSKProp1 RegPop1865Prop days LiveInDec RegPop18FProp
estimates store D
lrtest C D
mfp: regress MSKProp1 RegPop1885Prop days LiveInDec RegPop18FProp
estimates store E
lrtest C E
mfp: regress MSKProp1 days LiveInDec RegPop18FProp RegPop1865Prop
estimates store F
mfp: regress MSKProp1 BAMEpercent days LiveInDec RegPop18FProp RegPop1865Prop
estimates store G
lrtest F G
mfp: regress MSKProp1 wIMDPractice days LiveInDec RegPop18FProp RegPop1865Prop
estimates store H
lrtest F H
mfp: regress MSKProp1 RegPop18 days LiveInDec RegPop18FProp RegPop1865Prop
estimates store I
lrtest F I
mfp: regress MSKProp1 ClinStaffFTE days LiveInDec RegPop18FProp RegPop1865Prop
estimates store J
lrtest F J
mfp: regress MSKProp1 QOFOverall2022 days LiveInDec RegPop18FProp RegPop1865Prop
estimates store K
lrtest F K
mfp: regress MSKProp1 PositiveExpPercent2022 days LiveInDec RegPop18FProp RegPop1865Prop
estimates store L
lrtest F L
mfp: regress MSKProp1 wPrevMSK_GPPS2022 days LiveInDec RegPop18FProp RegPop1865Prop
estimates store M
lrtest F M
mfp: regress MSKProp1 wPrevChronicPain_PRELIM days LiveInDec RegPop18FProp RegPop1865Prop
estimates store N
lrtest F N
mfp: regress MSKProp1 wPrevHICP_PRELIM days LiveInDec RegPop18FProp RegPop1865Prop
estimates store O
lrtest F O
mfp: regress MSKProp1 QOFObesityPrev2021_2022 days LiveInDec RegPop18FProp RegPop1865Prop
estimates store P
lrtest F P
mfp: regress MSKProp1 OpioidItem1000 days LiveInDec RegPop18FProp RegPop1865Prop
estimates store Q
lrtest F Q
mfp: regress MSKProp1 Appointmentsper1000patients days LiveInDec RegPop18FProp RegPop1865Prop
estimates store R
lrtest F R


***LR tests for regression models (outcome = MSK proportion after excluding IA)
mfp: regress MSKProp2 days LiveInDec RegPop1865Prop
estimates store A
mfp: regress MSKProp2 RegPop18FProp days LiveInDec RegPop1865Prop
estimates store B
lrtest A B
mfp: regress MSKProp2 RegPop18FProp days LiveInDec
estimates store C
mfp: regress MSKProp2 RegPop1865Prop days LiveInDec RegPop18FProp
estimates store D
lrtest C D
mfp: regress MSKProp2 RegPop1885Prop days LiveInDec RegPop18FProp
estimates store E
lrtest C E
mfp: regress MSKProp2 days LiveInDec RegPop18FProp RegPop1865Prop
estimates store F
mfp: regress MSKProp2 BAMEpercent days LiveInDec RegPop18FProp RegPop1865Prop
estimates store G
lrtest F G
mfp: regress MSKProp2 wIMDPractice days LiveInDec RegPop18FProp RegPop1865Prop
estimates store H
lrtest F H
mfp: regress MSKProp2 RegPop18 days LiveInDec RegPop18FProp RegPop1865Prop
estimates store I
lrtest F I
mfp: regress MSKProp2 ClinStaffFTE days LiveInDec RegPop18FProp RegPop1865Prop
estimates store J
lrtest F J
mfp: regress MSKProp2 QOFOverall2022 days LiveInDec RegPop18FProp RegPop1865Prop
estimates store K
lrtest F K
mfp: regress MSKProp2 PositiveExpPercent2022 days LiveInDec RegPop18FProp RegPop1865Prop
estimates store L
lrtest F L
mfp: regress MSKProp2 wPrevMSK_GPPS2022 days LiveInDec RegPop18FProp RegPop1865Prop
estimates store M
lrtest F M
mfp: regress MSKProp2 wPrevChronicPain_PRELIM days LiveInDec RegPop18FProp RegPop1865Prop
estimates store N
lrtest F N
mfp: regress MSKProp2 wPrevHICP_PRELIM days LiveInDec RegPop18FProp RegPop1865Prop
estimates store O
lrtest F O
mfp: regress MSKProp2 QOFObesityPrev2021_2022 days LiveInDec RegPop18FProp RegPop1865Prop
estimates store P
lrtest F P
mfp: regress MSKProp2 OpioidItem1000 days LiveInDec RegPop18FProp RegPop1865Prop
estimates store Q
lrtest F Q
mfp: regress MSKProp2 Appointmentsper1000patients days LiveInDec RegPop18FProp RegPop1865Prop
estimates store R
lrtest F R

***Sensitivity test re consultation frequency
***Explore relationship between outcomes and appointments per 1000 patients
mfp: regress MSKProp1 Appointmentsper1000patients days LiveInDec RegPop18FProp RegPop1865Prop
fracplot, mlabel(MIDAS_GPPID)
mfp: regress MSKProp2 Appointmentsper1000patients days LiveInDec RegPop18FProp RegPop1865Prop
fracplot, mlabel(MIDAS_GPPID)

***Perform additional adjustment for appointments per 1000 patients
mfp: regress MSKProp1 wPrevMSK_GPPS2022 days LiveInDec RegPop18FProp RegPop1865Prop Appointmentsper1000patients
fracplot, mlabel(MIDAS_GPPID)
mfp: regress MSKProp1 wPrevChronicPain_PRELIM days LiveInDec RegPop18FProp RegPop1865Prop Appointmentsper1000patients
fracplot, mlabel(MIDAS_GPPID)
mfp: regress MSKProp1 wPrevHICP_PRELIM days LiveInDec RegPop18FProp RegPop1865Prop Appointmentsper1000patients
fracplot, mlabel(MIDAS_GPPID)

mfp: regress MSKProp2 wPrevMSK_GPPS2022 days LiveInDec RegPop18FProp RegPop1865Prop Appointmentsper1000patients
fracplot, mlabel(MIDAS_GPPID)
mfp: regress MSKProp2 wPrevChronicPain_PRELIM days LiveInDec RegPop18FProp RegPop1865Prop Appointmentsper1000patients
fracplot, mlabel(MIDAS_GPPID)
mfp: regress MSKProp2 wPrevHICP_PRELIM days LiveInDec RegPop18FProp RegPop1865Prop Appointmentsper1000patients
fracplot, mlabel(MIDAS_GPPID)

***Fracplots for GPQ covariates
mfp: regress MSKProp1 Availableservtot days LiveInDec RegPop18FProp RegPop1865Prop
fracplot, mlabel(MIDAS_GPPID)
mfp: regress MSKProp1 CDSStot days LiveInDec RegPop18FProp RegPop1865Prop
fracplot, mlabel(MIDAS_GPPID)
mfp: regress MSKProp2 Availableservtot days LiveInDec RegPop18FProp RegPop1865Prop
fracplot, mlabel(MIDAS_GPPID)
mfp: regress MSKProp2 CDSStot days LiveInDec RegPop18FProp RegPop1865Prop
fracplot, mlabel(MIDAS_GPPID)

***Final LRtests for GPQ covariates
***drop observations with no GPQ data
drop if Response==0
mfp: regress MSKProp1 days LiveInDec RegPop18FProp RegPop1865Prop
estimates store F
mfp: regress MSKProp1 Availableservtot days LiveInDec RegPop18FProp RegPop1865Prop
estimates store R
lrtest F R
mfp: regress MSKProp1 CDSStot days LiveInDec RegPop18FProp RegPop1865Prop
estimates store S
lrtest F S
mfp: regress MSKProp2 days LiveInDec RegPop18FProp RegPop1865Prop
estimates store F
mfp: regress MSKProp2 Availableservtot days LiveInDec RegPop18FProp RegPop1865Prop
estimates store R
lrtest F R
mfp: regress MSKProp2 CDSStot days LiveInDec RegPop18FProp RegPop1865Prop
estimates store S
lrtest F S



