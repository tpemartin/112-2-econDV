
>>> USER:
give me three color hex that are diiferent in hue but same on saturation and lightness

>>> ASSISTANT:
1. #FF4C29 (red hue)
2. #21FF4C (green hue)
3. #4C29FF (blue hue)

>>> USER:
for each color, give me another three color hex that are different only in saturation but same in hue and lightness

>>> ASSISTANT:
Sure! Here are three variations for each color:

1. #FF4C29 (red hue):
   - #FF8363 (higher saturation)
   - #FF190D (lower saturation)
   - #FF2A0E (lower saturation)
   
2. #21FF4C (green hue):
   - #5EFF8F (higher saturation)
   - #14FF39 (lower saturation)
   - #2DFF3F (lower saturation)

3. #4C29FF (blue hue):
   - #7B5AFF (higher saturation)
   - #261EFF (lower saturation)
   - #361DFF (lower saturation)


>>> USER:
Create a panel data frame that has "department" as identity dimension and "year" from 2014 to 2018 as time dimension. The "share" column records the teacher-student share of each department in each year. The "faculty" column records the faculty that the department belongs to. There are three different faculties

>>> ASSISTANT:
```r
library(tidyverse)

# Department and faculty assignments
dept_faculty_map <- tribble(
  ~department,    ~faculty,
  'Department 1', 'Faculty of Science',
  'Department 2', 'Faculty of Science',
  'Department 3', 'Faculty of Science',
  'Department 4', 'Faculty of Arts',
  'Department 5', 'Faculty of Arts',
  'Department 6', 'Faculty of Arts',
  'Department 7', 'Faculty of Engineering',
  'Department 8', 'Faculty of Engineering',
  'Department 9', 'Faculty of Engineering',
  'Department 10', 'Faculty of Engineering'
)

# Cross join department and years, and add share column
panel_data <- expand_grid(
  department = dept_faculty_map$department,
  year = 2014:2018
) %>%
  mutate(share = runif(n(), min = 0, max = 1))  # assign random shares between 0 and 1

# Add faculty to the panel data
panel_data <- left_join(panel_data, dept_faculty_map, by = "department")

panel_data
```


>>> USER:
```
Create a graph:
  - Layer 1: 
    - geom: line
    - x: year
    - y: share
    - color: departments in "Faculty of Science" uses different colors that has the same hue and lightness as #FF4C29, but differs in saturation. "Faculty of Arts" uses different colors that has the same hue and lightness as #21FF4C, but differs in saturation. "Faculty of Engineering" uses different colors that has the same hue and lightness as #4C29FF, but differs in saturation.
```

>>> ASSISTANT:
```r
library(ggplot2)

# Define unique colors for each department in the specified faculty
science_colors <- c("#FF4C29", "#FF6A49", "#FF885A", "#FFAB91")
names(science_colors) <- c('Department 1', 'Department 2', 'Department 3')

arts_colors <- c("#21FF4C", "#54FF6E", "#77FF85", "#9CFFA6")
names(arts_colors) <- c('Department 4', 'Department 5', 'Department 6')

engineering_colors <- c("#4C29FF", "#6F4CFF", "#8A71FF", "#A799FF")
names(engineering_colors) <- c('Department 7', 'Department 8', 'Department 9', 'Department 10')

# Combine the color vectors
department_colors <- c(science_colors, arts_colors, engineering_colors)


# Create Line Plot
ggplot(data = panel_data, aes(x = year, y = share, group = department, color = department)) +
  geom_line() +
  scale_color_manual(values = department_colors) +
  labs(title = "Department Shares Over Time", x = "Year", y = "Share", color = "Department") +
  theme_minimal()

```