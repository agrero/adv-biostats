library(dplyr)
library(ggplot2)

space_pirate_bonneroni <- read.csv("space_pirate_bonneroni.csv")

min_age <- 0
max_age <- max(space_pirate_bonneroni$age)
max_age <- as.integer(max_age)

inf_age_vector <- vector("numeric", length = max_age - min_age + 1)
non_inf_age_vector <- vector("numeric", length = max_age - min_age + 1)
age_range_vec <- vector("numeric", length = max_age - min_age + 1)

for (i in min_age:max_age) {
        filtered_data <- space_pirate_bonneroni %>%
                filter(age > i - 2  & age < i + 2)
        # Sum the number of rows with a label value of 1 in filtered_data
        num_label_1 <- sum(filtered_data$label == 1)
        num_label_0 <- sum(filtered_data$label == 0)

        inf_age_vector[i] <- num_label_1
        non_inf_age_vector[i] <- num_label_0
}

age_range_vec <- min_age:max_age

inf_age_df <- data.frame(age_range_vec, inf_age_vector)
non_inf_age_df <- data.frame(age_range_vec, non_inf_age_vector)

# plot the (non) infected ages as a distribution histogram
infected_age_dist <-barplot(inf_age_df$inf_age_vector,
     names.arg = inf_age_df$age_range_vec,
     col = "red", 
     xlab = "Age", 
     ylab = "Number of Infected People", 
     main = "Histogram of Infected People by Age")

non_infected_age_dist <- barplot(non_inf_age_df$non_inf_age_vector,
     names.arg = non_inf_age_df$age_range_vec,
     col = "blue", 
     xlab = "Age", 
     ylab = "Number of Non-Infected People", 
     main = "Histogram of Non-Infected People by Age")

# comparing the distribution of values of infected/non-infected people
infected <- space_pirate_bonneroni %>%
        filter(label == 1)

non_infected <- space_pirate_bonneroni %>%
    filter(label == 0)

lm_all <- lm(distance ~ age, data = space_pirate_bonneroni)

lm_infected <- lm(distance ~ age, data = infected)
lm_non_infected <- lm(distance ~ age, data = non_infected)

# Scatterplot for all data
all_data_plot <- plot(x = space_pirate_bonneroni$age, 
                      y = space_pirate_bonneroni$distance,
                      xlab = "Age", 
                      ylab = "Distance", 
                      main = "Scatterplot of Distance vs Age for All Data")


# Scatterplot for infected data
infected_plot <- plot(x = infected$age, 
                      y = infected$distance,
                      xlab = "Age", 
                      ylab = "Distance", 
                      main = "Scatterplot of Distance vs Age for All Data")

# Scatterplot for non-infected data
infected_plot <- plot(x = non_infected$age, 
                      y = non_infected$distance,
                      xlab = "Age", 
                      ylab = "Distance", 
                      main = "Scatterplot of Distance vs Age for All Data")

