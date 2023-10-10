
##lectura con read table ----> devuelve data frame
archivo<-"/home/clinux01/Desktop/Labo_Cate/Practica_4/boya.txt"

datos<-read.table(archivo,header=TRUE)
dim(datos)

datos_2<-read.table("/home/clinux01/Desktop/Labo_Cate/Practica_4/boya_2.txt")
head(datos_2) ##anda mal porque esta separado por comas

datos_2<-read.table("/home/clinux01/Desktop/Labo_Cate/Practica_4/boya_2.txt",header=T,sep=",")
head(datos_2) ##ahora lo lee bien

##lectura con scan ---> devuelve lista/vector

##lectura con read.fwf ---> para leer con formato fijo (se usa a veces para sondeos)

##Escritura
#write.table(variable,file="archivo.txt",otros_arg)
#ejemplo
tipo <- c("A", "B", "C")
longitud <- c(120.34, 99.45, 115.67)
datos_salida<- data.frame(tipo, longitud)
archivo_salida <- "/home/clinux01/Desktop/Labo_Cate/Practica_4/escritura_datos_ej.txt"
write.table(datos_salida,file=archivo_salida)


##EJERCICIO
archivo_estaciones<-"/home/clinux01/Desktop/Labo_Cate/Practica_4/datos_estaciones.txt"
datos_estaciones<-read.table(archivo_estaciones,header=T,na.strings=-999)

sum(is.na(datos_estaciones))

T_max<-max(datos_estaciones$TEMP,na.rm=T)
H_max<-max(datos_estaciones$HUM,na.rm = T)
P_max<-max(datos_estaciones$PNM,na.rm=T)

estacion_T_max<-as.character(datos_estaciones$NOMBRE[which(datos_estaciones$TEMP==T_max)])

hora_T_max<-(datos_estaciones$HORA[which(datos_estaciones$TEMP==T_max)])

estacion_H_max<-as.character(datos_estaciones$NOMBRE[which(datos_estaciones$HUM==H_max)])

hora_H_max<-(datos_estaciones$HORA[which(datos_estaciones$HUM==H_max)])

estacion_P_max<-as.character(datos_estaciones$NOMBRE[which(datos_estaciones$PNM==P_max)])

hora_P_max<-(datos_estaciones$HORA[which(datos_estaciones$PNM==P_max)])

promedios<-c()
desvios<-c()
for (i in 1:length(levels(datos_estaciones$NOMBRE))){
  promedios[i]<-round(mean(datos_estaciones$TEMP[datos_estaciones$NOMBRE==levels(datos_estaciones$NOMBRE)[i]],na.rm=T),digits=2)
  desvios[i]<-round(sd(datos_estaciones$TEMP[datos_estaciones$NOMBRE==levels(datos_estaciones$NOMBRE)[i]],na.rm=T),digits = 2)
}

estadisticos<-data.frame("Promedio"=promedios,"Desvio Estandar"=desvios,row.names = levels(datos_estaciones$NOMBRE))
archivo_estadisticos<-"/home/clinux01/Desktop/Labo_Cate/Practica_4/archivo_estadisticos.txt"
write.table(estadisticos,archivo_estadisticos,quote=F)
