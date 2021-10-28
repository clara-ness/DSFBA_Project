##Script for the project "European countries, their dietary habits and diabetes prevalence"

#install.packages(c('tibble', 'dplyr', 'readr', 'readxl','gt','remotes')) run this line once only at the begining 
#or this one install.packages('tidyverse')
 
library(readr)
library(dplyr)
library(readxl)
library(data.table)
library(tidyverse)

daily_caloric <- read_csv("daily-caloric.csv")

daily_caloric <- subset(daily_caloric, Year >= 2000)

EU <-c("Austria", "Belgium", "Bulgaria", "Croatia", "Cyprus", "Czechia", "Denmark", "Estonia", "Finland", "France", "Germany", "Greece", "Hungary", "Ireland", "Italy", "Latvia", "Lithuania", "Luxembourg", "Malta", "Netherlands", "Poland", "Portugal", "Romania", "Slovakia", "Slovenia", "Spain", "Sweden", "United Kingdom", "Switzerland")

daily_caloric<-daily_caloric[daily_caloric$Entity %in% EU,] # Subset of table by looking if in each row, Entity is in the EU vector

setDT(daily_caloric)[ , Calories_from_animal_protein := mean(`Calories from animal protein (FAO (2017))`), by = "Entity"]
setDT(daily_caloric)[ , Calories_from_plant_protein := mean(`Calories from plant protein (FAO (2017))`), by = "Entity"]
setDT(daily_caloric)[ , Calories_from_carbohydrates := mean(`Calories from carbohydrates (FAO (2017))`), by = "Entity"]
#FAO = Food and Agriculture Organisation 

Caloric_consumption <- data.table(daily_caloric$Entity,daily_caloric$Calories_from_animal_protein, daily_caloric$Calories_from_plant_protein,daily_caloric$Calories_from_carbohydrates)
Caloric_consumption <-Caloric_consumption[!duplicated(Caloric_consumption)]
#colnames(Caloric_consumption) <- c("Entity", "Calories from animal protein", "Calories from plant protein", "Calories from carbohydrates")

#plotting data 
plot(Caloric_consumption)

ggplot(data = Caloric_consumption)+
  geom_point(aes(x = V1, y= V2))

ggplot(data = Caloric_consumption, mapping = aes(x = V1, y = V2)) +
  geom_boxplot()


#try to put those 3 means in a table
daily_caloric %>% 
  group_by(Code) %>%
  summarise(mean = mean(`Calories from animal protein (FAO (2017))`)
daily_caloric %>%
  group_by(Code) %>%
  summarise(mean = mean(`Calories from plant protein (FAO (2017))`)
daily_caloric %>%
  group_by(Code) %>%
  summarise(mean = mean(`Calories from carbohydrates (FAO (2017))`)

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

  

GDP <- read_excel("GDP (1960-2020).xls")
GDP <- GDP[-c(1,2),-c(3:44)]

Diabetes <- read_csv("Diabetes.csv")

Diabetes2 <- subset(Diabetes, Year >= 2000)

Diabetes_EU<-Diabetes2[Diabetes2$`Country/Region/World` %in% EU,]


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
    

