
# Load the ggplot2 library
library(ggplot2)

# Read in the CSV file as a dataframe
data <- read.csv("Byblis.csv")

# plot the entire data distruted

total_plot <- ggplot(data, aes(x = germination_prop)) +
    geom_histogram(binwidth = 0.05) +
    labs(title = "Histogram of Germination Prop for All Data") +
    scale_x_continuous(limits = c(0, 1))

ggsave(paste0( "plots/", "over_dist/", "Overall Data.png"))



# Get unique values of fire_temp
fire_temps <- unique(data$fire_temp)

# Loop through each unique fire_temp value
for (i in fire_temps) {
    # Create a histogram plot for germination_prop values for each fire_temp value
    fire_plot <- ggplot(data[data$fire_temp == i, ], aes(x = germination_prop)) +
        geom_histogram(binwidth = 0.05) +
        labs(title = paste("Histogram of germination_prop for fire_temp = ", i)) +
        scale_x_continuous(limits = c(0, 1))

    # Save the plot as an image file
    ggsave(paste0("plots/", "indi_dist/", 'Fire Temp = ', i, '.png'))
}

# Get unique values of pH_level
pH_values <- unique(data$pH_level)

# Loop through each unique pH_level value
for (i in pH_values) {
    # Create a histogram plot for germination_prop values for each pH_level value
    pH_plot <- ggplot(data[data$pH_level == i, ], aes(x = germination_prop)) +
        geom_histogram(binwidth = 0.05) +
        labs(title = paste("Histogram of germination_prop for fire timp = ", i)) +
        scale_x_continuous(limits = c(0, 1))

    # Save the plot as an image file
    ggsave(paste0("plots/", "indi_dist/", 'pH = ', i, '.png'))
}

# Get unique combinations of pH_level and fire_temp
unique_combinations <- data.frame(unique(data[c("pH_level", "fire_temp")]))

# Loop through each unique combination
for (i in 1:nrow(unique_combinations)) {
    # Subset the data based on the current combination
    subset <- data[(data$pH_level == unique_combinations[i,1]),]
    subset <- na.omit(subset[(data$fire_temp == unique_combinations[i,2]),])
    
    # Create a histogram plot for germination_prop values for the current combination
    combo_plot <- ggplot(subset, aes(x = germination_prop)) +
        geom_histogram(binwidth = 0.05) +
        labs(title = paste("Histogram of germination_prop for ph = ", 
            unique_combinations[i,1], 
            "and fire_temp = ", 
            unique_combinations[i,2])) +
        scale_x_continuous(limits = c(0,1))

    # Save the plot as an image file
    ggsave(paste0("plots/", "indi_dist/", 
        "ph = ", unique_combinations[i,1],
        " fire_temp = ", unique_combinations[i,2], '.png'))
}
