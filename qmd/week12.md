
# OSM

AI》
使用瀏覽器拜訪OpenStreetMap並以台灣中心點為中心

## 捷運 Simple Feature

AI》
```
Query from OpenStreetMap the following data:
bbox: 121.1353, 25.3925, 122.0224, 24.8503
railway=subway
```

```r
# Define the bounding box
bbox <- c(121.1353, 25.3925, 122.0224, 24.8503)

# Construct the query
query <- opq(bbox = bbox, timeout=60) %>%
  add_osm_feature(key = "railway", value = "subway") 

osm_data2 <- osmdata_sf(query)

mrt_lines <- osm_data2$osm_lines
```

## 疊層

### Simple Feature

AI》
```
Query from OpenStreetMap the following data:
bbox: 121.1353, 25.3925, 122.0224, 24.8503
admin_level=4
boundary=administrative
```

```r
# Querying data from OpenStreetMap -----
library(tidyverse)
library(osmdata)

# Define the bounding box
bbox <- c(121.1353, 25.3925, 122.0224, 24.8503)

# Construct the query
query <- opq(bbox = bbox, timeout=60) %>%
  add_osm_feature(key = "admin_level", value = "4") %>%
  add_osm_feature(key = "boundary", value = "administrative")

# Get the data
osm_data <- osmdata_sf(query)

# Preview the data
glimpse(osm_data)

northTW <- osm_data$osm_multipolygons

northTW |>
  filter(!(name %in% c("新竹縣","宜蘭縣"))) -> northTW
```

### 圖磚raster data

<https://tpemartin.github.io/economic-data-visualization/zh-tw/annotation-and-maps.html#google-map>

[ggmap](https://github.com/dkahle/ggmap)
