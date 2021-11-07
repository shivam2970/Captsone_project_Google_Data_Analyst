library(tidyverse)

daily_activity <- ("dailyActivity_merged.csv")
sleep_day <- read.csv("sleepDay_merged.csv")

head(daily_activity)
head(sleep_day)

colnames(dailyActivity_merged)
colnames(sleep_day)

n_distinct(dailyActivity_merged$Id)
n_distinct(sleep_day$Id)

nrow(dailyActivity_merged)
nrow(sleep_day)

dailyActivity_merged %>%  
  select(TotalSteps,
         TotalDistance,
         SedentaryMinutes) %>%
  summary()

sleep_day %>%  
  select(TotalSleepRecords,
         TotalMinutesAsleep,
         TotalTimeInBed) %>%
  summary()

ggplot(data=dailyActivity_merged)+
  geom_point(mapping = aes(x=TotalSteps,y=SedentaryMinutes))

ggplot(data=sleep_day)+
  geom_point(mapping=aes(x=TotalMinutesAsleep,y=TotalTimeInBed))

combined_data<- merge(dailyActivity_merged,sleep_day, by="Id")

n_distinct(combined_data$Id)

ggplot(data = combined_data)+
  geom_point(mapping = aes(x=TotalMinutesAsleep,y=TotalSteps,color=Id))+
  facet_wrap(~Id)+
  labs(title="Sleep VS Steps",subtitle = "the Charts shows sleep vs steps graph of each id")

daily_steps<- read.csv("dailySteps_merged.csv")
weight<- read.csv("weightLogInfo_merged.csv")
head(daily_steps)
head(weight)
combined_data2<- merge(daily_steps,weight, by="Id")
library(tidyverse)
weight %>% 
  select(WeightKg,
         BMI,
        Fat) %>% 
  summary()

ggplot(data=combined_data2)+
  geom_point(mapping=aes(x=WeightKg,y=StepTotal))+
  labs(title = "Steps VS Weight",
       Subtitle="This Graph Shows relation between steps and weight")+
  annotate("text", x=125,y=5000,
           label="these peoples cannot walk more because of their weight",
           color="red",
           fontface="bold",
           angle=90)

calories<- read.csv("dailyCalories_merged.csv")
combined_data3<- merge(calories,weight, by="Id")
ggplot(data=combined_data3)+
  geom_point(mapping=aes(x=Calories,y=WeightKg))