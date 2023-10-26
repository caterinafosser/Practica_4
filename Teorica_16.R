# # Laboratorio de Procesamiento de Informaci???n Meteorologica/Oceanografica

# clase NCDF 2 -- Leer y guardar archivos


require(ncdf4)
require(lubridate)

OUTPUTS<-getwd()

#definicion de las dimensiones: ncdim_def

lon <- seq(270,320,5)
lats<-seq(-10,-50,-5)

Months<-as.numeric(seq(as.Date("1979/1/1"), by= "month", length.out= 432))

#definicion de las dimensiones
dimX<- ncdim_def( "long", "degrees", lon)
dimY<- ncdim_def ( "lat", "degrees", lats )
dimT<- ncdim_def( "Time", "days", Months, unlim=TRUE )

#definicion de la variable
var1d <- ncvar_def("mslp", units= "hPa", longname= "mean sea level pressure",dim= list(dimX,dimY,dimT), missval= -999, prec="double",verbose=TRUE )

#creamos el archivo
nc<- nc_create(paste(OUTPUTS,"/mslp_hPa.nc",sep=""), list(var1d) )

#datos de nuestra variable
MSLP<-runif(42768,min=980,max=1026)

#agregamos las variables con los datos al archivo
ncvar_put( nc, var1d, MSLP )

#cerramos el archivo
nc_close(nc)

##### Abrir archivo

nc<-nc_open(paste(getwd(),"/mslp_hPa.nc",sep=""))

presion<-ncvar_get(nc,varid="mslp") 

Longitud<-ncvar_get(nc,varid="long")
Latitud<-ncvar_get(nc,varid="lat")
Time<-ncvar_get(nc,varid="Time")

fecha<-ymd_hms ("1970-1-1 00:00:00") + days(Time)

presion[2,2,3]

######PRACTICAR
rm(list=ls())

nc<-nc_open(paste(getwd(),"/Practica_4/Archivos_teo_15/X157.92.28.55.252.12.27.10.nc",sep=""))

sst<-ncvar_get(nc,"sst")
latitudes<-ncvar_get(nc,"lat")
longitudes<-ncvar_get(nc,"lon")
Time<-ncvar_get(nc,"time")
time<-ymd_hms("1800-01-01 00:00:00")+days(Time)

fecha_inicio<-which(format(time,"%Y-%m-%d")=="1990-01-01")
fecha_fin<-which(format(time,"%Y-%m-%d")=="1999-12-01")

sst_seleccion<-sst[,,fecha_inicio:fecha_fin]

##hago lo de antes