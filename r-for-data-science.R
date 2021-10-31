library(tidyverse)


# Chapter 3: Data visualization -------------------------------------------

#### 3.2.2 Creating a ggplot
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


### 3.3 Aesthetic mappings
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


### 3.3.1 Exercises
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
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = cty, size = cty))
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class, shape = class))

# 5. What does the stroke aesthetic do? What shapes does it work with? 
# (Hint: use ?geom_point)
?geom_point
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, stroke = cty))
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, stroke = class))
## For shapes that have a border (like 21), you can colour the inside and
## outside separately. Use the stroke aesthetic to modify the width of the
## border
ggplot(mtcars, aes(wt, mpg)) +
  geom_point(shape = 21, colour = "black", fill = "white", size = 5, stroke = 5)

# What happens if you map an aesthetic to something other than a variable name, 
# like aes(colour = displ < 5)? Note, you’ll also need to specify x and y.
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, colour = displ < 5))
## uses true/false & assigns colour based on result
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, colour = displ < 3))
## uses true/false & assigns colour based on result

### 3.5 Facets
## To facet your plot by a single variable, use facet_wrap(). 
## The first argument of facet_wrap() should be a formula, which you create with 
## ~ followed by a variable name (here “formula” is the name of a data structure 
## in R, not a synonym for “equation”). The variable that you pass to facet_wrap() 
## should be discrete.

# with 2 rows
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)

# with 3 rows
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 3)

# To facet your plot on the combination of two variables, add facet_grid() 
# to your plot call. The first argument of facet_grid() is also a formula. 
# This time the formula should contain two variable names separated by a ~.
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(drv ~ cyl)

# If you prefer to not facet in the rows or columns dimension, use a . 
# instead of a variable name, e.g. + facet_grid(. ~ cyl).
# e.g. by columns of cyl
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(. ~ cyl)

# e.g. by rows of cyl
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(cyl ~ .)

### 3.5.1 Exercises
# 1. What happens if you facet on a continuous variable?
  
# 2. What do the empty cells in plot with facet_grid(drv ~ cyl) mean? 
# How do they relate to this plot?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = drv, y = cyl))

# 3. What plots does the following code make? What does . do?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl)

# 4. Take the first faceted plot in this section:
  
  ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)

# What are the advantages to using faceting instead of the colour aesthetic?
# What are the disadvantages? 
# How might the balance change if you had a larger dataset?

# 5. Read ?facet_wrap. What does nrow do? 
# What does ncol do? 
# What other options control the layout of the individual panels? 
# Why doesn’t facet_grid() have nrow and ncol arguments?
  
# 6. When using facet_grid() you should usually put the variable with 
# more unique levels in the columns. Why?


