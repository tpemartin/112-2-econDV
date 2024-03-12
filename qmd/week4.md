
## 如何使用AI協助資料視覺化

### System promt (preset)

所有回答使用到程式時一律使用R, 繪圖一律使用ggplot2，並盡量使用tidyverse的語法。

### 描述圖形

請產生一個資料框，並畫出以下圖形：

圖形描述： 
 - 幾何：折線圖
 - 美學：
   - x 軸: 日期（月資料從1960年1月到1962年2月）
   - y 軸: 對台幣匯率升值率
   - 顏色: 不同國家，分別是"美元", "日元", "英鎊"

*** 

我們來創建一個假數據的資料框，假定對台幣匯率升值率為隨機的數字。

產生資料框：

```r
# 載入需要的套件
library(tidyverse)

# 產生日期序列
date <- seq(as.Date("1960/01/01"), as.Date("1962/02/28"), by = "month")

# 製作資料框
df <- data.frame(
  date = rep(date, 3),
  appreciation_rate = runif(length(date)*3, -1, 1),  # 隨機產生升值率
  country = rep(c("美元", "日元", "英鎊"), each = length(date))
)

# 確認資料
head(df)
```

繪製折線圖：

```r
# 繪製折線圖
ggplot(df, aes(x = date, y = appreciation_rate, color = country)) +
  geom_line() +
  labs(x = "日期", y = "對台幣匯率升值率", color = "國家") +
  theme_minimal()
```

如果你要用實際的匯率數據繪圖，你需要有保存這些數據的CSV或其他格式的檔案。 你可以用 `read.csv()` 函數來讀取數據，然後用相似的代碼來繪製匯率折線圖。 對於實際的數據，可能需要一些清理和設定日期欄位的適當格式。



### 檢視資料框架構

請使用 `head()` 函數檢視資料框的前幾筆資料。

```r
dplyr::glimpse(df)
```

### 實作練習

