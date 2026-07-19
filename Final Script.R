#_____________________Cleaning Data_____________________

#Recode negative numbers into NA
#These are the columns where we have to replace the negatives values with NA (gender is included on this group)
cols <- c(1:26)

for(i in cols){
  w <- which(dat[,i]<0) #We look for the rows where the values are are below 0
  if(length(w)>0){dat[w,i] <- NA} #w = is the row number
} #End of the for-loop

#We verify if negative values have changed to NA
View(dat)

#---------Labeling of the categories---------
#When it comes to sex, we change 1 to "male" and 2 to "female"
dat$sex <- as.factor(dat$sex)
levels(dat$sex) <- c('male','female')

#We verify if the values have been changed
View(dat)


#_____________________Renaming Variables_____________________
#We will rename the variables to make it easy to understand
#We download the library
library(dplyr)

#We rename the columns

dat <- dat %>%
  rename(
    education = isced11_20,
    marital_status = bkfamstd,
    income = labgro20,
    full_time_yrs = expft20,
    unemployment_yrs = expue20,
    part_time_yrs = exppt20,
    labor_status = lfs20,
    current_occupation = siops08_20,
    household_num = cid,
    year_birth = bkpbirthy,
    offensive = bkp_06_05,
    annoyed = bkp_02_01,
    anxious = bkp_02_02,
    happy = bkp_02_03,
    sad = bkp_02_04,
    risk_tolerance = bkp_04,
    injustice = bkp_06_08,
    num_friends = bkp_07_01,
    health = bkp_123,
    politics = bkp_169,
    social_cohe = bkp_168_09,
    technology_concern = bkp_168_12,
    migration = migback,
    num_births = sumkids
      )

#We verify if the values have been changed
View(dat)

#_____________________Calculating Age_____________________

#Calculating the age variable
#We first get the current year
current_year <- as.numeric(format(Sys.Date(), "%Y"))

#We create the age column:
dat$age <- current_year - dat$year_birth

#We verify the changes
View(dat)


#____________________Variable Preparation____________________

#<><><><> offensive <><><><>
#For this project, we have decided to treat the offensive variable the following way:
# [0: "Non-offenders" = 1,2,3], [4 is omitted] and [1: "Offenders" = 5,6,7]
#This way we could compare "Clear non-offender" from "Clear offenders".

#We prepare the variable: We make a dummy for offenders and non-offenders -> offensive_dum

#we first say that people who choose 5 or more will be set to 1 and the rest to 0 on the dummy variable.
dat$offensive_dum <- (dat$offensive >= 5)+0

#Then, we say that the people who choose 4 will be change to NA on the offensive_binary variable.
dat$offensive_dum[dat$offensive == 4] <- NA

#We verify the changes
View(dat)
table(dat$offensive, dat$offensive_dum, useNA = "always")

# Quick check to see the counts of the new variable
table(dat$offensive_dum)


#<><><><> education <><><><>
# 0 -> NA
# 1 and 2 = Low education
# 3, 4 and 5 = Reference category
# 6, 7 and 8 = High education

# Convert 0 to NA
dat$education[dat$education == 0] <- NA

# 1 and 2 = low_edu
dat$low_edu <- (dat$education <= 2)+0

# 6, 7 and 8 = high_edu
dat$high_edu <- (dat$education >= 6)+0

#We verify the changes
View(dat)
table(dat$education, dat$low_edu, useNA = "always")
table(dat$education, dat$high_edu, useNA = "always")


#<><><><> sex <><><><>
# 1 = male
# 0 = female

dat$is_male <- 0

for(i in 1:nrow(dat)){
  if(dat$sex[i] == 'male')
    dat$is_male[i] <- 1
}

#We verify if the values have been changed
View(dat)


#<><><><> marital_status <><><><>
# 1 and 7 = 1: Living together
# 2, 3, 4, 5, 6 and 8 = 0: Not living together
dat$liv_together <- (dat$marital_status == 1 | dat$marital_status == 7)+0

#We verify the changes
View(dat)
table(dat$marital_status, dat$liv_together, useNA = "always")


#<><><><> labor_status <><><><>
# 5, 9, 10, 11, 12, 13= Working (Reference group)
# 1, 3, 6, 8  = Not working
# 4 = Parental leave
# 2 = Retired

dat$not_working <- (dat$labor_status == 1 | dat$labor_status == 3 | dat$labor_status == 6 | dat$labor_status == 8)+0
dat$parental <- (dat$labor_status == 4)+0
dat$retired <- (dat$labor_status == 2)+0

#We verify if the values have been changed
View(dat)

#<><><><> annoyed <><><><>
# 1 and 2 = 0: No, was not (often) annoyed
# 3 = NA
# 4 and 5 = 1: Yes, was (often) annoyed

# We create the new variable annoyed_dum where 1,2 and 3 change to 0 and 4 and 5 to 1.
dat$annoyed_dum <- (dat$annoyed >= 4)+0

# Convert 3 to NA
dat$annoyed_dum[dat$annoyed == 3] <- NA

#We verify the changes
View(dat)
table(dat$annoyed, dat$annoyed_dum, useNA = "always")
table(dat$annoyed_dum)


