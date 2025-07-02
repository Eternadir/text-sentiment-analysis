df <- readxl::read_excel("Soulsborne_reviews.xlsx", sheet = 1)

# Ensure the relevant columns are numeric
df$User_Score <- as.numeric(df$User_Score)
df$RoBERTa <- as.numeric(df$RoBERTa_Sentiment_Score)

# Scale RoBERTa sentiment from [-1, 1] to [0, 10]
df$RoBERTa_scaled <- (df$RoBERTa + 1) * 5

# Drop rows with missing values in either column
df_clean <- df[complete.cases(df$User_Score, df$RoBERTa_scaled), ]

# Paired t-test
t_test_result <- t.test(df_clean$User_Score, df_clean$RoBERTa_scaled, paired = TRUE)

print(t_test_result)

