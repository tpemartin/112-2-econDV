library(ggplot2)
library(tidyverse)

# Create some sample data
data <- data.frame(
  x = c(1, 2, 3, 4, 5),
  y = c(10, 15, 13, 17, 20)
)

# Create the plot
plot <- ggplot(data, aes(x = x, y = y)) +
  geom_point(
    size = 1, #input$size
    color= "red" #input$color
  ) +
  labs(
    title = "Example Point Plot",
    subtitle = "This is a subtitle",
    caption = "Footer text"
  ) +
  theme(
    plot.caption = element_text(size = 12 #input$footer
    ),
    plot.title =  element_text(size=13 #input$title
    ))  

# Display the plot
print(plot)

