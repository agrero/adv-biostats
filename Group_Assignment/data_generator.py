import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

# function to calculate the probability of a person being in the target age range
def get_age_prob(age, mean=45, mean_prob=0.95, decay=0.15):
    """
    Calculates the probability of a person being selected for a study based on their age.

    Args:
        age (int): The age of the person.
        mean (int, optional): The mean age of the population. Defaults to 45.
        mean_prob (float, optional): The probability of a person being selected when their age is equal to the mean age. Defaults to 0.95.
        decay (float, optional): The rate at which the probability decreases as the age deviates from the mean age. Defaults to 0.15.

    Returns:
        float: The probability of the person being selected for the study.
    """
    return mean_prob - (mean - age) * decay

import numpy as np

def get_random_proability(data, minimum=-1.0, maximum=1.0):
    """
    Returns a random probability value between the specified minimum and maximum values.

    Parameters:
    data (array-like): The data to generate the probability for.
    minimum (float): The minimum value of the probability (default -1.0).
    maximum (float): The maximum value of the probability (default 1.0).

    Returns:
    float: A random probability value between the specified minimum and maximum values.
    """
    return np.random.uniform(minimum, maximum)

# setting the random seed to 42 for reproducibility
np.random.seed(42)

# mean age in the US
us_mean_age = 38.9

# number of samples to generate
n_samples = 10000

data = pd.DataFrame()

# generating normally distributed ages around the mean age with a standard deviation of 10
data['age'] = np.random.normal(loc=us_mean_age, scale=10, size=n_samples)

# generating distances from the target location with a normal distribution and clipping the values to be between -500 and 500
data['distance'] = np.abs(np.clip(np.random.normal(loc=0, scale=100, size=n_samples), -500, 500))

# generating urban not urban as 1 and 0 respectively
data['urban'] = np.random.randint(0, 2, len(data))

# initializing labels to be all zeros
data['infection'] = np.zeros(n_samples)

# generate probabilities dataframe
probabilities = pd.DataFrame()

# flip this
probabilities['distance'] = data['distance'].apply(lambda x: x/200 if x > 0 else 1.1)
# flip this

probabilities['age'] = data['age'].apply(lambda x: get_age_prob(x, mean = 45, mean_prob = 0.8, decay = 0.10))
probabilities['urban'] = data['urban'].apply(get_random_proability)

# calculate joint probability
probabilities['joint'] = probabilities['distance'] * probabilities['age'] + probabilities['urban']

# minmax filter the data in probabilities['joint'] from 0 to 1
probabilities['joint'] = (probabilities['joint'] - probabilities['joint'].min()) / (probabilities['joint'].max() - probabilities['joint'].min())

# generating labels based on the joint probabilities using a binomial distribution
data['infection'] = np.random.binomial(n=1, p=probabilities['joint']) 

save = False
if save:
    data.to_csv('spb_data.csv', index=True)
    probabilities.to_csv('spb_probabilities.csv', index=True)
