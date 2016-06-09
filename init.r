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