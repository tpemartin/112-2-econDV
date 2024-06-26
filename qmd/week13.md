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

## 範例程式

```r
election2020 = jsonlite::fromJSON(
  "https://www.dropbox.com/s/a3torx0p41hheb6/presidentElection2020.json?dl=1"
)

mp <- econDV2::Map()
mp$sf$get_sf_taiwan_simplified() -> list_sf_taiwan
list_sf_taiwan$鄉鎮區 -> tw_township


# Calculate support rate based on election2020 data frame -----
library(tidyverse)

# Assuming election2020 is the name of your data frame
election2020 <- election2020 %>%
  mutate(支持率 = if_else(`(2)\n 韓國瑜\n 張善政` > `(3)\n 蔡英文\n 賴清德`, -(`(2)\n 韓國瑜\n 張善政`), `(3)\n 蔡英文\n 賴清德`))

# Showing first 3 rows of the updated data frame
glimpse(election2020 %>% slice_head(n = 3))

# election plot----
tw_township |>
  filter(
    is_in.city == "新北市"
  ) -> sf_newTaipei

sf_newTaipei |>
  left_join(
    election2020,
    by=c("name"="鄉(鎮、市、區)別" )
  ) -> sf_newTaipei

sf_newTaipei |>
  ggplot() +
  geom_sf(
    aes(fill=支持率)
  )

# use colorspace::choose_palette(gui="shiny") to choose a palette
colorspace::diverging_hcl(n = 12, h = c(249, 106), c = 98, l = c(34, 96), power = 1.5, register = "Custom-Palette")

sf_newTaipei |>
  ggplot() +
  geom_sf(
    aes(fill=支持率)
  ) +
  colorspace::scale_fill_continuous_diverging(pal = "Custom-Palette",
                                              mid=0,
                                              limits=c(-1,1))
sf_newTaipei |>
  ggplot() +
  geom_sf(
    aes(fill=支持率)
  ) +
  colorspace::scale_fill_binned_diverging(
    pal="Custom-Palette",
    n.breaks=8,
    limits=c(-1,1)
  )
```