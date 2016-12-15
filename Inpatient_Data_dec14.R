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

setDT(inpatient)
inpat_agg=inpatient[, list(Total_Discharges = mean(Total_Discharges), Average_Covered_Charges = mean(Average_Covered_Charges), Average_Total_Payments = mean(Average_Covered_Charges), Average_Medicare_Payments = mean(Average_Medicare_Payments)), by=list(DRG_Definition, Provider_State)]
ggplot(inpat_agg, aes(factor(DRG_Definition), Average_Medicare_Payments))+geom_bar(stat = "identity", color = factor())+theme(axis.text.x = element_text(angle = 90, size = 10, face = "bold"), axis.text.y = element_text(size = 10, face = "bold"))+coord_flip()
ggplot(inpat_agg, aes(factor(DRG_Definition), Average_Medicare_Payments, fill = factor(Provider_State)))+geom_bar(stat = "identity")+theme(axis.text.x = element_text(angle = 90, size = 10, face = "bold"), axis.text.y = element_text(size = 10, face = "bold"))+coord_flip()
ggplot(inpat_agg, aes(factor(Provider_State), Average_Medicare_Payments)+geom_bar(stat = "identity")+theme(axis.text.x = element_text(angle = 90, size = 10, face = "bold"), axis.text.y = element_text(size = 10, face = "bold"))+coord_flip()
       