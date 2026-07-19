# R project - Offensive Behavior in Cases of Insults – Who Thinks So in Germany and Why?

**Course:** Data Analytics with R, WS 2025/26 
**Note:** This was a group project completed with 3 other teammates. The code in this repository is only my part of the analysis. I'm not uploading the full write-up or the whole group's work, only the R code and dataset needed to reproduce the results described below.

## About the Project
This project looks at who is more likely to react offensively when insulted, and what factors explain that behavior. We used *fictional* data that resembles data from the German Socio-Economic Panel (SOEP), a large, long-running survey of households in Germany that collects information on income, education, labor market status, and personal attitudes.

The data set includes variables such as:
- **Socio-demographics**: age, gender, education, migration background.
- **Household info**: number of children.
- **Labor market status**: full-time/part-time experience, unemployment experience, employment status.
- **Attitudes and emotions**: feelings of annoyance, anxiety, happiness, sadness, risk tolerance, reflecting on injustice, interest in politics, concern about social cohesion, number of close friends, health status.

The core question came from the survey item: *"If somebody offends me, I will offend him/her back."* Respondents who scored high on this scale were classified as "offenders."

## What we did

1.  **Data cleaning**
•	Removed negative values (like "no answer" or "does not apply") and set them as NA.
•	Renamed all variables from SOEP's technical codes into readable names (e.g., bkp_06_05 → offensive).
•	Dropped variables that weren't useful or reliable enough (e.g., occupation code, household ID).

2.  **Dummy Variable**

Most variables in the survey were on ordinal or nominal scales, so we converted them into binary (0/1) dummy variables to use in the logistic regression. For example:
- **Offensive behavior: grouped into "offender" vs. "not offender," excluding people who answered right in the middle of the scale.
- **Education:** grouped into low, medium (reference), and high education.
- **Marital status:** living together vs. not living together.
- **Labor status:** working (reference), not working, on parental leave, retired.
- **Emotions (annoyed, anxious, happy, sad):** grouped into "feels this way" vs. "does not."
- **Migration background:** no migration background (reference), direct, and indirect migration background.
- Similar binary groupings were made for injustice reflection, number of friends, health, political interest, and concern about social cohesion.

2.  **Statistical approach**
We used logistic regression, since our dependent variable (offensive behavior) is binary. Logistic regression estimates the probability of an outcome (rather than a straight numeric value like linear regression) and uses Maximum Likelihood estimation instead of Ordinary Least Squares. We compared models using the Likelihood-Ratio (LR) test to check whether adding variables improved the model significantly over a null model.
We started with two simple test models (sex + age, then adding education) before building the final model with all relevant variables.

3.  **Result (Final model)**
Several variables turned out **not** to be statistically significant: living together, labor status (not working, parental leave, retired), sadness, anxiety, risk tolerance, health status, concern about social cohesion, migration background, and number of children.
The variables that **were** significant:

| Variable | Effect on odds of being an "offender" |
|---|---|
| Being male | +116% |
| Low education | +25% |
| High education | −33% |
| Feeling annoyed often | +47% |
| Feeling happy often | −26% |
| Long reflection on injustice | +105% |
| Having at least one close friend | −24% |
| Interest in politics | +33% |
| Years in full-time employment | −1.2% per year |
| Years of unemployment | +2.3% per year |
| Years in part-time employment | −1.4% per year |

## Key Findings & Insights
•	Men are more than twice as likely as women to react offensively.
•	Education matters a lot: low education raises the odds, high education lowers them.
•	Negative emotions (annoyance, dwelling on injustice) raise the odds; positive emotions (happiness) and social ties (close friends) lower them.
•	Steady employment history lowers the odds; long periods of unemployment raise them.
•	The "worst-case" profile is a low-educated, long-term unemployed man who is frequently annoyed and dwells on injustice. The "best-case" profile is a highly educated, employed woman with positive emotional well-being.

## About Me

Hi there! I’m **Valeria Yagui**, from Lima, Peru.  
I'm currently pursuing a **Master’s degree in Digital Business Management** at **Hochschule Pforzheim** in Germany.  
I enjoy working with data and learning new tools and technologies.  

Feel free to connect with me on LinkedIn:  
[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/valeria-yagui-nishii/)
