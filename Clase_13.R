require(readxl)  ##readxl tiene funciones como excel_sheets (info de hojas) y read_excel(lee el archivo)
setwd("~/Escritorio/Labo_Cate/Practica_4")
archivo_datos<-paste(getwd(),"/practica_datos/datos.xls",sep="")
cant_hojas<-length(excel_sheets(archivo_datos))
cat("El archivo tiene",cant_hojas,"hojas")
nombre_hojas<-excel_sheets(archivo_datos)
cat("Estas hojas se llaman:","\n",nombre_hojas)

abro_archivo<-read_excel(archivo_datos,sheet=3)
head(abro_archivo)
class(abro_archivo)

#Ejercicio
require(lubridate)
path<-paste(getwd(),"/practica_datos/Historicos_Estacion_3316.xlsx",sep="")
datos_timbues<-read_excel(path)
head(datos_timbues)

tiempos<-dmy_hm(datos_timbues$`Fecha y Hora`)
anios<-year(tiempos)
meses<-month(tiempos)
dias<-day(tiempos)

datos_altura_timbues<-data.frame("Anio"=anios,"Mes"=meses,"Dia"=dias,"Altura [m]"=datos_timbues$`Altura [m]`)

medias_enero<-c()
for (i in 1980:2021){
  media_i<-mean(datos_altura_timbues$Altura..m.[which(datos_altura_timbues$Anio[which(datos_altura_timbues$Mes==1)]==i)],na.rm=T)
  medias_enero<-c(medias_enero,media_i)
}
minima_enero<-min(medias_enero)
anio_minima_enero<-which(medias_enero==minima_enero)+1979


media_mensual_altura<-function(mes,anio_i,anio_f){
  medias_mes<-c()
  for (i in anio_i:anio_f){
    media_i<-mean(datos_altura_timbues$Altura..m.[which(datos_altura_timbues$Anio[which(datos_altura_timbues$Mes==mes)]==i)],na.rm=T)
    medias_mes<-c(medias_mes,media_i)
  }
  minima_mes<-min(medias_mes,na.rm=T)
  anio_minima_mes<-which(medias_mes==minima_mes)+(anio_i-1)
  return(list(minima_mes,anio_minima_mes))
}

Anio_minima<-c()
Altura_minima<-c()
for (i in 1:12){
  Anio_minima[i]<-media_mensual_altura(i,1980,2021)[[2]]
  Altura_minima[i]<-media_mensual_altura(i,1980,2021)[[1]]
}

alturas_minimas_mensuales<-data.frame("Mes"=1:12,"Anio de minima"=Anio_minima,"Altura minima (m)"=Altura_minima)

library(writexl)
write_xlsx(alturas_minimas_mensuales,path=paste(getwd(),"/practica_datos/Resultados_ejercicio.xlsx",sep=""))