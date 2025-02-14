install.packages("tm")

library("tm")
library("SnowballC")
library("wordcloud")
library("RColorBrewer")

# To choose the text file
text = readLines(file.choose())

text

# VectorSource() function 
# creates a corpus of 
# character vectors
docs = Corpus(VectorSource(text))   

# Text transformation
toSpace = content_transformer(
  function (x, pattern)
    gsub(pattern, " ", x))
docs1 = tm_map(docs, toSpace, "/")
docs1 = tm_map(docs, toSpace, "@")
docs1 = tm_map(docs, toSpace, "#")
strwrap(docs1)

# Cleaning the Text
docs1 = tm_map(docs1, content_transformer(tolower))
docs1 = tm_map(docs1, removeNumbers)
docs1 = tm_map(docs1, stripWhitespace)

# Build a term-document matrix
dtm = TermDocumentMatrix(docs)
m = as.matrix(dtm)
v = sort(rowSums(m), 
         decreasing = TRUE)
d = data.frame(word = names(v),
               freq = v)
head(d, 10)

# Generate the Word cloud
wordcloud(words = d$word, 
          freq = d$freq,
          min.freq = 1, 
          max.words = 200,
          random.order = FALSE, 
          rot.per = 0.35, 
          colors = brewer.pal(8, "Dark2"))
#repushing with message