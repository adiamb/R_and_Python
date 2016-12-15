require(data.table)
require(plyr)
require(dplyr)
require(readr)
require(ggplot2)
inpatient = read_csv("https://data.cms.gov/api/views/97k6-zzx3/rows.csv?accessType=DOWNLOAD") #read in the file from data.gov
dim(inpatient) #should be 16K rows 
apply(inpatient, 2, FUN = function(x) (table(is.na(x)))) #check for NAs in the dataset
inpatient=inpatient[-c(4, 7)] ## remove unnecessary columns 
names(inpatient)=gsub(" ", "_", names(inpatient))  #lets us put underscore in colnames for sake simplicity
inpatient$`Average Covered Charges`=as.numeric(gsub("\\$", "", inpatient$`Average Covered Charges`))/1000 #convert to numeric and divide by 1000 
inpatient$`Average Total Payments`=as.numeric(gsub("\\$", "", inpatient$`Average Total Payments`))/1000 #convert to numeric and divide by 1000 
inpatient$`Average Medicare Payments`=as.numeric(gsub("\\$", "", inpatient$`Average Medicare Payments`))/1000 #convert to numeric and divide by 1000 
str(inpatient) #check 
summary(inpatient)
ggplot(inpatient, aes(factor(inpatient$`DRG Definition`), inpatient$`Average Total Payments`))+geom_boxplot()+theme(axis.text.x = element_text(angle = 90))+coord_flip()
ggplot(inpatient, aes(factor(inpatient$`Provider State`), inpatient$`Average Covered Charges`))+geom_boxplot()+theme(axis.text.x = element_text(angle = 90))+coord_flip()
apply(inpatient, 2, FUN = function(x) (table(is.na(x))))
