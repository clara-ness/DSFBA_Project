##Script for the project "European countries, their dietary habits and diabetes prevalence"

##Leaflet and mapping 

install.packages("leaflet")


library(leaflet)

#test
m <- leaflet() %>%
  addTiles() %>%  # Add default OpenStreetMap map tiles
  addMarkers(lng=174.768, lat=-36.852, popup="The birthplace of R")
setView(Europe)
m  # Print the map

source(here::here("scripts/setup.R"))
source(here::here("/report/data.Rmd"))
#Map Europe
install.packages("eurostat")

library(tidyverse)
library(eurostat)
library(leaflet)
library(sf)
library(geojsonsf)

EU_coord<- geojsonsf::geojson_sf('data/CNTR_RG_60M_2020_3035.geojson')

all_data = merge(EU_coord, GDP_diabetes_cal, by.x = "ISO3_CODE", by.y = "country_code")

view(all_data)

st_write(all_data, "MapApp/geojson_manipulation/main.geojson")




get_eurostat_geospatial(resolution = 10, 
                        nuts_level = 0, 
                        year = 2016)

SHP_0 <- get_eurostat_geospatial(resolution = 10, 
                                 nuts_level = 0, 
                                 year = 2016)

leaflet(SHP_0) %>%
  setView(lng = 15, lat = 50, zoom = 4) %>% 
  addTiles() %>% 
  addPolygons(color = "black",
              weight = 1,
              fillColor = "blue",
              fillOpacity = 0.2)






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
daily_caloric <- read_csv("data/daily-caloric.csv")
daily_caloric <- subset(daily_caloric, Year >= 2000)
EU <- c("AUT", "BEL", "BGR", "HRV", "CYP", "CZE", "DNK", "EST", "FIN", "FRA", "DEU", "GRC", "HUN", "IRL", "ITA", "LVA", "LTU", "LUX", "MLT", "NLD", "POL", "PRT", "ROU", "SVK", "SVN", "ESP", "SWE", "GBR", "CHE")
daily_caloric<-daily_caloric[daily_caloric$Code %in% EU,] # Subset of table by looking if in each row, Entity is in the EU vector
setDT(daily_caloric)[ , Calories_from_animal_protein := mean(`Calories from animal protein (FAO (2017))`), by = "Entity"]
setDT(daily_caloric)[ , Calories_from_plant_protein := mean(`Calories from plant protein (FAO (2017))`), by = "Entity"]
setDT(daily_caloric)[ , Calories_from_carbohydrates := mean(`Calories from carbohydrates (FAO (2017))`), by = "Entity"]
setDT(daily_caloric)[ , Calories_from_fat := mean(`Calories from fat (FAO (2017))`), by = "Entity"]
#FAO = Food and Agriculture Organisation 
Caloric_consumption <- data.table(daily_caloric$Entity,daily_caloric$Code,daily_caloric$Calories_from_animal_protein, daily_caloric$Calories_from_plant_protein,daily_caloric$Calories_from_carbohydrates,daily_caloric$Calories_from_fat)
Caloric_consumption <-Caloric_consumption[!duplicated(Caloric_consumption)]
Caloric_consumption <- Caloric_consumption[,-1] #drop country name
colnames(Caloric_consumption) <- c("country_code", "cal_prot_animal", "cal_prot_plant", "cal_carbs","cal_fat")
Caloric_consumption <-Caloric_consumption %>%
  group_by(country_code) %>%
  mutate(
    total_consumption = sum(c(cal_prot_animal,cal_prot_plant,cal_carbs,cal_fat)))

#Caloric consumption plotting 
plot(Caloric_consumption)
plot(Caloric_consumption$country_name, Caloric_consumption$total_consumption, type="h")
plot(Caloric_consumption$country_name, Caloric_consumption$cal_prot_animal)
plot(Caloric_consumption$country_name, Caloric_consumption$cal_prot_plant)
plot(Caloric_consumption$country_name, Caloric_consumption$cal_carbs)
plot(Caloric_consumption$country_name, Caloric_consumption$cal_fat)

#Caloric consumption ggplot
ggplot(data = Caloric_consumption, mapping = aes(x = "country_name", y = "total_consumption")) +
  geom_boxplot()
ggplot(data = Caloric_consumption, mapping = aes(x =  "Calories from animal protein", y = Total_consumption, color = as.factor("country_name"))) + geom_point()


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
GDP <- read_excel("data/GDP(1960-2020).xls")
colnames(GDP) <- GDP[3,]
GDP <- GDP[-c(1:3),-c(3:44,59:65)] #to drop not useful lines and years, also maybe use the filter and select functions
GDP <- GDP[GDP$"Country Code" %in% EU,]
GDP <- GDP %>% pivot_longer(c('2000','2001','2002','2003','2004','2005','2006','2007','2008','2009','2010','2011','2012','2013'),names_to = "Year",values_to = "Gross Domestic Product")
colnames(GDP) <- c("country_name","country_code","year","avg_gdp")
GDP$avg_gdp <- as.numeric(GDP$avg_gdp)
GDP <- GDP %>% 
  group_by(country_name, country_code) %>% 
  summarize(avg_gdp = mean(avg_gdp))
GDP$avg_gdp <- GDP$avg_gdp/1000000000

#Diabetes table tidying
Diabetes <- read_csv("data/Diabetes.csv")
Diabetes2 <- subset(Diabetes, Year >= 2000 , Year <=2013)
Diabetes_EU<-Diabetes2[Diabetes2$`ISO` %in% EU,]
Diabetes_EU <- Diabetes_EU[-c(1,6,7)] #drop interval and country name
Diabetes_EU_men <-subset(Diabetes_EU, Sex=="Men")
Diabetes_EU_women <-subset(Diabetes_EU, Sex=="Women")
colnames(Diabetes_EU_men)<-c("country_code","sex","year","prop_men_diabetes")
colnames(Diabetes_EU_women)<-c("country_code","sex","year","prop_women_diabetes")
Diabetes_EU_men$prop_men_diabetes <- as.numeric(Diabetes_EU_men$prop_men_diabetes)

#Mean of 2000-2013
Diabetes_EU_men <- Diabetes_EU_men %>% 
  group_by(country_code) %>%
  summarize(prop_men_diabetes = mean(prop_men_diabetes))
Diabetes_EU_women <- Diabetes_EU_women %>% 
  group_by(country_code) %>%
  summarize(prop_women_diabetes = mean(prop_women_diabetes))

#Joining tables GDP, Diabetes and Caloric consumption
GDP_diabetes_cal <-full_join(GDP,Diabetes_EU_men, by="country_code")
GDP_diabetes_cal <-full_join(GDP_diabetes_cal,Diabetes_EU_women, by="country_code")
GDP_diabetes_cal <-full_join(GDP_diabetes_cal ,Caloric_consumption, by="country_code")

# Plot GDP and Diabetes (men and woman)
plot(GDP_diabetes_cal$avg_gdp, GDP_diabetes_cal$prop_men_diabetes)
plot(GDP_diabetes_cal$avg_gdp, GDP_diabetes_cal$prop_women_diabetes)

