library(tidyverse)


# Chapter 3: Data visualization -------------------------------------------

#3.2.2 Creating a ggplot
#To plot mpg, run this code to put displ on the x-axis and hwy on the y-axis:

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg)

# 3.2.4 Exercises
# 1. Run ggplot(data = mpg). What do you see?
## Blank grey square
  
# 2. How many rows are in mpg? How many columns?
mpg
## A tibble: 234 x 11

# 3. What does the drv variable describe? Read the help for ?mpg to find out.
?mpg
## the type of drive train, where f = front-wheel drive, r = rear wheel drive, 4 = 4wd

# 4. Make a scatterplot of hwy vs cyl.
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = cyl, y = hwy))

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = hwy, y = cyl))

# 5. What happens if you make a scatterplot of class vs drv? Why is the plot not useful?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = class, y = drv))
## plotting two categorical variables against each other


# 3.3 Aesthetic mappings
## You can convey information about your data by mapping the aesthetics in 
## your plot to the variables in your dataset. For example, you can map the 
## colors of your points to the class variable to reveal the class of each car.
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class))

# We get a warning here, because mapping an unordered variable (class) 
# to an ordered aesthetic (size) is not a good idea.
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, size = class))
#> Warning: Using size for a discrete variable is not advised.

# Or we could have mapped class to the alpha aesthetic, which controls 
# the transparency of the points, or to the shape aesthetic, which controls 
# the shape of the points.
# Left
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, alpha = class))

# Right 
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, shape = class))
# ggplot will only use 6 shapes at a time

# You can also set the aesthetic properties of your geom manually. For example, we can make all of the points in our plot blue:
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue")
# Here, the color doesn’t convey information about a variable, but only 
# changes the appearance of the plot. To set an aesthetic manually, set the 
# aesthetic by name as an argument of your geom function; i.e. it goes outside 
# of aes(). 


# 3.3.1 Exercises
# 1. What’s gone wrong with this code? Why are the points not blue?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = "blue"))
# general color assignment is inside the brackets, when it should be outside
# because it doesn't refer to the "aes" assignment/a variable
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue")

# 2. Which variables in mpg are categorical? Which variables are continuous? 
# (Hint: type ?mpg to read the documentation for the dataset). 
# How can you see this information when you run mpg?
mpg
str(mpg)
  
# 3. Map a continuous variable to color, size, and shape. 
# How do these aesthetics behave differently for categorical vs. continuous variables?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class))
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = cty))
# color becomes continuous/gradient

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, size = class))
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, size = cty))
#size better reflects value, also gradient

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, shape = class))
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, shape = cty))
#Error: A continuous variable can not be mapped to shape
  
# 4. What happens if you map the same variable to multiple aesthetics?
  
# 5. What does the stroke aesthetic do? What shapes does it work with? 
# (Hint: use ?geom_point)

# What happens if you map an aesthetic to something other than a variable name, 
# like aes(colour = displ < 5)? Note, you’ll also need to specify x and y.
