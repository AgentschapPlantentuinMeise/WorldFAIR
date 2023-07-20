library(dplyr)


data <- read.csv('../results/globi.tsv', sep = '\t', quote = "", header = F)
names(data) <- c('context', 'format', 'delimiter', 'url', 'citation', 'file')
dim(data)
data <- data %>% as_tibble()
data

data <- data %>%
  mutate(type=ifelse(context!="","text/csv", "")) %>%
  mutate(type=ifelse(format!="NULL",format,type))
data$type         
data[data$type=="",]$type <- "text/csv"

data %>%
  dplyr::count(type)

data %>%
  filter(type=='dwca')
