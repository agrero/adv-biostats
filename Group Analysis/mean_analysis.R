# Load the ggplot2 library
library(ggplot2)
library(MASS)

# Read in the CSV file as a dataframe
data <- read.csv("Byblis.csv")

# Calculate the germination_prop mean for each unique combination
mean_germination_prop <- aggregate(germination_prop ~ pH_level + fire_temp, data, mean)
sd_germination_prop <- aggregate(germination_prop ~ pH_level + fire_temp, data, sd)

# Add the 'sd' column from sd_germination_prop to mean_germination_prop
mean_germination_prop$sd <- sd_germination_prop$germination_prop

# Rename the column to 'sd'
colnames(mean_germination_prop)[colnames(mean_germination_prop) == "sd"] <- "sd"

# Plot the values for each pH_level with error bars
plot <- ggplot()
count <- 1
for (i in unique(mean_germination_prop$pH_level)) {
    # Print the pH_level
    print(i)
    
    # Print the subset of mean_germination_prop for the current pH_level
    print(mean_germination_prop[mean_germination_prop$pH_level == i,])
    
    # Add points to the plot for the current pH_level
    plot <- plot + geom_point(data = mean_germination_prop[mean_germination_prop$pH_level == i,], 
                              aes(x = fire_temp, y = germination_prop),
                              color = c("red", "blue")[count]) +
            
            # Add error bars to the plot for the current pH_level
            geom_errorbar(data = mean_germination_prop[mean_germination_prop$pH_level == i,],
                          aes(x = fire_temp, ymin = (germination_prop - sd), ymax = (germination_prop + sd)),
                          width = 0.2,
                          color = c("red", "blue")[count])
    count <- count + 1
}

# Display the plot
ggsave(paste("plots/over_dist/", "mean_germination_plot.png"))

# making gaussian fits 

plot <- ggplot()


n <- 100

new_data <- data.frame(matrix(0, nrow = n, ncol = nrow(mean_germination_prop)))
x <- seq(0, 1, length.out = n)


legend_labels <- paste("pH:", mean_germination_prop$pH_level, "Fire:", mean_germination_prop$fire_temp)
# use these legned labels to make a new_data a mxm matrix that each column is updated within the loop
# kind like how you've done the old stuff


colors <- c("red", "blue", "green", "purple", "orange", "pink")

for (i in 1:nrow(mean_germination_prop)) {
    ph <- mean_germination_prop$pH_level[i]
    fire <- mean_germination_prop$fire_temp[i]

    subset <- data[(data$pH_level == ph) & (data$fire_temp == fire),]

    fit <- fitdistr(subset$germination_prop, "normal")

    y <- dnorm(x, mean = fit$estimate[1], sd = fit$estimate[2])
    new_data[, i] <- y

}

plot <- ggplot(data = new_data, aes(x = x)) +
        geom_line(aes(y = X1), color = "red", ) +
        geom_line(aes(y = X2), color = "blue") +
        geom_line(aes(y = X3), color = "green") +
        geom_line(aes(y = X4), color = "purple") +
        geom_line(aes(y = X5), color = "orange") +
        geom_line(aes(y = X6), color = "pink") +

        scale_color_manual(values = c("X1" = "red", "X2" = "blue", "X3" = "green",
                                      "X4" = "purple", "X5" = "orange", "X6" = "pink"),
                                      labels = c("X1" = legend_labels[1], "X2" = legend_labels[2], "X3" = legend_labels[3],
                                      "X4" = legend_labels[4], "X5" = legend_labels[5], "X6" = legend_labels[6])) +
                            
        guides(color = guide_legend(title = "Legend")) +
        labs(x = "Germination Prop", 
            y = "Density", 
            title = "Germination Prop Fit") 


ggsave(paste("plots/over_dist", "gaussian-fit.png"))

