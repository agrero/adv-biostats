
# Read in the CSV file as a dataframe
data <- read.csv("byblis.csv")

fire_temps <- unique(data$fire_temp)

# General for loop
for (i in fire_temps) {
    # Histogram of germination_prop values for each value of i
    hist(data$germination_prop[data$fire_temp == i], main = paste("Histogram of germination_prop for fire_temp =", i))
}