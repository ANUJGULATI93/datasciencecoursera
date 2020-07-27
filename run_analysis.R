x_train<-read.table("C:/Users/Anuj Gulati/Documents/specdata/New folder/UCI HAR Dataset/train/X_train.txt") 
y_train<-read.table("C:/Users/Anuj Gulati/Documents/specdata/New folder/UCI HAR Dataset/train/Y_train.txt") 
sub_train<-read.table("C:/Users/Anuj Gulati/Documents/specdata/New folder/UCI HAR Dataset/train/subject_train.txt") 
x_test<-read.table("C:/Users/Anuj Gulati/Documents/specdata/New folder/UCI HAR Dataset/test/X_test.txt") 
y_test<-read.table("C:/Users/Anuj Gulati/Documents/specdata/New folder/UCI HAR Dataset/test/Y_test.txt") 
sub_test<-read.table("C:/Users/Anuj Gulati/Documents/specdata/New folder/UCI HAR Dataset/test/subject_test.txt") 
feature<-read.table("C:/Users/Anuj Gulati/Documents/specdata/New folder/UCI HAR Dataset/features.txt")
act_label<-read.table("C:/Users/Anuj Gulati/Documents/specdata/New folder/UCI HAR Dataset/activity_labels.txt")
colnames(x_train)<-feature[,2]
colnames(y_train)<-"activityID"
colnames(sub_train)<-"subjectID"
colnames(x_test)<-feature[,2]
colnames(y_test)<-"activityID"
colnames(sub_test)<-"subjectID"
colnames(act_label)<-c("activityID","activity_Name")
train<-cbind(x_train,y_train,sub_train)
test<-cbind(x_test,y_test,sub_test)
dataset<-rbind(train,test)
col_name<-colnames(dataset)
z<-(grepl("mean...",col_name)|grepl("std...",col_name)|grepl("activityID",col_name)|grepl("subjectID",col_name))
mean_std_set<-dataset[,z==TRUE]
finaldataset<-merge(mean_std_set,act_label,by="activityID",all.x = TRUE)
finaldata<-finaldataset[-64]
tidyset<-aggregate(.~subjectID + activityID,data = finaldata,mean)
tidyset <- tidyset[order(tidyset$subjectID, tidyset$activityID), ]
write.table(tidyset,"tidyset.txt",row.names = FALSE)
