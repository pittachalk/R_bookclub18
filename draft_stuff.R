library(tidyverse)

##############

#these two are completely equivalent
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  ggtitle("plot A")

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() +
  ggtitle("plot B")

##############

#an example to illustrate how multiple aes can be used
##seriously tho, don't plot three y variables 
##in the same plot --- it's bloody confusing
ggplot(data = mpg, mapping = aes(x = displ)) + 
  geom_point(mapping = aes(y = cyl)) +
  geom_point(mapping = aes(y = cty), colour = "red") +
  geom_point(mapping = aes(y = hwy), colour = "blue") +
  ggtitle("multiple aesthetics") +
  labs(y = "cyl (black), cty (red) and hwy (blue)")


##############

#useful stuff to recolour plots in R
#https://ggplot2.tidyverse.org/reference/scale_brewer.html

##############

#3.7.1 q1
ggplot(data = diamonds) + 
  stat_summary(
    mapping = aes(x = cut, y = depth),
    fun.ymin = min,
    fun.ymax = max,
    fun.y = median
  )

ggplot(data = diamonds) +
  geom_pointrange(
    mapping = aes(x = cut, y = depth),
    stat = "summary",
    fun.ymin = min,
    fun.ymax = max,
    fun.y = median
  )

#fancier version
ggplot(data = diamonds, 
       mapping = aes(x = cut, y = depth)) + 
  stat_summary(fun.ymin = min, fun.ymax = max, 
               fun.y = mean, colour = "red") +
  geom_point(alpha = 0.5, position = "jitter")

ggplot(data) +
  geom_point(mapping = aes(x = x, y = y,
                           colour = marker_gene_status))

ggplot(mapping = aes(x=x, y=y)) +
  geom_point(data %>% filter(marker == FALSE), 
             colour = "black") +
  geom_point(data %>% filter(marker == TRUE), 
             colour = "red")

data %>% filter(marker == FALSE) %>%
  group_by(geneid) %>%
  summarise(mean) -> x

randomVariablewithalOndName <- filter(data, marker == FALSE)
randomkVariablewithalOndName <- group_by(randomVariablewithalOndName, geneid)
randomVariablewithalOndName <- sumarrise(randomVariablewithalOndName, mean)




##############

#3.7.1 q4
ggplot(data = diamonds, mapping = aes(x = carat, y = depth) ) + 
  geom_point(alpha = 0.1, position = "jitter") +
  stat_smooth()

##############

#3.7.1 q5

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = ..prop..,
                         fill = color))

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = ..prop..))
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, y = ..prop.., group = 1))

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, y = ..prop.., 
                         fill = color, group = color))

#another example (type ?group):

# Multiple groups with one aesthetic
sample_data <- nlme::Oxboys #%>% 
  #filter(Subject %in% c(10,19,8,25,22))

h <- ggplot(data = sample_data, 
            mapping = aes(age, height, colour = Subject)) + 
  geom_point()
h

# this plots
h + geom_smooth()
h + geom_smooth(aes(group = Subject), formula = y~x,
                method = "lm")

## fits a single line of best fit across all points
h + geom_smooth(aes(group = 1), size = 2, method = "lm")

##############

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

filter(mpg, cyl == 8)
filter(diamonds, carat > 3)
