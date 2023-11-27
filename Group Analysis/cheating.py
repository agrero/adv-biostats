import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import MinMaxScaler
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense

# Read the data
byblis_data = pd.read_csv('Byblis.csv', index_col=False)
byblis_data.drop(['germination_success'], axis=1, inplace=True)

byblis_data = pd.get_dummies(byblis_data, ['fire_temp', 'pH_level'])
print(byblis_data.head())


# Split the data into input features (X) and target variable (y)
X = byblis_data.drop('germination_prop', axis=1)
y = byblis_data['germination_prop']

# Normalize the input features
scaler = MinMaxScaler()
X_scaled = scaler.fit_transform(X)

# Split the data into training and testing sets
X_train, X_test, y_train, y_test = train_test_split(X_scaled, y, test_size=0.2, random_state=42)

# Create the neural network model
model = Sequential()
model.add(Dense(64, activation='relu', input_shape=(X_train.shape[1],)))
model.add(Dense(32, activation='relu'))
model.add(Dense(1))

# Compile the model
model.compile(loss='mean_squared_error', optimizer='adam')

# Train the model
model.fit(X_train, y_train, epochs=10, batch_size=32, verbose=1)

# Evaluate the model
loss = model.evaluate(X_test, y_test)
print('Test Loss:', loss)
