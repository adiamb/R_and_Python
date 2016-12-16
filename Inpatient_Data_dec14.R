require(data.table)
require(plyr)
require(dplyr)
require(readr)
require(ggplot2)
inpatient = read_csv("https://data.cms.gov/api/views/97k6-zzx3/rows.csv?accessType=DOWNLOAD") #read in the file from data.gov
dim(inpatient) #should be 16K rows 
apply(inpatient, 2, FUN = function(x) (sum(is.na(x)))) #check for NAs in the dataset
inpatient=inpatient[-c(4, 7)] ## remove unnecessary columns 
names(inpatient)=gsub(" ", "_", names(inpatient))  #lets us put underscore in colnames for sake simplicity
inpatient$Average_Covered_Charges=as.numeric(gsub("\\$", "", inpatient$Average_Covered_Charges)) #convert to numeric 
inpatient$Average_Total_Payments=as.numeric(gsub("\\$", "", inpatient$Average_Total_Payments)) #convert to numeric 
inpatient$Average_Medicare_Payments=as.numeric(gsub("\\$", "", inpatient$Average_Medicare_Payments)) #convert to numeric
###convert some of the characters into factors
inpatient$DRG_Definition = as.factor(inpatient$DRG_Definition)
inpatient$Provider_State = as.factor(inpatient$Provider_State)
inpatient$Hospital_Referral_Region_Description = as.factor(inpatient$Hospital_Referral_Region_Description)
str(inpatient) #check 
summary(inpatient) #check the distribution of numerical values
require(ggplot2)
ggplot(inpatient, aes(factor(DRG_Definition), Average_Medicare_Payments))+geom_boxplot(color = "blue")+theme(axis.text.x = element_text(angle = 90))+coord_flip()
ggplot(inpatient, aes(factor(Provider_State), Average_Medicare_Payments))+geom_boxplot()+theme(axis.text.x = element_text(angle = 90))+coord_flip()

setDT(inpatient) ## change to data table, makes it easy to aggregate
inpat_agg=inpatient[, list(Total_Discharges = mean(Total_Discharges), Average_Covered_Charges = mean(Average_Covered_Charges), Average_Total_Payments = mean(Average_Covered_Charges), Average_Medicare_Payments = mean(Average_Medicare_Payments)), by=list(DRG_Definition, Provider_State)]
ggplot(inpat_agg, aes(factor(DRG_Definition), Average_Medicare_Payments))+geom_bar(stat = "identity", color = factor())+theme(axis.text.x = element_text(angle = 90, size = 10, face = "bold"), axis.text.y = element_text(size = 10, face = "bold"))+coord_flip()
ggplot(inpat_agg, aes(factor(DRG_Definition), Average_Medicare_Payments, fill = factor(Provider_State)))+geom_bar(stat = "identity")+theme(axis.text.x = element_text(angle = 90, size = 10, face = "bold"), axis.text.y = element_text(size = 10, face = "bold"))+coord_flip()
ggplot(inpat_agg, aes(factor(Provider_State), Average_Medicare_Payments))+geom_bar(stat = "identity")+theme(axis.text.x = element_text(angle = 90, size = 10, face = "bold"), axis.text.y = element_text(size = 10, face = "bold"))+coord_flip()
ggplot(inpat_agg, aes(factor(Provider_State), factor(DRG_Definition)))+geom_raster(aes(fill = Average_Medicare_Payments))+scale_fill_gradient(high = "red", low = "white")+theme(axis.text.x = element_text(angle = 90, size = 10, face = "bold"), axis.text.y = element_text(size = 8, face = "bold"))

###in california lets us look at to which condition most medicare payments were done !
ggplot(filter(inpat_agg, Provider_State == "CA"), aes(factor(DRG_Definition), Average_Medicare_Payments))+geom_bar(stat = "identity")+theme(axis.text.x = element_text(angle = 90, size = 10, face = "bold"), axis.text.y = element_text(size = 8, face = "bold"))+coord_flip()

###build a glm model to predict prices in the large dataset given the condition and the referral region
model1=glm(Average_Medicare_Payments ~ DRG_Definition+Hospital_Referral_Region_Description, data = inpatient)
test=inpatient[15000:15010, 1:ncol(inpatient), with = F] ##select a test row from the main dataset
#test$Average_Medicare_Payments = 0 ##assign zero to the output variable
predict(model1, test)
cbind(test$Average_Medicare_Payments, predict(model1, test))

