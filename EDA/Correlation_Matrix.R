library(ggplot2)
library(reshape2)
library(readr)

dataset <- read_csv("C:/Users/Salah/Desktop/MachineLearningFYP/CLEANgames.csv")
dataset_correlation <- dataset[, c("user_reviews", "price_final", "mean_hours_played", "simplified_ratings")]
correlation_matrix <- cor(dataset_correlation, method= "spearman")
melted_correlation <- melt(correlation_matrix)
  
heatmap_plot <- ggplot(data = melted_correlation, aes(x = Var1, y = Var2, fill = value)) +
  geom_tile() +
  scale_fill_gradient2(low = "blue", high = "red", mid = "white", midpoint = 0) +
  geom_text(aes(label = round(value, 2)), color = "black", size = 4) +
  labs(title = "Spearman Correlation Heatmap") 

heatmap_plot

ggsave("correlation_heatmap.png", plot = heatmap_plot, width = 7, height = 3.5, dpi = 300)
