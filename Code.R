##Script for the project "European countries, their dietary habits and diabetes prevalence"

#install.packages(c('tibble', 'dplyr', 'readr', 'readxl','gt','remotes')) run this line once only at the begining 
#or this one install.packages('tidyverse')
#install.packages('Rcpp') for non-mac user ^^
#library(Rcpp)
 
library(readr)
library(dplyr)
library(readxl)
library(data.table)
library(tidyverse)

#Caloric consumption table tidying
daily_caloric <- read_csv("daily-caloric.csv")

daily_caloric <- subset(daily_caloric, Year >= 2000)

EU <- c("AUT", "BEL", "BGR", "HRV", "CYP", "CZE", "DNK", "EST", "FIN", "FRA", "DEU", "GRC", "HUN", "IRL", "ITA", "LVA", "LTU", "LUX", "MLT", "NLD", "POL", "PRT", "ROU", "SVK", "SVN", "ESP", "SWE", "GBR", "CHE")

daily_caloric<-daily_caloric[daily_caloric$Code %in% EU,] # Subset of table by looking if in each row, Entity is in the EU vector

setDT(daily_caloric)[ , Calories_from_animal_protein := mean(`Calories from animal protein (FAO (2017))`), by = "Entity"]
setDT(daily_caloric)[ , Calories_from_plant_protein := mean(`Calories from plant protein (FAO (2017))`), by = "Entity"]
setDT(daily_caloric)[ , Calories_from_carbohydrates := mean(`Calories from carbohydrates (FAO (2017))`), by = "Entity"]
#FAO = Food and Agriculture Organisation 

Caloric_consumption <- data.table(daily_caloric$Entity,daily_caloric$Code,daily_caloric$Calories_from_animal_protein, daily_caloric$Calories_from_plant_protein,daily_caloric$Calories_from_carbohydrates)
Caloric_consumption <-Caloric_consumption[!duplicated(Caloric_consumption)]
colnames(Caloric_consumption) <- c("country_name", "country_code", "Calories from animal protein", "Calories from plant protein", "Calories from carbohydrates")
Caloric_consumption<-Caloric_consumption %>%
  rowwise() %>%
  mutate(
    Total_consumption = sum(c(V3,V4,V5))
  )

#Caloric consumption plotting 
plot(Caloric_consumption)

plot(Caloric_consumption$V5, Caloric_consumption$V3, type="h")
plot(Caloric_consumption$V5, Caloric_consumption$V4)
plot(Caloric_consumption$V3, Caloric_consumption$V4)


#Caloric consumption multiple plots 
par(mfrow=c(3,3), mar=c(2,5,2,1), las=1, bty="n")
plot(Caloric_consumption$V5)
plot(Caloric_consumption$V5, Caloric_consumption$V3)
plot(Caloric_consumption$V5, type= "c")
plot(Caloric_consumption$V5, type= "s")
plot(Caloric_consumption$V5, type= "h")
barplot(Caloric_consumption$V5, main = 'Caloric Consumption',xlab = 'calories levels of animal protein',col='red',horiz = FALSE)
hist(Caloric_consumption$V5)
boxplot(Caloric_consumption$V5)
boxplot(Caloric_consumption[,0:4], main='Multiple Box plots')

#Caloric consumption ggplot

ggplot(data = Caloric_consumption, mapping = aes(x = V1, y = V5)) +
  geom_boxplot()
ggplot(data = Caloric_consumption, mapping = aes(x = V2, y = Total_consumption, color = as.factor(V1))) + geom_point()


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
EU <- c('AUT', 'BEL', 'BGR', 'HRV', 'CYP', 'CZE', 'DNK', 'EST', 'FIN', 'FRA', 'DEU', 'GRC', 'HUN', 'IRL', 'ITA', 'LVA', 'LTU', 'LUX', 'MLT', 'NLD', 'POL', 'PRT', 'ROU', 'SVK', 'SVN', 'ESP', 'SWE', 'GBR', 'CHE')
Flags <- countrycode(EU, 'country.name', 'unicode.symbol')
dat <- newdata(EU, Flags)
gt(dat)

  
#GDP table tidying
GDP <- read_excel("GDP (1960-2020).xls")
colnames(GDP) <- GDP[3,]
GDP <- GDP[-c(1:3),-c(3:44,59:65)] #or maybe use the filter and select functions
GDP <- GDP[GDP$"Country Code" %in% EU,]
GDP <- GDP %>% pivot_longer(c('2000','2001','2002','2003','2004','2005','2006','2007','2008','2009','2010','2011','2012','2013'),names_to = "Year",values_to = "Gross Domestic Product")
colnames(GDP) <- c("country_name","country_code","year","avg_gdp")
GDP$avg_gdp <- as.numeric(GDP$avg_gdp)
GDP <- GDP %>% 
  group_by(country_name, country_code) %>% 
  summarize(avg_gdp = mean(avg_gdp))

#Diabetes table tidying
Diabetes <- read_csv("Diabetes.csv")

Diabetes2 <- subset(Diabetes, Year >= 2000 , Year <=2013)

Diabetes_EU<-Diabetes2[Diabetes2$`ISO` %in% EU,]
Diabetes_EU <- Diabetes_EU[-c(6,7)] #drop interval

Diabetes_EU_men <-subset(Diabetes_EU, Sex=="Men")
Diabetes_EU_women <-subset(Diabetes_EU, Sex=="Women")
colnames(Diabetes_EU_men)<-c("country_name","country_code","sex","year","prop_men_diabetes")
colnames(Diabetes_EU_women)<-c("country_name","country_code","sex","year","prop_women_diabetes")
Diabetes_EU_men$prop_men_diabetes <- as.numeric(Diabetes_EU_men$prop_men_diabetes)
#Mean of 2000-2013
Diabetes_EU_men <- Diabetes_EU_men %>% 
  group_by(country_name) %>%
  summarize(prop_men_diabetes = mean(prop_men_diabetes))

Diabetes_EU_women <- Diabetes_EU_women %>% 
  group_by(country_name) %>%
  summarize(prop_women_diabetes = mean(prop_women_diabetes))

#Plot GDP and Diabetes
GDP_diabetes<-full_join(GDP,Diabetes_EU_men, by="country_name")
GDP_diabetes<-full_join(GDP_diabetes,Diabetes_EU_women, by="country_name")
plot(GDP_diabetes$avg_gdp, GDP_diabetes$prop_men_diabetes)
plot(GDP_diabetes$avg_gdp, GDP_diabetes$prop_women_diabetes)
# Plot with men and woman
GDP_Diabetes_reshaped <- data.frame(x = GDP_diabetes$avg_gdp,                           
                          y = c(GDP_diabetes$prop_men_diabetes,GDP_diabetes$prop_women_diabetes),
                          group = c(rep("y1", nrow(GDP_diabetes)),
                                    rep("y2", nrow(GDP_diabetes))))

ggplot(GDP_Diabetes_reshaped, aes(x, y, col = group)) +  geom_point()
#4 rows with missing values

#Plot GDP and Calories

#Joint GDP_diabetes and caloric consumption (neeed to add Counrty code to avoid NA in Diabetes rate)
GDP_diabetes<-full_join(GDP,Diabetes_EU_men, by="country_code")
GDP_diabetes<-full_join(GDP_diabetes,Diabetes_EU_women, by="country_code")

GDP_diabetes_caloric<-full_join(GDP_diabetes,Caloric_consumption, by="country_code")

df = merge(x=Caloric_consumption,y=GDP,z=Diabetes_EU ,by="Entity")
