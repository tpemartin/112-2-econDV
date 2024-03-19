# Bar chart

## Claude AI

當ChatGPT-3.5不能滿足你，你又沒有GPT-4可用，你可以使用Claude AI來生成範例圖表。

![](../img/2024-03-19-08-04-18.png)

## 基本圖型

- <https://www.economist.com/graphic-detail/2024/02/12/the-economists-cost-of-loving-index>

### Key concept: (AI)請AI描述再生成範例程式

AI> (Claude page mode)
```
describe the graph here
```

AI> (Claude page mode)
```
所有回答使用到程式時一律使用R, 並盡量使用tidyverse語法, 程式產生的最終結果儘量收錄在環境中已有的list物件results中，答案以R script呈現
```
## X軸為unordered factor

### Key concept: X軸為unordered factor時，bar chart的順序要注意

> 必需依照Y軸的值排序

- `reorder(cities, cost)`

## fill美學的位置

- Dodge (default，躲避)
- Stack（堆叠）
- Fill (填滿100%)

### Key concept: (AI)善用AI生成範例圖表

AI> 
```
Follow the grammar of graphics:
- Layer 1:
  - geom: bar
  - aesthetics:
    - x: category from 1 to 4
    - y: value
    - fill: category from A to C

給我示範dodge, stack, fill三種positions的範例程式
```

## Vision AI 

![](../img/2024-03-19-13-02-40.png)

- <https://platform.openai.com/docs/guides/vision>

### Use Vision AI in RStudio

#### Setup Python in RStudio
To create a Python environment with a specific interpreter path using Conda through the `reticulate` package in RStudio, you can follow these steps:

1. **Install the 'reticulate' Package**: If you haven't already installed the `reticulate` package, you can do so by running the following command in RStudio:

```R
install.packages("reticulate")
```

2. **Load the 'reticulate' Package**: After installation, load the `reticulate` package into your R session:

```R
library(reticulate)
```

3. **Create a Conda Environment with Specific Interpreter Path**: You can create a Conda environment with a specific Python interpreter path using the `conda_create()` function. Pass the path to the interpreter using the `python` argument. For example:

```R
conda_create(envname = "my_env", python = "/path/to/python/interpreter")
```

Replace `"/path/to/python/interpreter"` with the actual path to your Python interpreter.

4. **Activate the Conda Environment**: Once the environment is created, you need to activate it. This can be done using the `use_condaenv()` function from `reticulate`.

```R
use_condaenv("my_env", required = TRUE)
```

Replace `"my_env"` with the name of your Conda environment.

5. **Verify Environment Activation**: You can check if the environment is activated by running the following command:

```R
conda_list()
```

This will list the packages installed in the currently active environment.

6. **Use Python Code**: Now you can use Python code within RStudio, and it will use the specific interpreter path you specified when creating the environment.

By following these steps, you can create a Python environment with a specific interpreter path and use it within RStudio seamlessly using the `reticulate` package.

#### Pip install in RStudio

```R
reticulate::py_install("openai", pip=T)
```

#### Image description

```python
from openai import OpenAI

client = OpenAI(api_key = "...")

response = client.chat.completions.create(
  model="gpt-4-vision-preview",
  messages=[
    {
      "role": "user",
      "content": [
        {"type": "text", "text": "What’s in this image?"},
        {
          "type": "image_url",
          "image_url": {
            "url": "https://www.economist.com/cdn-cgi/image/width=360,quality=80,format=auto/content-assets/images/20240323_EPC824.png"
            },
        },
      ],
    }
  ],
  max_tokens=300,
)

print(response.choices[0])
```

#### Description Created Graph Example

AI>
```
Create an example dataframe with graphing codes that can generate a graph fitting the description: 'The image shows a bar chart titled "That rich taste," which presents data on worldwide market capitalization of selected categories of generative-AI businesses, in billion dollars ($bn). The chart compares the market capitalization on two dates: October 1st, 2022, and March 15th, 2024.\n\nThere are four categories listed:\n\n1. Cloud-computing companies\n2. Hardware companies\n3. Software applications\n4. Modelmakers\n\nFor each category, there are two bars indicating the market capitalization on the two respective dates, showing growth or changes between the two dates. The chart also includes a footnote which states, "Most recent funding round before the release of ChatGPT," indicating that the asterisk next to the 0.03 figure for Modelmakers refers to the most recent funding round before ChatGPT\'s release.\n\nOn the right-hand side of the chart, there are numbers indicating the number of companies surveyed in each category:\n\n- Cloud-computing companies: 3\n- Hardware companies: 27\n- Software applications: 19\n- Modelmakers: 11\n\nThe sources for the data are listed as Bloomberg, PitchBook, news reports, company reports, and The Economist.'
```