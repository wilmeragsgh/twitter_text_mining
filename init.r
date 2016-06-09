source('lib/helpers.R')
# Es necesario que tenga instaladas las siguientes librerias:
install.packages(c('ProjectTemplate',
                   'log4r',
                   'tm',
                   'ggplot2',
                   'reshape',
                   'lubridate',
                   'wordcloud',
                   'GGally'))

# una vez instaladas:
library('ProjectTemplate')
load.project()
# Ahora puede dirigirse a src/generacion_de_graficos.r
# o a munge/limpieza_de_tweets.r