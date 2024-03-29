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
