# Importing necessary libraries
import pandas as pd
import matplotlib.pyplot as plt
import os
from mpl_toolkits.mplot3d import Axes3D

# Setting the directory for saving plots
plot_dir = 'plots'

# Reading the data from csv files
data = pd.read_csv('spb_data.csv', index_col=0)
probabilities = pd.read_csv('spb_probabilities.csv', index_col=0)

# Flag for saving plots
save = False

# Plotting value distributions
for col in data.columns:
    plt.hist(data[col], bins=20, alpha=0.5, label='data')
    plt.xlabel(col)
    plt.ylabel('count')
    if save:
        plt.savefig(os.path.join(plot_dir, 'data_distributions' ,f'{col} data'))
    else:
        plt.show()
    plt.clf()

# Plotting probability distributions
for col in probabilities.columns:
    plt.hist(probabilities[col], bins=20, alpha = 0.5, label='probability')
    plt.xlabel(col)
    plt.legend(loc = 'upper right')
    if save:
        plt.savefig(os.path.join(plot_dir, 'probability_dists', f'{col} probability'))
    else:
        plt.show()
    plt.clf()

# Plotting a 3D scatter plot
fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')
xs = data['distance']
ys = probabilities['joint']
zs = data['age']
ax.scatter(xs, ys, zs, c=ys, cmap='viridis')
ax.set_xlabel('Distance')
ax.set_ylabel('Joint Probability')
ax.set_zlabel('Age')

theta = 0.0
phi = 0.0

# Saving multiple views of the 3D plot
if save:
    for i in range(4):
        theta = i * 30
        for j in range(4):
            phi = j * 30
            ax.view_init(elev=theta, azim=phi)
            plt.savefig(os.path.join(plot_dir, '3d_joint', f'{theta} - {phi} distance v age v joint probability 3d plot'))
plt.show()
plt.clf()

# Plotting a modified 3D scatter plot without random effects
fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')
ys_alt = probabilities['age'] * probabilities ['distance']
ax.scatter(xs, ys_alt, zs, c=ys_alt, cmap='viridis')
ax.set_xlabel('Distance (D)')
ax.set_ylabel('D * A probability')
ax.set_zlabel('Age (A)')

theta = 0.0
phi = 0.0

# Saving multiple views of the modified 3D plot
if save:
    for i in range(4):
        theta = i * 30
        for j in range(4):
            phi = j * 30
            ax.view_init(elev=theta, azim=phi)
            plt.savefig(os.path.join(plot_dir, '3d_no_random', f'{theta} - {phi} distance v age no random'))
plt.show()
plt.clf()