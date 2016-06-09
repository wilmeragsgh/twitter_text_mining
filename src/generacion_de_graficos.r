# aplicacion de LDA para la determinacion de temas
lda <- LDA(docterm,k = 3,method = 'Gibbs')
lda.topics <- as.matrix(topics(lda))

# 5 terminos mas frecuentes asociados a dichos terminos
lda.terms <- as.matrix(terms(lda,5))

# mejorando el estilo en que apareceran las palabras claves por termino
topic.terms <- c()
topic.terms[1] <- paste(c(lda.terms[,1],'\n'),collapse = '\n')
topic.terms[2] <- paste(c(lda.terms[,2],'\n'),collapse = '\n')
topic.terms[3] <- paste(c(lda.terms[,3],'\n'),collapse = '\n')

tw.df <- tw.df %>%
  mutate(topico = topic.terms[lda.topics])

tw.df.by.days <- tw.df %>% 
  group_by(created,topico) %>%
  dplyr::count(topico,created)

# imagen_1:
ggplot(tw.df.by.days,aes(x = created,y = n, group = topico,colour = topico)) +
  geom_line(size = 1) +
  ylab('Cantidad de tweets ')+
  xlab('Fecha del tweet') +
  ggtitle('Proporcion de temas por dia')

ggplot(tw.df.by.days,aes(x = created,y = n, group = topico,fill = topico)) +
  geom_bar(stat = 'identity',position = 'dodge') +
  ylab('Cantidad de tweets ')+
  xlab('Fecha del tweet') +
  ggtitle('Proporcion de temas por dia')

# imagen_2.png
wordcloud(myCorpus,max.words = 50, random.order = FALSE, colors = rev(terrain.colors(50)))

# imagen_3.png
wordcloud(tw.df$screenName,max.words = 20, random.order = FALSE, colors = rev(terrain.colors(20)))

# usuarios con mas tweets en la muestra
users <- findFreqTerms(DocumentTermMatrix(Corpus(VectorSource(tw.df$screenName))),10)

tw.df.freq.users <- tw.df %>% filter(screenName %in% users)
tw.df.freq.users <- tw.df.freq.users %>%
  group_by(screenName,topico) %>%
  dplyr::count(screenName,topico)

tw.df.freq.users.by.topic <- tw.df.freq.users %>% tidyr::spread(topico,n)
tw.df.freq.users.by.topic[1,2] <- 0
tw.df.freq.users.by.topic[4,2] <- 0

ggparcoord(tw.df.freq.users.by.topic,columns = c(2,4,3),groupColumn = 1) +
  xlab('Temas') +
  ylab('# de tweets(escalados)') +
  ggtitle('Proporcion de temas de top 5 usuarios')