# Sentiment Analysis using Python
NLP-based sentiment analysis on video game reviews using TextBlob library and RoBERTa model in Python. Sentiment polarity calculated from the reviews range from -1 (negative) to 1 (positive). 
NOTE: The methods in this project are intended for video game reviews, however with creative nuance, the process can be modified for product or other media reviews. 

### Overview
Extracted raw data from html files (html files were copy and pasted from Metacritic website)
Processed and cleaned excel files 
Performed sentiment analysis on excel files using two models
Conducted statistical analysis on final product (outside Github, contact if interested)

### Files
RoBERTa_Model.py - Calculates sentiment polarity for reviews using RoBERTa NLP model
TextBlob_Model.py - Calculates sentiment polarity for reviews using TextBlob library
calculate_days.py - Calculates the difference in days between a video game release data and the corresponding review date
html_capture.py - Extracts the raw data from the html files and adds it to an excel file
language.py - Reads revuews and adds a language column for language filtering
roberta_trends.R - R code that visualizes trends of sentiment polarity
t-test.R - R code that tests signficance between user scores (0 to 10) and sentiment polarity (-1 to 1)
user_stats.R - Bonus R code that computes correlations to answer questions regarding user stats 

### Process for Replication
## Phase 1
1. Setup a PyCharm directory
2. Ensure that gamename_reviews.html, gamename_temp.xlsx, and gamename_reviews.xlsx are in the same directory.
3. gamename_reviews.html is extracted indirectly from the html source code in the Metacritic website.
      a.	First inspect the website to see the html code. 
      b.	When extracting html from the website, the page must be fully loaded so that no reviews are skipped.  
      c.	Most games come out on different platforms. For each platform, you must copy and paste the whole html source code into a .txt file and then convert the .txt file into a .html file.  
4. gamename_temp.xlsx is an excel file with three empty columns: Media, Video_Game, Release_Date (change accordingly).
5. Run the html_capture.py to add the data from the html file to produce gamename_reviews.xlsx. The inputs are the gamename_reviews.html and the gamename_temp.xlsx
6. Fill in Media, Video_Game, and Release_Date columns in gamename_reviews.xlsx:
      a.	Media: Metacritic
      b.	Video_Game: Name of the game you captured the data for
      c.	Release_Date: The date the game was released. You can simply look it up on google. 
7. The format of the excel produced isn’t ideal. It requires some manual changes for clarity. 
      a.	Changing the date to MM/DD/YEAR (Short dates)
      b.	Converting the user score into a number: 
            i.	Highlight all cells -> click yellow triangle with exlamation point -> ‘Convert to numbers’
      c.	How to convert long date column to short dates:
            i.	Data -> Text to columns -> Delimited (Next) -> No Delimiters (Next) -> Column Data Format to Date (MDY) -> Finish -> Highlight Date_of_Review column -> change format to Short Date
8.	In addition, not all reviews are fully captured. Some reviews are too long or contain spoilers so they aren’t directly in the html source code. To fill these reviews, you must manually input them into excel       by searching for all the reviews that start with [SPOILER ALERT: This review contains spoilers.].
9.	Finally, after making the fixes to the format, filling in the first three columns, and manually inputting the missing reviews, you have the final product for the text capture and can move on to the next           phase. 
## Phase 2
1. Now that we have the output excel from html_capture.py, you must run the language.py on the excel to filter the languages and non-verbal reviews.
      a. The output file will be a sorted reviews excel.
      b.	From the sorted reviews excel, we can take all the non-English reviews and move them into the miscellaneous_reviews.xlsx. From there, update the sorted reviews file to be only English reviews and then             save. (Or we can delete all the non-English reviews)
      c.	Ex: Running the language.py with darksouls1_reviews.xlsx will output a sorted excel called darksouls1_reviews_sorted.xlsx.
2. Run calculate_days.py to get a new excel and extract the new column and move it to the gamename_reviews.xlsx. 
3. Now with the updated gamename_reviews.xlsx from the previous steps, we add 3 new columns called Average_User_Score, User_First_Review, and User_Total_Reviews_Count. These columns will be manually inputted from    the Metacritic website. 
      a.	When visiting their pages, each user will have their average user score and total reviews next to their name. Then scroll down their page to find the date of the first review they wrote. 
      b.	After manually inputting the values for each column for each user the excel is ready to be processed. Make sure to save consistently since the process is lengthy. (A much better programmer than me could           figure out how to make a code that does this process much faster.)
      c. If short on time, skip this step alltogether.
4. Now that you have your finalized excel, you can run TextBlob_Model.py and RoBERTa_Model.py to get the excel files with the sentiment polarity for each review. If your video game has more than 3,000 reviews, I     recommend breaking the excel into multiple parts and running the code for each part and then merging those parts.
## Phase 3
- Repeat Phase 2 for each video game
- Combine all game excels into one big excel if needed










