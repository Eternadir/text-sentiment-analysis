library(readxl)
library(dplyr)
library(ggplot2)

# Load data
df <- read_excel("Soulsborne_reviews.xlsx")

# Convert necessary columns
df <- df %>%
  mutate(
    User_Total_Reviews_Count = as.numeric(User_Total_Reviews_Count),
    Average_User_Score = as.numeric(Average_User_Score),
    RoBERTa = as.numeric(RoBERTa_Sentiment_Score),
    Date_of_Review = as.Date(Date_of_Review),
    User_First_Review = as.Date(User_First_Review),
    Review_Age = as.numeric(Date_of_Review - User_First_Review)
  ) %>%
  filter(!is.na(User_Total_Reviews_Count),
         !is.na(Average_User_Score),
         !is.na(RoBERTa),
         !is.na(Review_Age))

# 1. Do prolific users give more positive/negative sentiment?
cor1 <- cor(df$User_Total_Reviews_Count, df$RoBERTa, method = "pearson")
print(paste("Correlation between total review count and RoBERTa sentiment:", round(cor1, 3)))

# 2. Do earlier reviewers have different sentiment? (Review_Age = recency)
cor2 <- cor(df$Review_Age, df$RoBERTa, method = "pearson")
print(paste("Correlation between review age and RoBERTa sentiment:", round(cor2, 3)))

# 3. Do users with lower average user scores write more positive/negative reviews?
cor3 <- cor(df$Average_User_Score, df$RoBERTa, method = "pearson")
print(paste("Correlation between average user score and RoBERTa sentiment:", round(cor3, 3)))

