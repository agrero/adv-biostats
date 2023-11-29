# Load the ggplot2 library
library(ggplot2)

# Read in the CSV file as a dataframe
data <- read.csv("Byblis.csv")

# Calculate the germination_prop mean for each unique combination
mean_germination_prop <- aggregate(germination_prop ~ pH_level + fire_temp, data, mean)
sd_germination_prop <- aggregate(germination_prop ~ pH_level + fire_temp, data, sd)
print(sd_germination_prop)
# Plot the values for each pH_level
plot <- ggplot()
count <- 1
for (i in unique(mean_germination_prop$pH_level)) {
    print(i)
    print(mean_germination_prop[mean_germination_prop$pH_level == i,])
    plot <- plot + geom_point(data = mean_germination_prop[mean_germination_prop$pH_level == i,], 
                              aes(x = fire_temp, y = germination_prop),
                              color = c("red", "blue")[count]) +
            geom_line(data = mean_germination_prop[mean_germination_prop$pH_level == i,],
                      aes(x = fire_temp, y = germination_prop),
                      color = c("red", "blue")[count])

    count <- count + 1
 
}


# Display the plot
ggsave("mean_germination_plot.png")



