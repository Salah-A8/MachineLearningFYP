library(readr)
library(dplyr)
library(ggplot2)
library(moments)

dataset <- read_csv("C:/Users/Salah/Desktop/MachineLearningFYP/CLEANgames.csv")
summary(dataset)
skewness(dataset$user_reviews)
skewness(dataset$price_original)
skewness(dataset$mean_hours_played)
skewness(dataset$positive_ratio)
skewness(dataset$price_final)

#Log Scaled Distribution of User Reviews
ur <- ggplot(dataset, aes(x = log10(user_reviews + 1))) +
  geom_histogram(binwidth = 0.3, fill = "lightblue", color = "black") +
  facet_wrap(~ simplified_ratings) +
  labs(
    title = "Log Scaled Distribution of User Reviews by Class",
    x = "Log10(User Reviews + 1)",
    y = "Frequency"
  )
ggsave("log_user_reviews.png", plot = ur, width = 6, height = 3.5, dpi = 300)

#Log Scaled Distribution of Mean Hours Played
mhp <- ggplot(dataset, aes(x = log10(mean_hours_played + 1))) +
  geom_histogram(binwidth = 0.2, fill = "lightblue", color = "black") +
  facet_wrap(~ simplified_ratings) +
  labs(
    title = "Log Scaled Distribution of Mean Hours Played by Class",
    x = "Log10(Mean Hours Played + 1)",
    y = "Frequency"
  )
ggsave("log_mean_hours_played.png", plot = mhp, width = 6, height = 2, dpi = 300)

# Log Scaled Distribution of Discounted Price
dp <- ggplot(dataset, aes(x = log10(price_final + 1))) +
  geom_histogram(binwidth = 0.2, fill = "lightblue", color = "black") +
  facet_wrap(~ simplified_ratings) +
  labs(
    title = "Log Scaled Distribution of Discounted Price by Class",
    x = "Log10(Price Final + 1)",
    y = "Frequency"
  )
ggsave("log_price_final.png", plot = dp, width = 6, height = 3.5, dpi = 300)

#Log Scaled Distribution of Original Price
op <- ggplot(dataset, aes(x = log10(price_original + 1))) +
  geom_histogram(binwidth = 0.2, fill = "lightblue", color = "black") +
  facet_wrap(~ simplified_ratings) +
  labs(
    title = "Log Scaled Distribution of Original Price by Class",
    x = "Log10(Price Original + 1)",
    y = "Frequency"
  )
ggsave("log_price_original.png", plot = op, width = 6, height = 3.5, dpi = 300)
