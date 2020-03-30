getwd()

InternalTrack <- read.csv("Datathon_Internal.csv")
#convert HubID to char
InternalTrack$HubRandomID <- as.character(InternalTrack$HubRandomID)
typeof(InternalTrack$HubRandomID)

#convert ActivityDate to type date 
typeof(InternalTrack$ActivityDate)
InternalTrack$ActivityDate <- as.Date(InternalTrack$ActivityDate, "%d/%m/%y")
typeof(InternalTrack$ActivityDate)

install.packages("tidyr")
library(tibble)
library()

InternalTrack_1<- InternalTrack[c(2:7,9,22:28)]

InternalTrack_1

# check Hub_ActivityID is unique identifieer
InternalTrack %>% select(Hub_ActivityID) %>% distinct %>% nrow()
InternalTrack %>% select(ActivityDate) %>% distinct %>% nrow()
InternalTrack %>% group_by(HubRandomID) %>% summarise(count= n()) 
?tally
?group_by
InternalTrack %>% group_by(HubRandomID) %>% tally()
INTER<- InternalTrack %>% group_by(HubRandomID, ActivityDate) %>% tally()

InternalTrack2.0<-InternalTrack_1 %>% filter(ProgrammeID.1!=69) #clean data set! whoop! 

InternalTrack %>% filter(ProgrammeID.1==69) %>% nrow() #Check that the right number of rows where removed


test<- InternalTrack2.0%>% filter(HubRandomID==10011) %>% filter(ActivityDate=="1/3/19")
test #programs 56:58 run no attendees, all service referals 

#Filters out referral activities  

InternalTrack3.0 <- InternalTrack2.0 %>% filter(ChildParticipants!= 0, AdultParticipants!=0, ReferralParticipants==0)


is.na(InternalTrack3.0$ChildParticipants) %>%  unique()
InternalTrack3.0$ActivityDate %>% class()

#Format date
InternalTrack3.0 %<>% 
  mutate(FormatDate = format(ActivityDate, "%b -%Y"))
library(magrittr)  

df<- data.frame(HubID=InternalTrack3.0$HubRandomID, ActivityDate = InternalTrack3.0$ActivityDate)

df %<>% mutate(FormatDate=format(ActivityDate, "%b-%Y"))


# get one row for each unique date (regardless of activity run on that date)
df_unique_dates <- df %>% unique()


# compute number of unique dates per month for each HubID 
df_HubActiveDayCount<- df_unique_dates %>% 
  group_by(HubID, FormatDate) %>% summarise(n=n())

# use pivot_wider to spread out months as columns, fill cell vals with row counts for each unique date
df_numactivedays_per_month=df_HubActiveDayCount %>% 
  pivot_wider(id_cols= HubID,names_from=FormatDate , values_from=n)

# convert NAs to zero 
df_numactivedays_per_month[is.na(df_numactivedays_per_month)]<-0


# Make dataframe chronological
df_numactivedays_per_month_chron <- df_numactivedays_per_month[, c("HubID","Jan-2016", "Feb-2016", "Mar-2016", "Apr-2016", "May-2016", "Jun-2016", "Jul-2016", "Aug-2016","Sep-2016", "Oct-2016", "Nov-2016", "Dec-2016" ,"Jan-2017", "Feb-2017", "Mar-2017", "Apr-2017", "May-2017", "Jun-2017", "Jul-2017", "Aug-2017","Sep-2017", "Oct-2017", "Nov-2017", "Dec-2017", "Jan-2018", "Feb-2018"
,"Mar-2018","Apr-2018", "May-2018", "Jun-2018", "Jul-2018","Aug-2018", "Sep-2018", "Oct-2018", "Nov-2018", "Dec-2018", "Jan-2019", "Feb-2019","Mar-2019", "Apr-2019", "May-2019", "Jun-2019", "Jul-2019", "Aug-2019", "Sep-2019", "Oct-2019", "Nov-2019", "Dec-2019")]

df_Jan2016 <- df_numactivedays_per_month_chron %>% select("Jan-2016") 


#Put data frame into quaters. 

#Couldnt figure out how to add columns.I think I need to convert the values in the columns to type numeric 

#2016 quarters
active_numdays_q <- df_numactivedays_per_month_chron
active_numdays_q<- cbind(df_numactivedays_per_month_chron$HubID)
  
active_numdays_q$`Q1-2016` <-c( df_numactivedays_per_month_chron$`Jan-2016` + df_numactivedays_per_month_chron$`Feb-2016` + df_numactivedays_per_month_chron$`Mar-2016`)
active_numdays_q$`Q2-2016` <-c( df_numactivedays_per_month_chron$`Apr-2016` + df_numactivedays_per_month_chron$`May-2016` + df_numactivedays_per_month_chron$`Jun-2016`)
active_numdays_q$`Q3-2016` <-c( df_numactivedays_per_month_chron$`Jul-2016` + df_numactivedays_per_month_chron$`Aug-2016` + df_numactivedays_per_month_chron$`Sep-2016`)
active_numdays_q$`Q4-2016` <-c( df_numactivedays_per_month_chron$`Oct-2016` + df_numactivedays_per_month_chron$`Nov-2016` + df_numactivedays_per_month_chron$`Dec-2016`)

