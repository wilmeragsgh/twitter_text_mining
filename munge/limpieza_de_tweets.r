# obtener los campos del objeto tweet:
colnames(tw)

# filtrar solo las columnas text,created y screenName:
tw.df <- tbl_df(rbind(tw[,c(1,5,11)],tw1[,c(1,5,11)]))

# funciones y variables para preprocesamiento de texto:
removeURL <- function(x) gsub("http[^[:space:]]*", "", x)
removeNumPunct <- function(x) gsub("[^[:alpha:][:space:]]*", "", x)
myStopwords <- c(stopwords('spanish'), "que", "yo",'#6D','htt','así','hoy','días','vota','voto','votar','video','faltan','solo','d')

# limpieza de los tweets:
tw.df <- tw.df %>% 
  mutate(text = iconv(enc2utf8(text),sub="byte")) %>%
  mutate(text = removeURL(text)) %>%
  mutate(text = removeNumPunct(text)) %>%
  mutate(text = tolower(text)) %>%
  mutate(text = removeWords(text,myStopwords)) %>%
  mutate(text = stripWhitespace(text)) %>%
  filter(text != ' ')

# ajuste del formato de la fecha:
tw.df <- tw.df %>%
  mutate(created = format.Date(created, '%Y-%m-%d'))

# creacion de corpus
myCorpus <- Corpus(VectorSource(tw.df$text))

# creacion de document-term matrix
docterm <- DocumentTermMatrix(myCorpus)