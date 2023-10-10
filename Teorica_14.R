###Teorica 14 -- Lectura de archivos EXCEL

require(gdata)

xlsfile <- file.path(path.package('gdata'),'xls','iris.xls')
iris <- readxl::read_xls(xlsfile)
head(iris)
iris1 <- read.xls(xlsfile,method="csv")
head(iris1)
iris2 <- read.xls(xlsfile,method="tab")
head(iris2)

exampleFile <- file.path(path.package('gdata'),'xls', 'ExampleExcelFile.xls')
exampleFile2007 <- file.path(path.package('gdata'),'xls', 'ExampleExcelFile.xlsx')

sheetCount(exampleFile)
if( 'XLSX' %in% xlsFormats() ){ ## ver si soporta el formato XLSX.
sheetCount(exampleFile2007)
}

sheetNames(exampleFile)
if( 'XLSX' %in% xlsFormats() ) {## if XLSX is supported..
  sheetNames(exampleFile2007)
}

data1 <- read.xls(exampleFile) ## default lee la primer hoja
data2 <- read.xls(exampleFile, sheet=2) ## leo la segunda hoja por numero
data3 <- read.xls(exampleFile, sheet="Sheet Second",v=TRUE) ## leo por nombre

data4 <- read.xls(exampleFile2007, sheet="Sheet with initial text", skip=2)

readxl::read_xls(exampleFile,sheet = 4,skip = 2)

## EJEMPLO campus
meteo<-file.path("datos.xls")
sheetCount(meteo)
sheetCount("datos.xls")

sheetNames("datos.xls")  ##o readxl::excel_sheets(meteo)

meteo_0<-read.xls(meteo,sheet=2)
meteo_1<-read.xls("datos.xls",sheet = 2)

head(meteo_1)
class(meteo_1)
correlacion<-cor(meteo_1[,1],meteo_1[,2]) 

meteo_2<-read.xls(meteo,sheet = 3,skip=1)
head(meteo_2)
class(meteo_2)
plot(meteo_2[,3],type="l")
plot(meteo_2[1:12,5],type="h")

medias<-apply(meteo_2[,3:5],2,mean)

medias_onda<-matrix(0,nrow=12,ncol=3)
for (i in 1:12){
  a=which(meteo_2[,2]==i)
  medias_onda[i,1:3]<-apply(meteo_2[a,3:5],2,mean)
}

plot(medias_onda[,1],type="l",col='red',ylim=c(0,30))
lines(medias_onda[,2],type="l",col='blue') #lines sirve para superponer sobre graficos q ya existen
lines(medias_onda[,3],type="l",col='green')
plot(meteo_1[,1],type="l",col='red',ylim=c(18,30))
lines(meteo_1[,2],type="l",col='blue')


###Imagenes raster
rm(list=ls())
require("raster")
require("maps")

WIND<-raster("/home/clinux01/Desktop/Labo_Cate/Practica_4wind_speed_monthly_globe_2014.grib",band=2)

