#Repaso NetCDF - Practica

library(ncdf4)
archivo<-paste(getwd(),"/air.mon.mean.nc",sep="")
nc<-nc_open(archivo)

temp_aire<-ncvar_get(nc,"air")
latitudes<- ncvar_get(nc, "lat")
longitudes<- ncvar_get(nc, "lon")
tiempos<- ncvar_get(nc, "time")

tiempos_legibles<- as.Date(tiempos/24,origin="1800-01-01")
datos_temp_marzo <- temp_aire[, ,months(tiempos_legibles) == "marzo"]



library(udunits2)
library(metR)

GlanceNetCDF(nc)
datos<-ReadNetCDF(archivo,vars="air")
head(datos)
datos_region<- ReadNetCDF(archivo, vars = "air",
                          subset = list(lat = c(-65, -20),
                                        lon = c(280, 310)))

####Ejercicio!
rm(list=ls())
library(lubridate)

archivo<-paste(getwd(),"/datos_u850.nc",sep="")
nc<-nc_open(archivo)
GlanceNetCDF(nc)
viento_cuenca_plata<-ReadNetCDF(archivo,vars="ua850",
                                subset=list(lon=c(-64.25,-51.25),
                                            lat=c(-38.75,-23.75)))

u_promedios<-c()
datos_anio<-c()
for (i in 2005:2010){
  datos_anio<-c(datos_anio,viento_cuenca_plata$ua850[year(viento_cuenca_plata$time)==i])
  u_promedios<-c(u_promedios,mean(datos_anio))
  datos_anio<-c()
}

prom_viento_cuenca<-data.frame("anio"=2005:2010,"viento zonal promedio"=u_promedios)

##ggplot
rm(list=ls())