#2017 quarters
active_numdays_q$`Q1-2017` <-c( df_numactivedays_per_month_chron$`Jan-2017` + df_numactivedays_per_month_chron$`Feb-2017` + df_numactivedays_per_month_chron$`Mar-2017`)
active_numdays_q$`Q2-2017` <-c( df_numactivedays_per_month_chron$`Apr-2017` + df_numactivedays_per_month_chron$`May-2017` + df_numactivedays_per_month_chron$`Jun-2017`)
active_numdays_q$`Q3-2017` <-c( df_numactivedays_per_month_chron$`Jul-2017` + df_numactivedays_per_month_chron$`Aug-2017` + df_numactivedays_per_month_chron$`Sep-2017`)
active_numdays_q$`Q4-2017` <-c( df_numactivedays_per_month_chron$`Oct-2017` + df_numactivedays_per_month_chron$`Nov-2017` + df_numactivedays_per_month_chron$`Dec-2017`)

#2018 quarters
active_numdays_q$`Q1-2018` <-c( df_numactivedays_per_month_chron$`Jan-2018` + df_numactivedays_per_month_chron$`Feb-2018` + df_numactivedays_per_month_chron$`Mar-2018`)
active_numdays_q$`Q2-2018` <-c( df_numactivedays_per_month_chron$`Apr-2018` + df_numactivedays_per_month_chron$`May-2018` + df_numactivedays_per_month_chron$`Jun-2018`)
active_numdays_q$`Q3-2018` <-c( df_numactivedays_per_month_chron$`Jul-2018` + df_numactivedays_per_month_chron$`Aug-2018` + df_numactivedays_per_month_chron$`Sep-2018`)
active_numdays_q$`Q4-2018` <-c( df_numactivedays_per_month_chron$`Oct-2018` + df_numactivedays_per_month_chron$`Nov-2018` + df_numactivedays_per_month_chron$`Dec-2018`)

#2019 quarters
active_numdays_q$`Q1-2019` <-c( df_numactivedays_per_month_chron$`Jan-2019` + df_numactivedays_per_month_chron$`Feb-2019` + df_numactivedays_per_month_chron$`Mar-2019`)

# Ilana - checking this works

active_numdays_q$`Q2-2019` <-c( df_numactivedays_per_month_chron$`Apr-2019` + df_numactivedays_per_month_chron$`May-2019` + df_numactivedays_per_month_chron$`Jun-2019`)
active_numdays_q$`Q3-2019` <-c( df_numactivedays_per_month_chron$`Jul-2019` + df_numactivedays_per_month_chron$`Aug-2016` + df_numactivedays_per_month_chron$`Sep-2016`)
active_numdays_q$`Q4-2019` <-c( df_numactivedays_per_month_chron$`Oct-2016` + df_numactivedays_per_month_chron$`Nov-2019` + df_numactivedays_per_month_chron$`Dec-2019`)

ts(active_numdays_q)


x<-active_numdays_q %>% select("Q1-2016") %>% summarise( "Q1-2016"= sum())

df_ActiveDays_perQ <-
time_series <- ts(df_numactivedays_per_month)
ts.plot(time_series)

hist(df_numactivedays_per_month$'Nov-2019')

# Ilana addition
hist(df_numactivedays_per_month$'Nov-2019', main="Number of Active Days per month \n Nov 2019", xlab="Number of Active Days")
#-end

summary.data.frame(df_numactivedays_per_month)
??multiple

rownames(active_numdays_q) <- active_numdays_q$HubID

??mts
x<- as.vector(df_numactivedays_per_month_chron[ c(1:29),10011])
ts(x)
TS_10011 <- as.vector(unlist(active_numdays_q[1,]))
plot.ts(TS_10011)
TS_10011


for (i in seq_along(unique(active_numdays_q$HubID))) 
{
  TS[[i]] <-  as.vector((unlist(active_numdays_q[i,])))
  
  #PLOT[i]<- plot.ts(TS[i])
  
  #df_time_series <- data_frame()
  
  
}  

## -  Ilana add start

library(zoo) # a time series package that has some extra features 
require(ggplot2) # plotting tool
require(reshape2) # for widen and lengthening data frames 

# Prepare a new dataframe for plotting with zoo and ggplot2
##########

#  convert column names to date object 
quarters_list<-colnames(active_numdays_q)[-c(1)] # all column names except first 

date_names<-as.Date(as.yearqtr(quarters_list, format = "Q%q-%Y")) # convert quarters to date format

# Transpose df ('t' is a transpose funciton) so rows are dates and columns are hubs
TS_DF<-t(active_numdays_q[,-c(1)]) %>% apply(2,function(x){as.numeric(x)})
colnames(TS_DF)<-active_numdays_q$HubID
rownames(TS_DF)<-colnames(active_numdays_q[-c(1)])

# create new df by binding date column with hub columns
TS_DF_with_dates <- data.frame(time=date_names) %>% 
  bind_cols(data.frame(TS_DF))
colnames(TS_DF_with_dates)<- str_replace_all(colnames(TS_DF_with_dates),"X","") # remove "X" from column names which strangely got added in previous step 

# convert to long format
df <- melt(TS_DF_with_dates ,  id.vars = 'time', variable.name = 'series')
# head(df) # use this to get a look at your data if you need to 

# plot all hubs on the one plot
ggplot(df, aes(time,value)) + geom_line(aes(colour = series))

# plot one or two series (hubs) only
ggplot(df %>% filter(series==11227 | series==11491), aes(time,value)) + geom_line(aes(colour = series))

# sample 8 rows randomly from hubs
#set.seed(100) # i think this is supposed to keep sampling constant, but does seems to be working. 

hub_samples=sample(active_numdays_q$HubID,8) %>% as.character()
ggplot(df %>% filter(series %in% hub_samples), aes(time,value)) + geom_line(aes(colour = series))
??sample
  ??series

#- end Ilana #

