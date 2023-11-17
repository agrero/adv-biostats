

import pandas as pd
import matplotlib.pyplot as plt

# read in the csv file
probs = pd.read_csv('r_probability.csv', index_col=0)
data = pd.read_csv('r_data.csv', index_col=0)

# plot both distance columns in probs
x = data['distance']
y = probs['distance']

plt.plot(x, y)


plt.show()
