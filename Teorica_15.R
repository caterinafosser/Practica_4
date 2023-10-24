##Teorica 24-10 NCDF

require(ncdf4)

nc<-nc_open(paste(getwd(),"/Archivos_teo_15/hgt850.nc",sep=""))
hgt850<-ncvar_get(nc,"hgt")  ##variable hgt (el short name de la variable cuando vemos la info del nc)
longitud<-ncvar_get(nc,"lon")
latitud<-ncvar_get(nc,"lat")
Time<-ncvar_get(nc,"time")

#quiero pasar de horas raras y feas a fechas reales

#1ra forma
z<-seq(as.Date("1981/1/1"),by="day",length.out=12783)  #tengo que saber la fecha real de inicio, NO USAR
head(z)

#2da forma
require(lubridate)
time<-ymd_hms("1800-1-1 00:00:00")+hours(Time)

#3ra forma
fechas<-as.Date(Time/24,origin="1800-01-01")


#defino dimensiones de variable
dimnames(hgt850)<-list(lon=longitud,lat=latitud,date=as.character(time))

contour(hgt850[,,1])


#me quedo con un rango de latitudes
lat20<-which(latitud==-20)
lat40<-which(latitud==-40)
contour(hgt850[,lat40:lat20,8006])

#me quedo con un rango de fechas
fecha<-which(format(time,"%Y-%m-%d")=="1996-12-31")  #le digo como es el formato de la variable de fechas
contour(hgt850[,,fecha])


####PRACTICAR 
#1
rm(list=ls())
nc<-nc_open(paste(getwd(),"/Archivos_teo_15/olr.mon.mean.nc",sep=""))
olr<-ncvar_get(nc,"olr")
latitud<-ncvar_get(nc,"lat")
longitud<-ncvar_get(nc,"lon")
Tiempos<-ncvar_get(nc,"time")

library(lubridate)
time<-ymd_hms("0001-01-01 00:00:00")+hours(Tiempos)
fecha<-which(format(time,"%Y-%m-%d")=="2002-12-03")
contour(olr[,,fecha])


#2
rm(list=ls())
nc<-nc_open(paste(getwd(),"/Archivos_teo_15/X157.92.28.55.252.12.27.10.nc",sep=""))
SST<-ncvar_get(nc,"sst")
longitudes<-ncvar_get(nc,"lon")
latitudes<-ncvar_get(nc,"lat")
Times<-ncvar_get(nc,"time")

time<-ymd_hms("1800-01-01 00:00:00")+days(Times)
contour(SST[,,1])

##serie temporal
plot(SST[20,20,],type='l',col="#401de2")


#3
rm(list=ls())
nc<-nc_open(paste(getwd(),"/Archivos_teo_15/pp_gfdl_hist_2001.nc",sep=""))
pp<-ncvar_get(nc,"pr")  #esta en kg/m2s que lo puedo cambiar a mm/dia, kg/m2 == mm
pp_mm<-pp*86400
longitudes<-ncvar_get(nc,"lon")
latitudes<-ncvar_get(nc,"lat")
Time<-ncvar_get(nc,"time")
time<-ymd_hms("1861-01-01 00:00:00")+days(Time)


ppmax<-max(pp_mm)
which(pp_mm==ppmax,arr.ind=T) #da datos de donde llovio mas