#<><><><> anxious <><><><>
# 1 and 2 = 0: No, was not (often) anxious
# 3 = NA
# 4 and 5 = 1: Yes, was (often) anxious

# We create the new variable anxious_dum where 1,2 and 3 change to 0 and 4 and 5 to 1.
dat$anxious_dum <- (dat$anxious >= 4)+0

# Convert 3 to NA
dat$anxious_dum[dat$anxious == 3] <- NA

#We verify the changes
View(dat)
table(dat$anxious, dat$anxious_dum, useNA = "always")
table(dat$anxious_dum)


#<><><><> happy <><><><>
# 1 and 2 = 0: No, was not (often) happy
# 3 = NA
# 4 and 5 = 1: Yes, was (often) happy

# We create the new variable happy_dum where 1,2 and 3 change to 0 and 4 and 5 to 1.
dat$happy_dum <- (dat$happy >= 4)+0

# Convert 3 to NA
dat$happy_dum[dat$happy == 3] <- NA

#We verify the changes
View(dat)
table(dat$happy, dat$happy_dum, useNA = "always")
table(dat$happy_dum)


#<><><><> sad <><><><>
# 1 and 2 = 0: No, was not (often) sad
# 3 = NA
# 4 and 5 = 1: Yes, was (often) sad

# We create the new variable sad_dum where 1,2 and 3 change to 0 and 4 and 5 to 1.
dat$sad_dum <- (dat$sad >= 4)+0

# Convert 3 to NA
dat$sad_dum[dat$sad == 3] <- NA

#We verify the changes
View(dat)
table(dat$sad, dat$sad_dum, useNA = "always")
table(dat$sad_dum)


#<><><><> risk_tolerance <><><><>
# 0, 1, 2, 3, 4 = 0: Non-risk takers
# 5 = NA
# 6, 7, 8, 9, 10 = 1: Risk takers

# We create the new variable risk_tolerance_dum.
dat$risk_tolerance_dum <- (dat$risk_tolerance >= 6)+0

# Convert 3 to NA
dat$risk_tolerance_dum[dat$risk_tolerance == 5] <- NA

#We verify the changes
View(dat)
table(dat$risk_tolerance, dat$risk_tolerance_dum, useNA = "always")
table(dat$risk_tolerance_dum)


#<><><><> injustice <><><><>
# 1, 2, 3 = 0: Non-long reflection
# 4 = NA
# 5, 6, 7 = 1 : Long reflection

# We create the new variable injustice_dum.
dat$injustice_dum <- (dat$injustice >= 5)+0

# Convert 3 to NA
dat$injustice_dum[dat$injustice == 4] <- NA

#We verify the changes
View(dat)
table(dat$injustice, dat$injustice_dum, useNA = "always")
table(dat$injustice_dum)


#<><><><> num_friends <><><><>
# 1: At least one close friend
# 0: No close friends

# We create the new variable num_friends_dum.
dat$num_friends_dum <- (dat$num_friends >= 1)+0

#We verify the changes
table(dat$num_friends, dat$num_friends_dum, useNA = "always")
table(dat$num_friends_dum)

#<><><><> health <><><><>
# 1 and 2 = 1: Good health
# 3 = NA
# 4 and 5 = 0: Not good health

# We create the new variable health_dum where 1 and 2 change to 1 and 4 and 5 to 0.
dat$health_dum <- (dat$health <= 2)+0

# Convert 3 to NA
dat$health_dum[dat$health == 3] <- NA

#We verify the changes
View(dat)
table(dat$health, dat$health_dum, useNA = "always")
table(dat$health_dum)

#<><><><> politics <><><><>
# 1 and 2 = 1: Interest in politics
# 3 and 4 = 0: Not interested in politics

# We create the new variable politics_dum where 1 and 2 change to 1 and 3 and 4 to 0.
dat$politics_dum <- (dat$politics <= 2)+0

#We verify the changes
View(dat)
table(dat$politics, dat$politics_dum, useNA = "always")
table(dat$politics_dum)

#<><><><> social_cohe <><><><>
# 1 = Major concerns (Dummy)
# 2 = Some concerns	(Reference category)
# 3 = No concerns	(Dummy)

#We create the two dummies: major_concerns and no_concerns
dat$major_concerns <- (dat$social_cohe == 1)+0
dat$no_concerns <- (dat$social_cohe == 3)+0

#We verify the changes
View(dat)
table(dat$social_cohe, dat$major_concerns, useNA = "always")
table(dat$social_cohe, dat$no_concerns, useNA = "always")
table(dat$social_cohe)


#<><><><> migration <><><><>
# 1 = No migration background (Reference category)
# 2 = Direct migration	(Dummy)
# 3 = Indirect migration	(Dummy)

#We create the two dummies: direct_migra and indirect_migra
dat$direct_migra <- (dat$migration == 2)+0
dat$indirect_migra <- (dat$migration == 3)+0

#We verify the changes
View(dat)
table(dat$migration, dat$direct_migra, useNA = "always")
table(dat$migration, dat$indirect_migra, useNA = "always")
table(dat$migration)


