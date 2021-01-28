library(DBI)
library(RMySQL)
library(dplyr)
library(ggplot2)

MyDataBase <- dbConnect(
  drv = RMySQL::MySQL(),
  dbname = "shinydemo",
  host = "shiny-demo.csa7qlmguqrf.us-east-1.rds.amazonaws.com",
  username = "guest",
  password = "guest")

dbListTables(MyDataBase)

dbListFields(MyDataBase, 'Country')

DataDB <- dbGetQuery(MyDataBase, "select * from CountryLanguage")

pop50.mex <-  DataDB %>% filter(Language == "Spanish")   # Ciudades del país de México con más de 50,000 habitantes

head(pop50.mex)

unique(DataDB$CountryCode)   # Países que contiene la BDD

ggplot(pop50.mex, aes(x=CountryCode, y=Percentage, fill=IsOfficial)) + geom_bin2d() + coord_flip()
