library(tidyverse)


# #### 3.2.2 Creating a ggplot --------------------------------------------

#To plot mpg, run this code to put displ on the x-axis and hwy on the y-axis:

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg)


# # 3.2.4 Exercises -------------------------------------------------------

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



# ### 3.3 Aesthetic mappings ----------------------------------------------
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



# ### 3.3.1 Exercises -----------------------------------------------------

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


# ### 3.5 Facets ----------------------------------------------------------
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


# ### 3.5.1 Exercises -----------------------------------------------------
## 1. What happens if you facet on a continuous variable?
# facet wrap on continuous
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ cty)
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ cty, nrow = 2)
# creates one per value

# facet grid on contiunous
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(. ~ cty)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(cty ~ .)

# 2. What do the empty cells in plot with facet_grid(drv ~ cyl) mean? 
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(drv ~ cyl)
## there are no values for  drv=r & cyl=4 or 5

# How do they relate to this plot?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = drv, y = cyl))
## the blanks in the bottom right also show no r+4 and r+5

# 3. What plots does the following code make? What does . do?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .)
## displ*hwy, divided by drive facets in horizontal rows

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ drv)
## displ*hwy, divided by drive facets in vertical columns

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl)
## displ*hwy, divided by cylinder facets in vertical columns

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(cyl ~ .)
## displ*hwy, divded by cylinder facets in horizontal rows


### 4. Take the first faceted plot in this section:
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)
## What are the advantages to using faceting instead of the colour aesthetic?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class))
# can more clearly see the relationship within each group
# and more clearly compare between
##  What are the disadvantages? 
# loses some comparison between
# How might the balance change if you had a larger dataset?

### 5. Read ?facet_wrap. What does nrow do? 
?facet_wrap
## What does ncol do?  Number of columns
## What other options control the layout of the individual panels? 
?facet_wrap
## Why doesn’t facet_grid() have nrow and ncol arguments?
?facet_grid
# it lays out values stratified by another value
  
# 6. When using facet_grid() you should usually put the variable with 
# more unique levels in the columns. Why?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(year ~ cyl)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(cyl ~ year)


### 3.6 Geometric objects ---------------------------------------------------

## To change the geom in your plot, change the geom function that you add to ggplot(). 
## For instance, to make the plots above, you can use this code:

# left: geom_point
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

# right: geom_smooth
ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy))

## Here geom_smooth() separates the cars into three lines based on their drv value, 
## which describes a car’s drivetrain. One line describes all of the points with a 
## 4 value, one line describes all of the points with an f value, and one line 
## describes all of the points with an r value. Here, 4 stands for four-wheel drive, 
## f for front-wheel drive, and r for rear-wheel drive.
ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv))

# ggplot2 will draw a separate object for each unique value of the grouping variable. 
# In practice, ggplot2 will automatically group the data for these geoms whenever you map an 
# aesthetic to a discrete variable (as in the linetype example). It is convenient to rely on this 
# feature because the group aesthetic by itself does not add a legend or distinguishing features to the geoms.
ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, group = drv))

ggplot(data = mpg) +
  geom_smooth(
    mapping = aes(x = displ, y = hwy, color = drv),
    show.legend = FALSE
  )
## NB: assigned color to drv and not group, and group was assigned automatically

###  To display multiple geoms in the same plot, add multiple geom functions to ggplot():
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  geom_smooth(mapping = aes(x = displ, y = hwy))

## You can avoid this type of repetition by passing a set of mappings to ggplot(). 
# ggplot2 will treat these mappings as global mappings that apply to each geom in the graph. 
# In other words, this code will produce the same plot as the previous code:
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()
#NB: x & y get assigned to "mapping", and then the geoms are applied after to the whole mapping


### If you place mappings in a geom function, ggplot2 will treat them as local mappings for the layer. 
## It will use these mappings to extend or overwrite the global mappings for that layer only. 
## This makes it possible to display different aesthetics in different layers.
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
  geom_smooth()
#NB: color = class overwrites only for point. what about line?
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth(mapping = aes(color = class))


