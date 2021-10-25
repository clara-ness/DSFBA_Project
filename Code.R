##Script for the project "European countries, their dietary habits and diabetes prevalence"
#Hellooooo
install.packages(c('tibble', 'dplyr', 'readr', 'readxl'))
# or install.packages('tidyverse')
 
library(readr)
library(dplyr)
library(readxl)

daily_caloric <- read_csv("daily-caloric.csv")

newdata <- subset(daily_caloric, Year >= 2000)




daily_caloric_eu <- subset(newdata, Europe==('Austria', 'Belgium', 'Bulgaria', 'Croatia', 'Cyprus', 'Czechia', 'Denmark', 'Estonia', 'Finland', 'France', 'Germany', 'Greece', 'Hungary', 'Ireland', 'Italy', 'Latvia', 'Lithuania', 'Luxembourg', 'Malta', 'Netherlands', 'Poland', 'Portugal', 'Romania', 'Slovakia', 'Slovenia', 'Spain', 'Sweden', 'United Kingdom', 'Switzerland'))


#add flags (failed for now ^^)
install.packages("countrycode")
library(remotes)
install_github('vincentarelbundock/countrycode')
library(countrycode)
library(gt)
Countries <- c('Austria', 'Belgium', 'Bulgaria', 'Croatia', 'Cyprus', 'Czechia', 'Denmark', 'Estonia', 'Finland', 'France', 'Germany', 'Greece', 'Hungary', 'Ireland', 'Italy', 'Latvia', 'Lithuania', 'Luxembourg', 'Malta', 'Netherlands', 'Poland', 'Portugal', 'Romania', 'Slovakia', 'Slovenia', 'Spain', 'Sweden', 'United Kingdom', 'Switzerland')
Flags <- countrycode(Countries, 'country.name', 'unicode.symbol')
dat <- newdata(Countries, Flags)
gt(dat)

EU <-c("Austria", "Belgium", "Bulgaria", "Croatia", "Cyprus", "Czechia", "Denmark", "Estonia", "Finland", "France", "Germany", "Greece", "Hungary", "Ireland", "Italy", "Latvia", "Lithuania", "Luxembourg", "Malta", "Netherlands", "Poland", "Portugal", "Romania", "Slovakia", "Slovenia", "Spain", "Sweden", "United Kingdom", "Switzerland")



daily_caloric_eu <- select(filter (Europe == TRUE))


daily_caloric_eu <- select(filter(education, Region == 2),c(Entit,Minor.Population:Education.Expenditures))
EU <-c("Austria", "Belgium", "Bulgaria", "Croatia", "Cyprus", "Czechia", "Denmark", "Estonia", "Finland", "France", "Germany", "Greece", "Hungary", "Ireland", "Italy", "Latvia", "Lithuania", "Luxembourg", "Malta", "Netherlands", "Poland", "Portugal", "Romania", "Slovakia", "Slovenia", "Spain", "Sweden", "United Kingdom", "Switzerland")

daily_caloric_eu <- daily_caloric[EU]

  

GDP <- read_excel("GDP (1960-2020).xls")

Diabetes <- read_csv("Diabetes.csv")


# Keep only country rows and replace country names as needed
ctry_UNSD<-ctry_UNSD %>% 
  filter(ISOalpha3!="") %>% 
  select(country, UNSDsubregion) %>% 
  mutate(
    country = ifelse(country == "Bolivia (Plurinational State of)", "Bolivia", country) ,
    country = ifelse(country == "Cabo Verde", "Cape Verde", country) , 
    country = ifelse(country == "Democratic Republic of the Congo", "Congo Democratic Republic", country) ,
    country = ifelse(country == "Côte d'Ivoire", "Cote d'Ivoire", country) ,
    country = ifelse(country == "Kyrgyzstan", "Kyrgyz Republic", country) , 
    country = ifelse(country == "Republic of Moldova", "Moldova", country) , 
    country = ifelse(country == "United Republic of Tanzania", "Tanzania", country) ,
    country = ifelse(country == "Viet Nam", "Vietnam", country) )
    