[我國與主要貿易對手通貨對美元之匯率依期間](https://cpx.cbc.gov.tw/Range/RangeSelect?pxfilename=BP01M01.px)

```r
library(readr)
exchangeRate <- read_csv("~/Downloads/BP01M01.csv")
dplyr::glimpse(exchangeRate)
```

#### 將資料框修改成如`df`的格式


##### 轉換日期格式

`exchangeRate$期間`內容如下：

  - character class
  - 前幾筆內容："1960M01", "1960M02", "1960M03", "1960M04", "1960M05", "1960M06", 其中"M"代表月份
  
請將`exchangeRate$期間`轉換成日期格式

***

```r
# 假设exchangeRate是您的数据框或列表，包含日期字符串的列名为日期
exchangeRate$期間 <- as.Date(paste0(exchangeRate$期間, "01"), format = "%YM%m%d")
```

##### 計算NTD對其他幣別的匯率

`exchangeRate`裡有以下欄位，  
  - "新台幣NTD/USD", "日圓JPY/USD", "英鎊USD/GBP", "港幣HKD/USD", "韓元KRW/USD"  
欄名稱中的英文"xxx/yyy"分別代表xxx對yyy的匯率，例如"NTD/USD"為1 USD可以兌換多少NTD，將其他幣別的匯率轉換成對NTD對它的匯率。

***

如果你想將所有的匯率轉換為對新台幣(NTD)的匯率，你需要首先獲得每種貨幣對美元(USD)的匯率，然後將它們除以新台幣對美元的匯率。

我們可以使用dplyr套件來達到這個目的。以下是在R中的範例：

```R
library(dplyr)

# 計算新台幣對美元的匯率
ntd_usd_rate <- exchangeRate$`新台幣NTD/USD`

# 計算其他貨幣的匯率，對新台幣的匯率，並儲存到新的欄位
exchangeRate <- exchangeRate %>%
  mutate(`日圓NTD/JPY` = ntd_usd_rate / `日圓JPY/USD`,
         `英鎊NTD/GBP` = ntd_usd_rate / (1/`英鎊USD/GBP`),
         `港幣NTD/HKD` = ntd_usd_rate / `港幣HKD/USD`,
         `韓元NTD/KRW` = ntd_usd_rate / `韓元KRW/USD`)
```

在這段程式碼中，我們分別計算每種幣別對新台幣的匯率。計算的公式是新台幣對美元的匯率除以該幣別對美元的匯率。特別注意在處理英鎊匯率時需要先取倒數，才能變成"GBP/USD"的形式。結果存入了名為"幣別NTD/貨幣"的新欄位。

##### 計算升值率

##### 改成長格式


##### 完整程式碼

```r
# 範例資料框 ----

# 匯入使用的套件
library(tidyverse)
library(lubridate)

# 建立資料框
exchange_rate <- tibble(
  date = rep(seq(as.Date("1960-01-01"), as.Date("1962-02-01"), by = "months"), 3),
  country = rep(c("美元", "日元", "英鎊"), each = 26),
  rate = runif(78, 20, 40)
)

# 計算匯率升值率 
exchange_rate <- exchange_rate %>%
  arrange(country, date) %>%
  group_by(country) %>%
  mutate(rise_rate = (rate - lag(rate)) / lag(rate))

head(exchange_rate)

# 計算匯率升值率 
exchange_rate <- exchange_rate %>%
  arrange(country, date) %>%
  group_by(country) %>%
  mutate(rise_rate = (rate - lag(rate)) / lag(rate))

# 濾出時間範圍內且國家為"美元", "日元", "英鎊" 的資料並繪圖
exchangeRateExample <- exchange_rate %>%
  filter(year(date) >= 1960 & year(date) <= 1962,
         month(date) >= 1 & month(date) <= 2,
         country %in% c("美元", "日元", "英鎊")) 


# 範例圖型 ------

exchangeRateExample %>%
  ggplot(aes(x = date, y = rise_rate, color = country)) +
  geom_line() +
  labs(x = "日期（1960年1月到1962年2月）",
       y = "對台幣匯率升值率", 
       color = "國家") +
  theme_minimal()

# 引入資料 ----
library(readr)
exchangeRate <- read_csv("BP01M01.csv")
View(exchangeRate)

## 轉換日期格式 ------
exchangeRate <- exchangeRate %>%
  tidyr::separate(期間, into = c("year", "month"), sep = "M", remove = FALSE) %>%
  mutate(date = as.Date(paste(year, month, "01", sep = "-"), format = "%Y-%m-%d"))

## 以台幣為準的匯率 -----
library(dplyr)

# 計算新台幣對美元的匯率
ntd_usd_rate <- exchangeRate$`新台幣NTD/USD`

# 計算其他貨幣的匯率，對新台幣的匯率，並儲存到新的欄位
exchangeRate <- exchangeRate %>%
  mutate(`日圓` = ntd_usd_rate / `日圓JPY/USD`,
         `英鎊` = ntd_usd_rate / (1/`英鎊USD/GBP`),
         `港幣` = ntd_usd_rate / `港幣HKD/USD`,
         `韓元` = ntd_usd_rate / `韓元KRW/USD`,
         `美元` = `新台幣NTD/USD`) %>%
  select(date, `日圓`:`美元`)


## 計算匯率成長率 -----
exchangeRate <- exchangeRate %>%
  arrange(date) %>%
  mutate(across(c("美元", "日圓", "英鎊", "港幣", "韓元"), 
                ~( . - lag(.) ) / lag(.), 
                .names = "成長率_{.col}"))

## 改成長格式 -----

exchangeRate <- exchangeRate %>% 
  pivot_longer(cols = starts_with("成長率"),
               names_to = "country",
               values_to = "升值率")

## 作圖 ------

exchangeRate %>%
  ggplot(aes(x = date, y = 升值率, color = country)) +
  geom_line() +
  labs(x = "日期（1960年1月到1962年2月）",
       y = "對台幣匯率升值率", 
       color = "國家") +
  theme_minimal()
```