### You can use the same idea to specify different data for each layer. 
## Here, our smooth line displays just a subset of the mpg dataset, the subcompact cars. 
## The local data argument in geom_smooth() overrides the global data argument in ggplot() for that layer only.
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
  geom_smooth(data = filter(mpg, class == "subcompact"), se = FALSE)
# NB: line only shows data for subcompact class
# NB: points show all classes as colours


# 3.6.1 Exercises ---------------------------------------------------------
## 1. What geom would you use to draw a line chart? geom_smooth
# A boxplot? geom_boxplot
# A histogram? geom_freqpoly
# An area chart? geom_ribbon	
## for answers, seach "geom_" in the Help box
  
## 2. Run this code in your head and predict what the output will look like. 
# using data from mpg, map x-axis=displ & y-axis=hwy and group by colors of drv
# put a scatterplot with all this info including the colour groupings
# then draw loess smoothed lines between the same groupings, w/ different colours
# "se" refers to whether to put a confidence interval, so no here

# Then, run the code in R and check your predictions.
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
  geom_point() + 
  geom_smooth(se = FALSE)

## 3. What does show.legend = FALSE do? 
## from help file:
# "logical. Should this layer be included in the legends? 
# NA, the default, includes if any aesthetics are mapped. 
# FALSE never includes, and TRUE always includes. 
# It can also be a named logical vector to finely select the aesthetics to display.

## What happens if you remove it? goes to NA default
## Why do you think I used it earlier in the chapter?
ggplot(data = mpg) +
  geom_smooth(
    mapping = aes(x = displ, y = hwy, color = drv),
    show.legend = FALSE
  )

ggplot(data = mpg) +
  geom_smooth(
    mapping = aes(x = displ, y = hwy, color = drv),
    show.legend = TRUE
  )

ggplot(data = mpg) +
  geom_smooth(
    mapping = aes(x = displ, y = hwy, color = drv)
  )

## 4. What does the se argument to geom_smooth() do?
# says whether to include 95% CI
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
  geom_point() + 
  geom_smooth(se = FALSE)

ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
  geom_point() + 
  geom_smooth(se = TRUE)
  

## 5. Will these two graphs look different? Why/why not?
# I think they will look the same because there's no commands to override the mapping assignment
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

## 6. Recreate the R code necessary to generate the following graphs.
# row 1, left
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(size = 5) + 
  geom_smooth()

# row 1, right
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, group = drv)) + 
  geom_point(size = 5) + 
  geom_smooth(size = 2, se = FALSE)

# row 2, left
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, colour = drv)) + 
  geom_point(size = 5) + 
  geom_smooth(size = 2, se = FALSE)

# row 2, right
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(size = 5, mapping = aes(color = drv)) + 
  geom_smooth(size = 2, se = FALSE)

# row 3, left
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(size = 5, mapping = aes(color = drv)) + 
  geom_smooth(size = 2, mapping = aes(linetype = drv), se = FALSE)

# row 3, right
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(size = 12, color = "white") +
  geom_point(size = 5, aes(colour = drv))


#### 3.7  - Statistical transformations --------------------------------------
## Consider a basic bar chart, as drawn with geom_bar(). 
# The chart shows that more diamonds are available with high quality cuts than with low quality cuts.
gplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut))

## You can generally use geoms and stats interchangeably. 
# For example, you can recreate the previous plot using stat_count() instead of geom_bar():
ggplot(data = diamonds) + 
  stat_count(mapping = aes(x = cut))
# NB: This works because every geom has a default stat; and every stat has a default geom.

# "In the code below, I change the stat of geom_bar() from count (the default) to identity."
demo <- tribble(
  ~cut,         ~freq,
  "Fair",       1610,
  "Good",       4906,
  "Very Good",  12082,
  "Premium",    13791,
  "Ideal",      21551
)

ggplot(data = demo) +
  geom_bar(mapping = aes(x = cut, y = freq), stat = "identity")

## you might want to display a bar chart of proportion, rather than count:
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = stat(prop), group = 1))

