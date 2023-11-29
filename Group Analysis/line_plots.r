
# Load the ggplot2 library
library(ggplot2)

# Read in the CSV file as a dataframe
data <- read.csv("Byblis.csv")

unique_combinations <- data.frame(unique(data[c("pH_level", "fire_temp")]))

plot_data <- data.frame()
sub_rows <- 0

num_bins <- 30
combination_list <- c()  # Initialize an empty list

for (i in 1:nrow(unique_combinations)) {
    # Combine the columns into a single string
    combination <- paste(unique_combinations[i, "pH_level"], unique_combinations[i, "fire_temp"], sep = "-")
    
    # Subset the data based on the current combination
    subset <- data[(data$pH_level == unique_combinations[i,1]),]
    subset <- na.omit(subset[(data$fire_temp == unique_combinations[i,2]),])
    sub_rows <- sub_rows + nrow(subset)
    hist_result <- hist(subset$germination_prop, 
                        breaks = num_bins, 
                        plot = FALSE)

    bin_counts <- hist_result$counts
    bin_mids <- hist_result$mids

    plot_data <- rbind(plot_data, data.frame(germination_prop = bin_mids, 
                                             Count = bin_counts, 
                                             Group = combination))
}



means <- aggregate(Count ~ Group, data = plot_data, FUN = mean)

plot <- ggplot(data = plot_data, 
                aes(x = germination_prop, y = Count, color = as.factor(Group))) +
    geom_line() +
    geom_point()



ggsave(paste0("plots/over_dist/", "smoothed-germination_prop_distribution-all_pH_&_fire.png"))
