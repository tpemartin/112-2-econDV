# ggdash

<https://tpemartin.github.io/economic-data-visualization-2022/geometries-and-aesthetics.html#econdv2ggdash>

在適當位置進行`#input$....` comment來產生互動式的dashboard以調整圖表。

code
```r
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

```

# 北台灣2020總統大學面量圖

```r
election2020 = jsonlite::fromJSON(
  "https://www.dropbox.com/s/a3torx0p41hheb6/presidentElection2020.json?dl=1"
)

mp <- econDV2::Map()
mp$sf$get_sf_taiwan_simplified() -> list_sf_taiwan
list_sf_taiwan$鄉鎮區 -> tw_township
```

  - 各縣市以當選候選人得票率為顏色深淺，以面量圖呈現。