Coursera Data Science Capstone: Next Word Prediction Application 
========================================================
author: mjurado
date: Jan 17, 2016
transition: zoom
font-family: 'Risque'

Summary
========================================================

This presentation is part of Coursera Data Science Capstone project.  

The course project consists of two parts:

- An interactive Shiny application that predicts the next word from a random n-gram
- A pitch developed using RStudio Presenter

The data for this Shiny application was a specific dataset for the Coursera Capstone and can be found [here](https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip).

About the Application
========================================================

The goal of this Shiny application was to predict the next word from a phrase entered by the user. The application uses a set of Twitter, blog, and news sources were used to create the corpus. The data was derived from [HC Corpora](http://www.corpora.heliohost.org).  

To use this application, simply type in a phrase in the text box provided.  Optionally, you may opt to have the application return several predicted words based on your phrase.  Please note that during the initial startup, there may be a 30 second delay to load the data that supports the predictive algorithm.

General instructions can also be found by selecting the __About__ tab at the top of the [webpage](https://mjurado.shinyapps.io/Capstone_MJ/).

The source code for this project can be located on [GitHub](https://github.com/juradom/Capstone_MJ).

Data Cleansing Approach
========================================================
My first step was to clean the data and produce four sets of n-gram files.
I took a small sample from each file in the corpus for performance purposes. I then concatenated the files together and started the data cleansing.
Below are the steps taken to clean the data:

- Convert all words to lower case to normalize the words 
- Remove numbers and punctuation 
- Strip extraneous whitespace 
- Remove function words (stop words) 
- Stem the document by removing common word endings 
- Remove profanity 
*Note:  The bad words list was referenced [here](http://raw.githubusercontent.com/shutterstock/List-of-Dirty-Naughty-Obscene-and-Otherwise-Bad-Words/master/en)*



Tokenization & Algorithm Approach
========================================================

After the data was cleaned up, it was then tokenized into n-grams using the RWeka NGramTokenizer function.  Once the n-grams were determined their frequencies were summarized and sorted to be used in my algorithm.

My algorithm relies on a backoff approach where the prediction is determined by a combination of phrase frequency and n-gram length.  Priority was given to the n-grams with longer matching sequences.




