library(tidyverse)


# Chapter 3: Data visualization -------------------------------------------

#3.2.2 Creating a ggplot
#To plot mpg, run this code to put displ on the x-axis and hwy on the y-axis:

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg)

# 3.2.4 Exercises
# Run ggplot(data = mpg). What do you see?
## Blank grey square
  
# How many rows are in mpg? How many columns?
mpg
## A tibble: 234 x 11

# What does the drv variable describe? Read the help for ?mpg to find out.
?mpg
## the type of drive train, where f = front-wheel drive, r = rear wheel drive, 4 = 4wd

# Make a scatterplot of hwy vs cyl.
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = cyl, y = hwy))

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = hwy, y = cyl))

# What happens if you make a scatterplot of class vs drv? Why is the plot not useful?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = class, y = drv))
## plotting two categorical variables against each other
