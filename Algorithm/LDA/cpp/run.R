rm(list=ls())

## Load Libraries
library(tidyverse)
library(tm)
library(Rcpp) # we need RcppEigen and Boost as well
#install.packages("RcppEigen")
#install.packages("BH")

###########################
##        Make DTM       ##
###########################
## Same as Q6
## Read data and create DTM
dir <- DirSource("press_releases/") ## please check your folder name
dir$filelist <- dir$filelist[-43] # delete empty file

#############################################################
## Try with small corpus
samplenum <- 150
D <- sort( sample(1:4440, samplenum) )
I <- 4441:4582 # use all
R <- sort( sample(4583:7541, samplenum) )
dir$filelist <- dir$filelist[c(D, I, R)] # try with small corpus
#############################################################

## strip numbers, punctuation, and whitespace
corpus <- Corpus(dir) 
corpus <- tm_map(corpus, removeNumbers) %>% tm_map(removePunctuation) %>% tm_map(stripWhitespace)

### suggested pre-processing
## wordLengths = min word length of 3 is already default
ctrl <- list(tolower = TRUE,
             stopwords = TRUE,
             stemming = TRUE,
             bounds = list(global = c(3, Inf)))

## put this into a sparse matrix
dtm <- DocumentTermMatrix(corpus, control = ctrl)
library(Matrix)
dtm <- as.matrix(dtm) %>% Matrix(dtm, sparse = TRUE)

## keep only words that appear at least three times
freq <- colSums(dtm)
mean(freq > 2) # only about half of words we'll keep

keepTerms <- which(freq > 2)
dtm <- dtm[,keepTerms]
dim(dtm)


###########################
##     Run a function    ##
###########################
docnum <- nrow(dtm)
topicnum <- 20
uwordnum <- ncol(dtm)
sourceCpp('LDA_VBEM.cpp') ; ldares <- LDA_VEM(dtm, docnum, topicnum, uwordnum, max_iter=50, max_conv=100)
saveRDS(ldares, file="LDA_VBEM.obj") # save lda results in case we need it later
	# ldares <- readRDS("LDA_VBEM.obj")

### Check Results
# LDA_VEM returns a list that contains three objects:
#		$lower_bound: vector. lower_bound of each iteration
#		$Z				  : list. Length is the number of documents. Topic assignments for each word.
#		$TopWordIDs : list. Show words that have high proportions in a topic.

## Lower bound
p <- ggplot(data=data.frame(iter=1:length(ldares$lower_bound), lower_bound=ldares$lower_bound), 
						aes(x=iter, y=lower_bound)) +
  geom_line() +
  geom_point() + theme_bw() +
	labs(x="iterations", y="lower bound") +
	theme(plot.title = element_text(hjust = 0.5)) + ggtitle("Variational-EM, Lower Bound")
ggsave("LDA_VBEM_lowerbound.pdf", p)
ggsave("LDA_VBEM_lowerbound.png", p)

## Topic assignments
get_party <- function(x){
	return (as.character(substr(x, 1, 1)))
}
party_list <- sapply(rownames(dtm), get_party)
id_list <- 1:docnum
# Get IDs of documents that are written by each party members
Ddoc <- id_list[party_list == "D"]
Rdoc <- id_list[party_list == "R"]
Idoc <- id_list[party_list == "I"]

# Merge topic information into a single df
Dtopics <- data.frame(topic=unlist(ldares$Z[Ddoc], recursive=FALSE), party="D")
Rtopics <- data.frame(topic=unlist(ldares$Z[Rdoc], recursive=FALSE), party="R")
Itopics <- data.frame(topic=unlist(ldares$Z[Idoc], recursive=FALSE), party="I")

topics <- data.frame(D=NULL, R=NULL, I=NULL)
for(i in 1:topicnum-1){
	temp <- data.frame(D=sum(Dtopics==i)/length(Dtopics$topic)*100, 
										 R=sum(Rtopics==i)/length(Rtopics$topic)*100,
										 I=sum(Itopics==i)/length(Itopics$topic)*100,
										 topic=i)

	topics <- rbind(topics, temp)
}
topics_tidy <- gather(topics, key=topic, value=proportion)
colnames(topics_tidy) <- c("topic", "party", "proportions")
topics_tidy$party <- factor(topics_tidy$party, levels=c("D", "R", "I"))

p <- ggplot(topics_tidy, aes(x=factor(topic), y=proportions, fill = party)) +   
  geom_bar(position = "dodge", stat="identity") +
  scale_fill_manual(values =c("royalblue1", "firebrick", "orange")) +
  theme_bw() + 
  ggtitle("Within-Party Proportion of Press Releases on Each Topic") +
  labs(x="Topics", y = "proportions") +
	theme(plot.title = element_text(hjust = 0.5))
ggsave("LDA_VBEM_topics.pdf", p, width = 12, height = 7)
ggsave("LDA_VBEM_topics.png", p, width = 12, height = 7)

## WordIDs
words_list <- colnames(dtm)

id_to_word <- function(x){
	# convert word ids to word
	word_list <- NULL
	for(id in x){
		word_list <- c(word_list, words_list[id])
	}
	return (word_list)
}

topwords <- lapply(ldares$TopWordIDs, id_to_word)
topwords_df <- data.frame(topwords)
colnames(topwords_df) <- as.character(0:(topicnum-1))
topwords_df <- topwords_df[1:15, ] # set how many top words to show
rownames(topwords_df) <- 1:15

colnames(topwords_df) <- paste('Topic', 1:topicnum-1)
markdown <- paste(c(knitr::kable(topwords_df[, 1:10]), "\n", knitr::kable(topwords_df[, 11:20])))
write(markdown, "LDA_VBEMtopwords.md")
