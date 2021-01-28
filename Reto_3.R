library(rvest)

theurl <- "https://www.glassdoor.com.mx/Sueldos/data-scientist-sueldo-SRCH_KO0,14.htm"
file <- read_html(theurl)    # Leemos el html
# Selecciona pedazos dentro del HTML para identificar la tabla

tables <- html_nodes(file, "table")

table1 <- html_table(tables[1], fill = TRUE)

table <- na.omit(as.data.frame(table1))   # Quitamos NA´s que meten filas extras 
# y convertimos la lista en un data frame para su manipulación con R

str(table)
tail(table)

table$Sueldo<-gsub("[MXN$]","",table$Sueldo)
table$Sueldo<-gsub("[/mes]","",table$Sueldo)
table$Sueldo<-gsub(",",".",table$Sueldo)

table$Sueldo

table$Sueldo<-as.numeric(as.character(table$Sueldo))

table$Cargo[which.max(table$Sueldo)]
max(table$Sueldo)
table$Cargo[which.min(table$Sueldo)]
min(table$Sueldo)
