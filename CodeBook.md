---
title: "getting and cleaning data"
---
finaldataset:the final tidy data set,txt file

A:Column bind Dataframes y_test and subject_test and add column names Activity and Subject to it.

B:Column bind Dataframes y_train and subject_train and add column names Activity and Subject to it

C:Merge A and B

D:Merge X_train and X_test data.And uses descriptive activity names to name the activities in the data set.

E:Extracts only the measurements on the mean and standard deviation for each measurement. 

F:Column bind C and E

G: a data set with the average of each variable for each activity and each subject.

H:The final tidy data set.


```{r}
y_train<-read.table("./train/y_train.txt")
x_train<-read.table("./train/X_train.txt")
y_test<-read.table("./test/y_test.txt")
x_test<-read.table("./test/X_test.txt")
subject_test<-read.table("./test/subject_test.txt")
subject_train<-read.table("./train/subject_train.txt")
features<-read.table("./features.txt")
activity_labels<-read.table("./activity_labels.txt")
A<-cbind(y_test,subject_test)
colnames(A)<-c("activity","subject")
B<-cbind(y_train,subject_train)
colnames(B)<-c("activity","subject")
C<-rbind(A,B)
D<-rbind(x_train,x_test)
colnames(D)<-features[,2]
E<-D[,grep("mean\\(\\)|std\\(\\)",colnames(D))]
F<-cbind(C,E)
G<-aggregate(F,by=list(activity,subject),FUN=mean)
H<-G[,3:70]
head(activity_labels)
activity2<-H$activity
activity3<-gsub(pattern="1",replacement="WALKING",activity2)
activity4<-gsub(pattern="2",replacement="WALKING_UPSTAIRS",activity3)
activity5<-gsub(pattern="3",replacement="WALKING_DOWNSTAIRS",activity4)
activity6<-gsub(pattern="4",replacement="SITTING",activity5)
activity7<-gsub(pattern="5",replacement="STANDING",activity6)
activity8<-gsub(pattern="6",replacement="LAYING",activity7)
H[,1]<-activity8
write.table(H,"./UCI HAR Dataset/finaldataset.txt",row.name=FALSE)
finaldataset<-read.table(".UCI HAR Dataset/finaldataset.txt",header=TRUE)
finaldataset
```
