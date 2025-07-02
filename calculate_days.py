import pandas as pd

# Load the Excel file and read the "All games" sheet
df = pd.read_excel("Soulsborne_reviews.xlsx")

# Convert the date columns to datetime format
df["Release_Date"] = pd.to_datetime(df["Release_Date"])
df["Date_of_Review"] = pd.to_datetime(df["Date_of_Review"])

# Create the Days_Since_Release column
df["Days_Since_Release"] = (df["Date_of_Review"] - df["Release_Date"]).dt.days

# Save new column to excel
df.to_excel("Soulsborne_reviews_with_days.xlsx", index=False)

