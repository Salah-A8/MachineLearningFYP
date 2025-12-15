library(readr)
library(dplyr)

dataset <- read_csv("C:/Users/Salah/Desktop/MachineLearningFYP/games.csv")
hoursdataset <- read_csv("C:/Users/Salah/Desktop/MachineLearningFYP/recommendations.csv")

dataset$simplified_ratings <- ifelse(dataset$positive_ratio < 40, "-1", ifelse(dataset$positive_ratio > 69, "1", "0"))
dataset <- dataset[, !names(dataset) %in% c("win", "mac", "linux", "discount", "steam_deck")]
write_csv(dataset, "C:/Users/Salah/Desktop/MachineLearningFYP/games_with_simplified_ratings.csv")

mean_hours <- hoursdataset %>%
  group_by(app_id) %>%
  summarise(mean_hours_played = mean(hours, na.rm = TRUE))

merged_dataset <- dataset %>%
  left_join(mean_hours, by = "app_id")

write_csv(merged_dataset, "C:/Users/Salah/Desktop/MachineLearningFYP/games_with_mean_hours.csv")

cleandataset <- merged_dataset %>%
  filter(!is.na(mean_hours_played))

write_csv(cleandataset, "C:/Users/Salah/Desktop/MachineLearningFYP/CLEANgames.csv")
