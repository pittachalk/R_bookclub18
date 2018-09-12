library(tidyverse)
library(nycflights13)

?flights

#prints and saves the variables
(dec25 <- filter(flights, month == 12, day == 25))

#issues with floating point numbers
sqrt(2) ^ 2 == 2
near(sqrt(2) ^ 2, 2)

#de morgan's law
flights %>% filter(arr_delay <= 120, dep_delay <= 120) %>% nrow()
flights %>% filter(!(arr_delay > 120 | dep_delay > 120)) %>% nrow()

#filter excludes NA values by default

#exercise 5.2
View(flights %>% filter(between(dep_time, 0, 600)), dep_time == 2400)

View(flights %>% filter(is.na(dep_time)))

NA ^ 0 #any number to the power of 0 is 1
NA * 0 #this is not true for infinity

NA | FALSE 

#Inf, 0 and negative numbers are FALSE
TRUE & NA 
FALSE & NA 

View(flights %>% arrange(desc(is.na(dep_time)), dep_time))

#this is useful to move a few things to the start
select(flights, time_hour, air_time, everything())

#doesnt do shit
rename(flights)

select(flights, dep_time, arr_time, dep_time) #doesnt replicate it

#ignore cases!
select(flights, contains("TIME", ignore.case = FALSE))

lag(1:10)
lead(1:10)

#comparing air time with arr_time - dep_time
flights %>% transmute(air_time, test = arr_time - dep_time, arr_time, dep_time)

flights %>% transmute(air_time, arr_time, dep_time, 
                      compare = (arr_time %/% 100 - dep_time %/% 100) * 60 +
                        arr_time %% 100 - dep_time %% 100)
                        
dictionary <- airports$tz
names(dictionary) <- airports$faa

flights %>% transmute(air_time, arr_time, dep_time, 
                      arr_time_min = arr_time %/% 100 * 60 + arr_time %% 100,
                      dep_time_min = dep_time %/% 100 * 60 + dep_time %% 100,
                      air_time_2 = (arr_time_min - dep_time_min + 1440) %% 1440,
                      air_time_diff = air_time_2 - air_time)

dictionary <- airports$tz
names(dictionary) <- airports$faa

dictionary2 <- airports$dst
names(dictionary2) <- airports$faa

flights_test <- flights %>% mutate(
  origintz = dictionary[origin],
  desttz = dictionary[dest],
  origindst = dictionary2[origin], 
  destdst = dictionary2[dest])

#3.6: 
not_cancelled <- flights %>% filter(!is.na(dep_delay), !is.na(arr_delay))

delays <- not_cancelled %>% group_by(tailnum) %>% summarise(
  delay = mean(arr_delay) )

not_cancelled %>%
  group_by(year, month, day) %>% 
  summarise(avg_delay1 = mean(arr_delay),
            avg_delay2 = mean(arr_delay[arr_delay > 0]) # the average positive delay
  )

not_cancelled %>%
  group_by(dest) %>%
  summarise(no_unique = length(unique(origin)), distance_sd = sd(distance)) %>% 
  arrange(desc(distance_sd), no_unique) %>%
  ggplot(aes(no_unique, distance_sd)) +
  geom_point()

#n_distinct, min_rank, count(wt)

#function to add weighted means

filter(flights, is.na(air_time), !is.na(dep_delay)) %>%
  select(dep_time, arr_time, sched_arr_time, dep_delay, arr_delay, air_time) %>%  tail()

filter(flights, !is.na(dep_delay), is.na(arr_delay), is.na(air_time)) %>%
  select(dep_time, arr_time, sched_arr_time, dep_delay, arr_delay, air_time)

ggplot(flights, aes(x = dep_delay, y = arr_delay)) + geom_point()
