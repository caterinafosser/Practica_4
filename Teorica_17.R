plot(sin,-pi,4*pi,type="o")

plot(sin,-pi,4*pi,type="o",main="Sen(x)",sub="ondaondabuenaonda",xlab="x",ylab="sin")

x<-(0:65)/10
y<-sin(x)
plot(x)
plot(x,y)
plot(x,y,main="Funcion Seno",type="l",xlab="numeros",ylab="seno")

z<-cos(x)
plot(x,z,main="Funcion Coseno",type="l")

plot(x, z, main="Coseno", lty=2, col="red", type="l")

plot(x, z, main="Coseno", lty=3, col="blue", type="l", xlim=c(0, 2), ylab="cos(x)")

plot(x,y,main="Funciones seno y coseno",type="l")
lines(x,z,col="blue",lty=2)
text(x=c(5.5,5.5),y=c(0,1),labels=c("sin(x)","cos(x)"),col=c("black","blue"))

##funcion interactiva locator(), con click del mouse
plot(x, y, main="Funciones seno y coseno", type="l")
lines(x, z, col=2, lty=2)
legend(locator(1),legend=c("sin(x)","cos(x)"),lty=c(1,2),col=c(1,2))


##funcion identify
x <- 1:10
y <- sample(1:10)
plot(x, y); identify(x, y) #usar ESC para terminar

nombres <- paste("punto", x, ".", y, sep ="")
plot(x, y); identify(x, y, labels=nombres) 



##coloresssssss
pie(rep(1, 12), col = rainbow(12))
pie(rep(1, 12), col = heat.colors(12))
pie(rep(1, 12), col = terrain.colors(12))
pie(rep(1, 12), col = topo.colors(12))
pie(rep(1, 12), col = cm.colors(12))

colors()[grep("red",colors())] #todos los tonos de rojo


X<-1:5 
colors <- c("honeydew","dodgerblue","firebrick","forestgreen","gold")
par(fig=c(0,1,0,1), # Figure region in the device display region (x1,x2,y1,y2)
    omi=c(0.05,0.15,0,0.05), # global margins in inches (bottom, left, top, right)
    mai=c(0.6,0.6,0.6,0.5)) # subplot margins in inches (bottom, left, top, right)
barplot(X, col= colors)
legend("bottomright", colors  , text.col = "purple4", horiz = F,
       col=colors, cex=0.8, lty=1, y.intersp = 1, lwd = 3 )



require(ncdf4)
require(fields)
require(mapdata)

setwd(paste(getwd(),"/Desktop/Labo_Cate/Practica_4",sep=""))

nc<-nc_open("netcdf_SLP_SA_1979_2014.nc")
lon<-ncvar_get(nc,"longitude")
lats<-ncvar_get(nc,"latitude")
time<-ncvar_get(nc,"time")
MSLP<-ncvar_get(nc,"msl") ## MSLP * 100

P <- MSLP[,,1]/100
mn<-min(P); mx<-max(P)
brk <- seq(mn,mx,length.out = 13)
levs<-brk

RGB<-matrix(c(0,  0.167,	1,
              0.1,	0.4,	1,
              0.2,	0.6,	1,
              0.4,	0.8,	1,
              0.6,	0.933,	1,
              0.8,	1,	1,
              1,	1,	0.8,
              1,	0.933,	0.6,
              1,	0.8,	0.4,
              1,	0.6,	0.2,
              1,	0.4,	0.1,
              1,	0.167,	0), nrow=12, byrow=TRUE)
cols<-rgb(RGB[,1],RGB[,2],RGB[,3]) #convierte color a rgb
image.plot(lon-360,rev(lats[1:55]),P[,55:1], breaks=brk, lab.breaks=names(brk), col=cols)
contour(lon-360,rev(lats[1:55]),P[,55:1], add=TRUE, col=c("gray12","gray50","gray89"), levels = c(1010,1012,1016))
map(database="worldHires", add=TRUE, col="black", interior=TRUE)

##lo hago en grises
for (i in 1:12){
  k <- 6*i
  cols[i] <- paste("gray",k,sep ="")
}

image.plot(lon-360,rev(lats[1:55]),P[,55:1], breaks=brk, lab.breaks=names(brk), col=cols)
contour(lon-360,rev(lats[1:55]),P[,55:1], add=TRUE, col=c("gray12","gray50","gray89"), levels = c(1010,1012,1016))
map(database="worldHires", add=TRUE, col="black", interior=TRUE)

##lo hago en cian
rgbs <- cbind(12, seq(32,255, length=12), seq(32,255, length=12)) / 255
cols <- rgb(rgbs[,1], rgbs[,2], rgbs[,3]) 

image.plot(lon-360,rev(lats[1:55]),P[,55:1], breaks=brk, lab.breaks=names(brk), col=cols)
contour(lon-360,rev(lats[1:55]),P[,55:1], add=TRUE, col=c("gray12","gray50","gray89"), levels = c(1010,1012,1016))
map(database="worldHires", add=TRUE, col="black", interior=TRUE)