#<><><><> num_births <><><><>
# 1: At least one child
# 0: No child

# We create the new variable num_births_dum.
dat$num_births_dum <- (dat$num_births >= 1)+0

#We verify the changes
table(dat$num_births, dat$num_births_dum, useNA = "always")
table(dat$num_births_dum)


#We save the data as a data set in R and Excel file just in case:
save(dat,file='Dummies_Data_Dic.RData')
install.packages("writexl")
library(writexl)
write_xlsx(dat, "Dummies_Data_Dic.xlsx")


#_____________________Logistic Regression____________________

#---------------Model 1---------------

# We build our first basic model using age & sex
mod1 <- glm(offensive_dum~is_male + age,
            data = dat,
            family = binomial)

#We compare our model with a model with no variable:
library(lmtest)
lrtest(mod1)

# Interpretation:
#     Model 1: Model including sex & age.
#     Model 2: Model explained by no variable
#     Our P value is very small so we our model including sex & age is significantly better than the model including no variables.


#To see the results, we use summary:
summary(mod1)

#We check coefficients (e^b) (Odd Ratios)
round((exp(coef(mod1))-1)*100,1)

#Interpretation:
#    Since our model was significantly better than the null model, we will interpret the coefficients.
#    The chance of being a clear offender (scoring 5,6,or 7 on the scale) if you are a man increase by 50%
#    When it comes to age, every year the person is getting older, the change of being a clear offender decreases by -0.7%

#---------------Model 2---------------

mod2 <- glm(offensive_dum~is_male + age + low_edu + high_edu,
            data = dat,
            family = binomial)

#We compare our model with a model with no variable:
#Because of all the NA's in the data, we get an error, so we have to ensure both the "null model" and "mod2" use the exact same rows so we can compare them with each other.

##########  DOUBLE CHECK WITH PROFESSOR AFTER HOLIDAY:  ##########

#We select only the variables that we use in our mod2
var_mod2 <- c("offensive_dum", "is_male", "age", "low_edu", "high_edu")

# We create a data set that eliminates any row with NA for these variables
dat_mod2 <- na.omit(dat[, var_mod2])

# We create our null model that we will use for the comparison:
mod2_null <- glm(offensive_dum ~ 1, 
                      data = dat_mod2, 
                      family = binomial)

mod2_final <- glm(offensive_dum~is_male + age + low_edu + high_edu,
            data = dat_mod2,
            family = binomial)

#We perform the lmtest:
library(lmtest)
lrtest(mod2, mod2_null)

# Interpretation:
#     Model 1: Model including sex, age & education
#     Model 2: Model explained by no variable
#     Our P value is very small so we our model including sex, age & education is significantly better than the model including no variables.


#To see the results, we use summary:
summary(mod2) 

#We check coefficients (e^b) (Odd Ratios)
round((exp(coef(mod2))-1)*100,1)


#Interpretation:
#    According to mod2, only the variables sex, age and high education are significant in our model, so we will only interpret those variables.
#    The chance of being a clear offender (scoring 5,6,or 7 on the scale) if you are a man increases by 51.7%
#    When it comes to age, every year the person is getting older, the change of being a clear offender decreases by -0.6%
#    Low education like we said was insignificant (p value > 5%)
#    The chance of being a clear offender (scoring 5,6,or 7 on the scale) if you have high education decreases by 33.4% compared to the medium.
#    So far, the model suggest that young males with medium education are most likely to score higher in the OB scale.


#---------------Model 3---------------
mod3 <- glm(offensive_dum~is_male + age
            + low_edu + high_edu
            + liv_together
            + not_working + parental + retired
            + annoyed_dum + anxious_dum + happy_dum + sad_dum
            + risk_tolerance_dum
            + injustice_dum
            + num_friends_dum
            + health_dum
            + politics_dum
            + major_concerns + no_concerns
            + direct_migra + indirect_migra
            + num_births_dum,
            data = dat,
            family = binomial)

#We compare our model with a model with no variable:
#Because of all the NA's in the data, we get an error, so we have to ensure both the "null model" and "mod3" use the exact same rows so we can compare them with each other.


#We select only the variables that we use in our mod3
var_mod3 <- c("offensive_dum", "is_male", "age",
              "low_edu", "high_edu",
              "liv_together",
              "not_working" , "parental" , "retired",
              "annoyed_dum", "anxious_dum",  "happy_dum", "sad_dum",
              "risk_tolerance_dum",
              "injustice_dum",
              "num_friends_dum",
              "health_dum",
              "politics_dum",
              "major_concerns", "no_concerns",
              "direct_migra", "indirect_migra",
              "num_births_dum")

# We create a data set that eliminates any row with NA for these variables
dat_mod3 <- na.omit(dat[, var_mod3])

# We create our null model that we will use for the comparison:
mod3_null <- glm(offensive_dum ~ 1, 
                data = dat_mod3, 
                family = binomial)


#We perform the lmtest:
library(lmtest)
lrtest(mod3,mod3_null)


#To see the results, we use summary:
summary(mod3)

#We check coefficients (e^b) (Odd Ratios)
round((exp(coef(mod3))-1)*100,1)


