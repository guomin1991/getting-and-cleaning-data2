# getting-and-cleaning-data
* Read files X_test,X_train.y_test,y_train,Subject_test,Subject_train,features and activity_lables text files into dataframes.

y_train<-read.table("./UCI HAR Dataset/train/y_train.txt")
x_train<-read.table("./UCI HAR Dataset/train/X_train.txt")
y_test<-read.table("./UCI HAR Dataset/test/y_test.txt")
x_test<-read.table("./UCI HAR Dataset/test/X_test.txt")
subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt")
subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt")
features<-read.table("./UCI HAR Dataset/features.txt")
activity_labels<-read.table("./UCI HAR Dataset/activity_labels.txt")




* Column bind Dataframes y_test and subject_test and add column names Activity and Subject to it. 

A<-cbind(y_test,subject_test)
colnames(A)<-c("activity","subject")




* Column bind Dataframes y_train and subject_train and add column names Activity and Subject to it. 

B<-cbind(y_train,subject_train)
colnames(B)<-c("activity","subject")




* Merge A and B (dim-10299*2) ->C； Merge X_train and X_test data -> D (dim-10299*561)

C<-rbind(A,B)
D<-rbind(x_train,x_test)




* Change column names of D from features.txt

colnames(D)<-features[,2]




* Eliminate columns from D which do not have "mean()" or "std()" in the column names. ->E (dim-10299*66)

E<-D[,grep("mean\\(\\)|std\\(\\)",colnames(D))]




* Column bind C and E (dim-10299*68)

F<-cbind(C,E)




* Take mean of observations per activity per subject. (dim-180*68). 

G<-aggregate(F,by=list(activity,subject),FUN=mean)
H<-G[,3:70]




* Replace activity numbers with Activity names from activity_lables.txt-> Final Table

head(activity_labels)
activity2<-H$activity
activity3<-gsub(pattern="1",replacement="WALKING",activity2)
activity4<-gsub(pattern="2",replacement="WALKING_UPSTAIRS",activity3)
activity5<-gsub(pattern="3",replacement="WALKING_DOWNSTAIRS",activity4)
activity6<-gsub(pattern="4",replacement="SITTING",activity5)
activity7<-gsub(pattern="5",replacement="STANDING",activity6)
activity8<-gsub(pattern="6",replacement="LAYING",activity7)
head(activity8)
H[,1]<-activity8




* use write.table to get a text file from the above Data Frame.Submit this text file for Question 1 of Assessment

write.table(H,"./UCI HAR Dataset/finaldataset.txt",row.name=FALSE)
finaldataset<-read.table("./UCI HAR Dataset/finaldataset.txt",header=TRUE)
finaldataset

