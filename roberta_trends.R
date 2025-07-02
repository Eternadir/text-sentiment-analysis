library(dplyr)
library(ggplot2)

# Load your dataset
reviews_df <- read.csv("Soulsborne_reviews.csv", stringsAsFactors = FALSE)

# Date conversion
reviews_df$Release_Date <- as.Date(reviews_df$Release_Date, format = "%m/%d/%Y")
reviews_df$Date_of_Review <- as.Date(reviews_df$Date_of_Review, format = "%m/%d/%Y")

# Days since release
reviews_df$Days_Since_Release <- as.numeric(
  difftime(reviews_df$Date_of_Review, reviews_df$Release_Date, units = "days")
)

# Define time windows
reviews_df$Time_Window <- cut(
  reviews_df$Days_Since_Release,
  breaks = c(-Inf, 30, 92, 365, 731, Inf),
  labels = c("0-30 days", "31-92 days", "93-365 days", "366-731 days", ">732 days")
)

# Order factor levels
reviews_df$Time_Window <- factor(
  reviews_df$Time_Window,
  levels = c("0-30 days", "31-92 days", "93-365 days", "366-731 days", ">732 days")
)

# Keep only RoBERTa sentiment
score <- "RoBERTa_Sentiment_Score"
games <- unique(reviews_df$Video_Game)

# Open a PDF to store plots
pdf("roberta_sentiment_trends.pdf", width = 9, height = 6)

for (game in games) {
  game_data <- filter(reviews_df, Video_Game == game)
  
  # Group by time window and calculate mean and SE
  summary_df <- game_data %>%
    group_by(Time_Window) %>%
    summarise(
      Mean = mean(get(score), na.rm = TRUE),
      SE = sd(get(score), na.rm = TRUE) / sqrt(sum(!is.na(get(score))))
    ) %>%
    filter(!is.na(Time_Window))
  
  # Plot
  plot <- ggplot(summary_df, aes(x = Time_Window, y = Mean)) +
    geom_col(fill = "darkred", alpha = 0.7) +
    geom_errorbar(aes(ymin = Mean - SE, ymax = Mean + SE), width = 0.2, color = "black") +
    labs(
      title = paste("RoBERTa Sentiment Trend:", game),
      x = "Time Window",
      y = "Mean Sentiment (± SE)"
    ) +
    theme_minimal() +
    theme(
      plot.title = element_text(hjust = 0.5, size = 18, face = "bold"),
      axis.title = element_text(size = 16),
      axis.text.x = element_text(size = 14, angle = 45, hjust = 1),
      axis.text.y = element_text(size = 14)
    )
  
  print(plot)
}

dev.off()
