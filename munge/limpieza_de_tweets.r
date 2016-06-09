'   This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
'

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