import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

# function to calculate the probability of a person being in the target age range
def get_age_prob(age):
    
    if age > 44.99 and age < 46.0:
        return 0.95
    elif age >= 46.0 and age < 50.0:
        return 0.95 - (45 - age) * 0.15
    elif age <= 44.99 and age > 40.0:
        return 0.95 - (45 - age) * 0.15
    else:
        return 0

# setting the random seed to 42 for reproducibility
np.random.seed(42)

# mean age in the US
us_mean_age = 38.9

# number of samples to generate
n_samples = 100000

# generating normally distributed ages around the mean age with a standard deviation of 10
ages = np.random.normal(loc=us_mean_age, scale=10, size=n_samples)

# generating distances from the target location with a normal distribution and clipping the values to be between -500 and 500
distance = np.abs(np.clip(np.random.normal(loc=0, scale=100, size=n_samples), -500, 500))

# initializing labels to be all zeros
labels = np.zeros(n_samples)

# creating a pandas dataframe with columns for age, distance, and label
data = pd.DataFrame({'age': ages, 'distance': distance, 'label': labels})

# calculating the probability of a person being in the target distance range
dist_probabilites = data['distance'].apply(lambda x: x/200 if x > 0 else 1.1)

# calculating the probability of a person being in the target age range
age_probabilities = data['age'].apply(get_age_prob)

# calculating the joint probability of a person being in both the target age and distance ranges
joint_probabilities = dist_probabilites * age_probabilities

# capping the joint probabilities at 1
joint_probabilities.loc[joint_probabilities > 1] = 1

# generating labels based on the joint probabilities using a binomial distribution
data['label'] = np.random.binomial(n=1, p=joint_probabilities) 

data.to_csv('space_pirate_bonneroni.csv', index=True)