## You might want to draw greater attention to the statistical transformation in your code. 
# For example, you might use stat_summary(), which summarises the y values for each unique x value, 
# to draw attention to the summary that you’re computing:
ggplot(data = diamonds) + 
  stat_summary(
    mapping = aes(x = cut, y = depth),
    fun.min = min,
    fun.max = max,
    fun = median
  )

?stat_bin


# ### 3.7.1 Exercises -----------------------------------------------------
## 1. What is the default geom associated with stat_summary()? 
?stat_summary # geom_pointrage
# need to add "stat = "summary"" to get it to replace "stat_identity()"
# How could you rewrite the previous plot to use that geom function instead of the stat function?
ggplot(data = diamonds) + 
  stat_summary(
    mapping = aes(x = cut, y = depth),
    fun.min = min,
    fun.max = max,
    fun = median
  )

ggplot(data = diamonds) + 
  geom_pointrange(
    mapping = aes(x = cut, y = depth),
    stat = "summary"
  )
# this shows mean +/- SD, when we want min & max

ggplot(data = diamonds) +
  geom_pointrange(
    mapping = aes(x = cut, y = depth),
    stat = "summary",
    fun.min = min,
    fun.max = max,
    fun = median
  )
# this fixes it

## 2. What does geom_col() do? How is it different to geom_bar()?
?geom_col()
# geom_bar() makes the height of the bar proportional to the number of cases in each group 
# (or if the weight aesthetic is supplied, the sum of the weights). 
# If you want the heights of the bars to represent values in the data, use geom_col() instead. 

## 3. Most geoms and stats come in pairs that are almost always used in concert. 
# Read through the documentation and make a list of all the pairs. 
# What do they have in common?
  
## 4. What variables does stat_smooth() compute? What parameters control its behaviour?
?stat_smooth
  
## 5. In our proportion bar chart, we need to set group = 1. Why? 
# If group = 1 is not included, then all the bars in the plot will have the same height, a height of 1. 
# The function geom_bar() assumes that the groups are equal to the x values since the stat computes 
# the counts within the group.

# In other words what is the problem with these two graphs?
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = after_stat(prop)))

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, y = ..prop.., group = 1))

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = color, y = after_stat(prop)))

ggplot(data = diamonds) + 
  geom_bar(aes(x = cut, y = ..count.. / sum(..count..), fill = color))



#### 3.8 Position adjustments ------------------------------------------------
### You can colour a bar chart using either the colour aesthetic, or, more usefully, fill:
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, colour = cut))

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = cut))

## Note what happens if you map the fill aesthetic to another variable, like clarity: 
## the bars are automatically stacked. Each colored rectangle represents a combination of cut and clarity.
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity))


## If you don’t want a stacked bar chart, you can use one of three other options: "identity", "dodge" or "fill".
# position = "identity" will place each object exactly where it falls in the context of the graph. 
# This is not very useful for bars, because it overlaps them. 
# To see that overlapping we either need to make the bars slightly transparent by setting alpha to a small value, 
# or completely transparent by setting fill = NA.
ggplot(data = diamonds, mapping = aes(x = cut, fill = clarity)) + 
  geom_bar(alpha = 1/5, position = "identity")

ggplot(data = diamonds, mapping = aes(x = cut, colour = clarity)) + 
  geom_bar(fill = NA, position = "identity")

## position = "fill" works like stacking, but makes each set of stacked bars the same height. 
# This makes it easier to compare proportions across groups.
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "fill")

## position = "dodge" places overlapping objects directly beside one another. 
# This makes it easier to compare individual values.
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "dodge")

## position = "jitter" adds a small amount of random noise to each point. 
# This spreads the points out because no two points are likely to receive the same amount of random noise.
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), position = "jitter")
ggplot(data = mpg) + 
  geom_jitter(mapping = aes(x = displ, y = hwy))
# cf.
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))


# 3.8.1 Exercises ---------------------------------------------------------
### 1. What is the problem with this plot? How could you improve it?
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_point()

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_jitter()

