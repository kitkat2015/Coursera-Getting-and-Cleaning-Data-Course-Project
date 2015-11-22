  # Download files into a data folder
if(!file.exists("./data")) {dir.create("./data")}
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip",method="curl")
if (!file.exists("UCI HAR Dataset")) { 
  unzip("./data/Dataset.zip",exdir="./data") 
}
datapath<- file.path("./data" , "UCI HAR Dataset")

  # Read Subject, Activity and Features files
testSubject<-read.table(file.path(datapath,"test","subject_test.txt"))
trainSubject<-read.table(file.path(datapath,"train","subject_train.txt"))
testActivity<-read.table(file.path(datapath,"test","y_test.txt"))
trainActivity<-read.table(file.path(datapath,"train","y_train.txt"))
testFeatures<-read.table(file.path(datapath,"test","X_test.txt"))
trainFeatures<-read.table(file.path(datapath,"train","X_train.txt"))
Featureslabels<-read.table(file.path(datapath,"features.txt"))
Activitylabels<-read.table(file.path(datapath,"activity_labels.txt"))

  # Combine Subject, Activity and Features data from test and training sets
Subject<-rbind(testSubject,trainSubject)
Activity<-rbind(testActivity,trainActivity)
Features<-rbind(testFeatures,trainFeatures)

  # Create data frame and set column names
data<-cbind(Subject,Activity,Features)
colnames(data)<-c("Subject","Activity",as.character(Featureslabels$V2))

  # Retain mean and standard deviation for each measurement in the data
selectFeatures<-Featureslabels$V2[grep("mean\\(\\)|std\\(\\)",Featureslabels$V2)]
selectColumns<-c("Subject","Activity",as.character(selectFeatures))
data<-subset(data,select=selectColumns)

  # Define activity labels in the data
data$Activity<-factor(data$Activity,levels=Activitylabels$V1,labels=Activitylabels$V2)

  # Label data with descrptive variables names
names(data)<-gsub("^t","time",names(data))
names(data)<-gsub("^f","frequency",names(data))
names(data)<-gsub("Acc","Accelerometer",names(data))
names(data)<-gsub("Gyro","Gyroscope",names(data))
names(data)<-gsub("Mag","Magnitude",names(data))
names(data)<-gsub("BodyBody","Body",names(data))

  # Summary with average of each variable for each activity and each subject
summaryData<-aggregate(.~Subject+Activity,data,mean,na.rm=TRUE)
write.table(summaryData,"tidysummarydata.txt",row.names=FALSE)


  
  
