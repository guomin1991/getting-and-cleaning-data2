y_train<-read.table("./UCI HAR Dataset/train/y_train.txt")
x_train<-read.table("./UCI HAR Dataset/train/X_train.txt")
y_test<-read.table("./UCI HAR Dataset/test/y_test.txt")
x_test<-read.table("./UCI HAR Dataset/test/X_test.txt")
subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt")
subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt")
features<-read.table("./UCI HAR Dataset/features.txt")
activity_labels<-read.table("./UCI HAR Dataset/activity_labels.txt")
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
head(activity8)
H[,1]<-activity8
write.table(H,"./UCI HAR Dataset/finaldataset.txt",row.name=FALSE)
finaldataset<-read.table("D:/学习/数据分析/coursera笔记/Getting and Cleaning Data/UCI HAR Dataset/finaldataset.txt",header=TRUE)
finaldataset

