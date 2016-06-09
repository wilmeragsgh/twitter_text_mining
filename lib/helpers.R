helper.function <- function()
{
  return(1)
}

lib <- function(pkg,with.devtools = F,devtools.source = 'github'){
  # Descipcion:
  #   Descarga e instala/carga paquetes segun sea necesario.
  #
  # Args:
  #   pkg: paquete(s) a cargar.
  #   from: fuente del paquete referido a opciones de devtools, ejemplo: github.
  #
  # Retorna:
  #   Carga pkg en el env actual.
  if(!with.devtools){
    if (!require(pkg, character.only = TRUE)) {
      install.packages(pkg)
      library(pkg)
      if (!require(pkg, character.only = TRUE)) stop(paste("load failure:", pkg))
    }
  }
  if(with.devtools){
    if(length(grep(x = ls('package:devtools'),pattern = devtools.source))== 0){
      stop(paste('devtools source not found:',devtools.source))
    }else
      pkg.only <- last(unlist(strsplit(pkg,split = '/'))) # example pkg <- 'vqv/ggbiplot'
    if (!require(pkg.only, character.only = TRUE)) {
      do.call(paste('install_',devtools.source,sep = ''),args = list(pkg))
      if (!require(pkg.only, character.only = TRUE)) stop(paste("load failure:", pkg))
    }
  }
}