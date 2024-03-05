# week 3

- [<span class="toc-section-number">1</span> Package installation
  errors](#package-installation-errors)
- [<span class="toc-section-number">2</span> AI and RStudio cloud
  (POSIT)](#ai-and-rstudio-cloud-posit)
- [<span class="toc-section-number">3</span> Python in
  POSIT](#python-in-posit)
- [<span class="toc-section-number">4</span> Import Python pandas data
  frame](#import-python-pandas-data-frame)
  - [<span class="toc-section-number">4.1</span> R
    reticulate](#r-reticulate)
  - [<span class="toc-section-number">4.2</span> Create a data frame
    example in Python](#create-a-data-frame-example-in-python)
- [<span class="toc-section-number">5</span> ](#section)

## Package installation errors

Disable `.Rprofile` first.

## AI and RStudio cloud (POSIT)

<https://github.com/tpemartin/112-2-R-EE/blob/main/Lecture%20notes/week2-session1.md>

## Python in POSIT

<https://support.posit.co/hc/en-us/articles/360023654474-Installing-and-Configuring-Python-with-Posit>

## Import Python pandas data frame

### R reticulate

R use `reticulate` package to communicate with Python interpreter.

``` r
installed.packages("reticulate")
```

         Package LibPath Version Priority Depends Imports LinkingTo Suggests
         Enhances License License_is_FOSS License_restricts_use OS_type Archs
         MD5sum NeedsCompilation Built

### Create a data frame example in Python

Suppose you already has used Python before.

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

Import the data frame

``` r
library(reticulate)
# Load the python object containing pickled data frame
df <- py_load_object("dataframe_pickle.pkl")
```

## 
