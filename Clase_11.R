###Archivos binarios -- PRACTICA 4
#Lectura: readBin(archivo, clase, longitud, formato_maquina, tamaño)
#Escritura: writeBin(variable, archivo, tamaño, longitud, formato_maquina)

nlat <- 181 #cantidad total de la dimension y (o latitudes)
nlon <- 360 #cantidad total de la dimension x (o longitudes)
ntiempos<- 348 #cantidad total de la dimension time (tiempos)
nnivel<- 1 #cantidad total de la dimension z (o niveles)
nvar <- 1 #Cantidad total de variables
dato_faltante<- -999

N<- nlat*nlon*ntiempos*nnivel*nvar  # N que va a ser longitud del vectorque voy a leer del binario
archivo<-"/home/clinux01/Escritorio/Labo_Cate/data.r4/data.r4"
datos<- readBin(archivo, "numeric", n = N, endian = "big",size = 4)
datos[which(datos== dato_faltante)] <- NA ##cambio los datos faltantes por NA

# Armo el array teniendo en cuenta que la primer dimension tiene que ser la de las longitudes
# Luego las latitudes y luego el tiempo

datos_array<- array(data = datos, dim = c(nlon, nlat, ntiempos))

#creo el vector latitudes
latitudes <- seq(-90,90,1)
#chequeo que tenga como longitud 181
length(latitudes)
#creo el vector longitudes
longitudes <- seq(0,359,1)
#chequeo que tenga como longitud 181
length(longitudes)

##Me quiero quedar con la region de Argentina
arg<-datos_array[which(longitudes==285):which(longitudes==310),which(latitudes==-55):which(latitudes==-20),]  ##con which busco las posiciones dentro de latitudes y longitudes que corresponden al area que me interesa
#redimensiono el array para poder tener una matriz por año
arg<-array(arg,dim=c(length(285:310),length(-55:-20),12,29))
prom_anual_arg<-apply(arg,c(1,2,4),mean)

##Ejercicio
rm(list=ls())
nlon<-360
nlat<-181
ntiempos<-6
nnivel<-1
nvar<-4
dato_faltante<-9.999E+20
N<- nlat*nlon*ntiempos*nnivel*nvar
archivo<-"/home/clinux01/Escritorio/Labo_Cate/SepIC_nmme_tmpsfc_anom_stdanom.dat/SepIC_nmme_tmpsfc_anom_stdanom.dat"
datos<- readBin(archivo, "numeric", n = N, endian = "big",size = 4)
datos[which(datos== dato_faltante)] <- NA 

datos_array<- array(data = datos, dim = c(nlon, nlat, ntiempos, nvar))
longitudes <- seq(0,359,1)
latitudes <- seq(-90,90,1)
arg<-datos_array[which(longitudes==285):which(longitudes==310),which(latitudes==-55):which(latitudes==-20),,]

arg_anomalia_diciembre<-arg[,,3,3]  #diciembre: mes 3, anomalia: variable 3
