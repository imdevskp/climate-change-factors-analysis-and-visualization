#--------------------------------------------------------------------

library(ggplot2)

#--------------------------------------------------------------------

# setwd('../vis/data/')

#--------------------------------------------------------------------

df_glacier <- read.csv('data/ga_glaciers_mass.csv', head=T)
df_temp <- read.csv('data/ga_temp.csv', head=T)
df_sea <- read.csv('data/ga_sea_level.csv', head=T)
df_co2 <- read.csv('data/ga_mean_co2.csv', head=T)

#---------------------------------------------------------------------

# glacier
# 1945-2014
# US EPA and the World Glacier Monitoring Service (WGMS)
# mean cumulative mass balance of "reference" Glaciers worldwide 
# set of "reference" glaciers worldwide beginning in 1945
# negative values indicate a net loss of ice and snow compared with the base year of 1945. 
# measurements are in meters of water equivalent

print(head(df_glacier))
print(str(df_glacier))

colnames(df_glacier)<-c('year', 'glacier_mass', 'no_of_observation')

ggplot(df_glacier, aes(year, glacier_mass)) +
  geom_point(aes(color=glacier_mass)) +
  geom_smooth()+
  labs(x = "Year", 
       y = "Mean Cumulative Mass (Meters of water equivalent)", 
       title = "Year vs Mean Cumulative Mass")

#--------------------------------------------------------------------

# temperature
# 1951-1980
# NASA/GISS
# change in global surface temperature relative to 1951-1980 average temperatures. 
# Eighteen of the 15 warmest years all have occurred since 2001, with the exception of 1998. 
# The year 2016 ranks as the warmest on record. (Source: NASA/GISS).

print(head(df_temp))
print(str(df_sea))

colnames(df_temp)<-c('source', 'year', 'mean_temp')
df_temp<-df_temp[df_temp['source']=='GCAG',]

ggplot(df_temp, aes(year, mean_temp)) +
  geom_point(aes(color=mean_temp)) +
  geom_smooth()+
  labs(x = "Year", 
       y = "Temperature (Celsius)", 
       title = "Year vs Temperature")

#--------------------------------------------------------------------

# sea level
# 1880-2014 
# US Environmental Protection Agency using data from CSIRO
# "cumulative changes in sea level for the world's oceans since 1880
# based on a combination of long-term tide gauge measurements and recent satellite measurements. 
# It shows average absolute sea level change, 
# which refers to the height of the ocean surface, 
# regardless of whether nearby land is rising or falling. 
# Satellite data are based solely on measured sea level, 
# while the long-term tide gauge data include a small correction factor 

print(head(df_sea))
print(str(df_sea))

colnames(df_sea) <- c('date', 'sea_level')
df_sea$date <- as.Date(df_sea$date)
df_sea$year <- substr(df_sea$date, 1, 4)

ggplot(df_sea, aes(date, sea_level)) +
  geom_point(aes(color=sea_level)) +
  geom_smooth()+
  labs(x = "Year", y="Sea Level", title="Year vs Sea Level")

grouped_year_sea_level <- aggregate(sea_level ~ year, df_sea, mean)

ggplot(grouped_year_sea_level, aes(year, sea_level)) +
  geom_point() +
  geom_smooth()+
  labs(x = "Year", 
       y = "Sea Level Variation (mm)", 
       title = "Year vs Sea Level")

#----------------------------------------------------------------------------------------

# co2 (PPM)
# US Government's Earth System Research Laboratory, Global Monitoring Division
# Trends in Atmospheric Carbon Dioxide
# Carbon dioxide (CO2) is an important heat-trapping (greenhouse) gas 
# released through human activities such as deforestation and burning fossil fuels 
# as well as natural processes such as respiration and volcanic eruptions.

print(head(df_co2))
print(str(df_co2))

colnames(df_co2) <- c('year', 'mean_co2', 'uncertanity')
df_co2$date <- as.Date(df_co2$year, format = '%Y-%m-%d')

ggplot(df_co2, aes(date, mean_co2)) +
  geom_point() +
  geom_smooth()+
  labs(x = "Year", 
       y = "CO2 (PPM)", 
       title = "Year vs CO2 Level")

#--------------------------------------------------------------------------------

