# week 3

- [<span class="toc-section-number">1</span> RStudio cloud:
  POSIT](#rstudio-cloud-posit)
- [<span class="toc-section-number">2</span> Import Python pandas data
  frame](#import-python-pandas-data-frame)
- [<span class="toc-section-number">3</span> ](#section)

## RStudio cloud: POSIT

## Import Python pandas data frame

``` python
import pandas as pd
import pickle

# Create a dictionary with some data
data = {'Name': ['Alice', 'Bob', 'Charlie', 'David'],
        'Age': [25, 30, 35, 40],
        'City': ['New York', 'Los Angeles', 'Chicago', 'Houston']}

# Create a pandas data frame from the dictionary
df = pd.DataFrame(data)

# Save the dataframe to a pickle file
with open('dataframe_pickle.pkl', 'wb') as file:
    pickle.dump(df, file)

print("Data frame saved to 'dataframe_pickle.pkl'")
```

    Data frame saved to 'dataframe_pickle.pkl'

``` r
library(reticulate)
# Load the python object containing pickled data frame
df <- py_load_object("dataframe_pickle.pkl")
```

## 