### 2. What parameters to geom_jitter() control the amount of jittering?
?geom_jitter
# "width = " & "height = "
# Amount of vertical and horizontal jitter. The jitter is added in both positive and negative directions, 
# so the total spread is twice the value specified here.
# If omitted, defaults to 40% of the resolution of the data: 
# this means the jitter values will occupy 80% of the implied bins. 
# Categorical data is aligned on the integers, so a width or height of 0.5 will spread the data 
# so it's not possible to see the distinction between the categories.
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_jitter(width = 0, height = 0)
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_jitter(width = 50, height = 50)

### 3. Compare and contrast geom_jitter() with geom_count().
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_jitter()

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_count() # this is a nice way to emphasize relative frequency
# without introducing the random noise
# but with biger dots might become unreadable
ggplot(data = mpg, mapping = aes(x = cty, y = hwy, colour = drv)) + 
  geom_count()
ggplot(data = mpg, mapping = aes(x = cty, y = hwy, colour = class)) + 
  geom_count()

ggplot(data = mpg, mapping = aes(x = cty, y = hwy, colour = class)) + 
  geom_count(position = "jitter")


### 4. What’s the default position adjustment for geom_boxplot()? 
## Create a visualisation of the mpg dataset that demonstrates it.
ggplot(data = mpg, mapping = aes(x = cty, y = hwy, group = drv)) + 
  geom_boxplot()

ggplot(data = mpg, mapping = aes(x = drv, y = hwy, colour = class)) + 
  geom_boxplot()



# #### 3.9 Coordinate systems ---------------------------------------------
## The default coordinate system is the Cartesian coordinate system where the x and y positions 
## act independently to determine the location of each point. 
## There are a number of other coordinate systems that are occasionally helpful.

## coord_flip() switches the x and y axes. 
# This is useful (for example), if you want horizontal boxplots. 
# It’s also useful for long labels: it’s hard to get them to fit without overlapping on the x-axis.
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
  geom_boxplot()

ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
  geom_boxplot() +
  coord_flip()

ggplot(data = mpg, 
       mapping = aes(x = drv, y = hwy, colour = class)) + 
  geom_boxplot() +
  coord_flip()

## coord_quickmap() sets the aspect ratio correctly for maps. 
# This is very important if you’re plotting spatial data with ggplot2 
# (which unfortunately we don’t have the space to cover in this book).
install.packages("maps")
library(maps)

nz <- map_data("nz")

ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", colour = "black")

ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", colour = "black") +
  coord_quickmap()

## coord_polar()uses polar coordinates. 
# Polar coordinates reveal an interesting connection between a bar chart and a Coxcomb chart.
bar <- ggplot(data = diamonds) + 
  geom_bar(
    mapping = aes(x = cut, fill = cut), 
    show.legend = FALSE,
    width = 1
  ) + 
  theme(aspect.ratio = 1) +
  labs(x = NULL, y = NULL)

bar + coord_flip()
bar + coord_polar()


# ### 3.9.1 Exercises -----------------------------------------------------
## 1. Turn a stacked bar chart into a pie chart using coord_polar().
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity))

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity)) +
  coord_polar()

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity)) +
  coord_flip()

## 2. What does labs() do? Read the documentation.
?labs()
# modify axis, legend, and plot lables

## 3. What’s the difference between coord_quickmap() and coord_map()?
?coord_quickmap
?coord_map
# coord_map() projects a portion of the earth, which is approximately spherical, 
# onto a flat 2D plane using any projection defined by the mapproj package. 
# Map projections do not, in general, preserve straight lines, so this requires considerable computation. 
# coord_quickmap is a quick approximation that does preserve straight lines. 
# It works best for smaller areas closer to the equator.

## 4. What does the plot below tell you about the relationship between city and highway mpg? 
## Why is coord_fixed() important? What does geom_abline() do?
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_point() + 
  geom_abline() +
  coord_fixed()

?coord_fixed()
## Cartesian coordinates with fixed "aspect ratio"
# A fixed scale coordinate system forces a specified ratio between the physical representation of data 
# units on the axes. The ratio represents the number of units on the y-axis equivalent to one unit on the x-axis. 
# The default, ratio = 1, ensures that one unit on the x-axis is the same length as one unit on the y-axis. 
# Ratios higher than one make units on the y axis longer than units on the x-axis, and vice versa. 