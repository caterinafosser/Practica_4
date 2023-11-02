##Graficos de barras, histogramas, boxplots

setwd("/home/clinux01/Escritorio/Labo_Cate/Practica_4")

library(ggplot2)
library(lubridate)

gualeguaychu <- read.csv("gualeguaychu.csv")
head(gualeguaychu)

gualeguaychu <- gualeguaychu[year(gualeguaychu$Fecha) >= 2010 & year(gualeguaychu$Fecha) <= 2018,]

gualeguaychu_2018 <- gualeguaychu[year(gualeguaychu$Fecha) == 2018,]

p <- ggplot(data = gualeguaychu_2018, mapping = aes(x=month(Fecha), y=pre))
p<- p + geom_col()
p <- p + labs(title = "Precipitación mensual acumulada 2018",
              subtitle = "Estación: Gualeguaychu",
              x = "Mes",
              y = "Precipitación (mm)")
p <- p + scale_x_continuous(breaks = c(1:12))
p


gualeguaychu$year <- year(gualeguaychu$Fecha)
gualeguaychu$month <- month(gualeguaychu$Fecha)
suma_PP_mensual <- aggregate(x=gualeguaychu$pre,by=list(gualeguaychu$year,gualeguaychu$month),FUN="sum")
colnames(suma_PP_mensual) <- c("Year", "Month", "Precip")

suma_PP_mensual$Fecha<- paste(suma_PP_mensual$Year,suma_PP_mensual$Month,sep="-") ##hago esto para poder graficar, sino hay varios valores x anio

p<- ggplot(suma_PP_mensual, aes(x=Fecha, y=Precip)) +
  geom_col(aes(fill = factor(Year)), position = "dodge") +
  labs(title = "Precipitación mensual en Gualeguaychu",
       x = "Mes",
       y = "Precipitación [mm]",
       fill = "Year")


p<-ggplot(suma_PP_mensual, aes(Month, Precip)) +
  geom_col() +
  facet_wrap(~Year, ncol =4) +
  labs(title = "Precipitación mensual en Gualeguaychu",
       x = "Mes",
       y = "Precipitación [mm]") + scale_x_continuous(breaks =seq(1,12,1))


##histograma

p<-ggplot(gualeguaychu, mapping = aes(x=pre))+
  geom_histogram()


precip_gualeguaychu<- gualeguaychu[gualeguaychu$pre>0, ]
p <-ggplot(data = precip_gualeguaychu ,aes(pre))
p <- p + geom_histogram(breaks= seq(0,200,10), fill= "blue", col= "black")
p <- p + labs(title = "Histograma de precipitación diaria en Gualeguaychu",
              subtitle = "Periodo 2000-2010",
              x = "Precipitación (mm)",
              y = "Frecuencia")

##Box plot
box <-ggplot(data = precip_gualeguaychu ,aes(y= pre))
box <- box + geom_boxplot(outlier.colour = "black", outlier.size = 1, notch = TRUE,fill = "#E69F00")
box <- box + labs(title = "Boxplot de precipitación diaria en Gualeguaychu",
                  subtitle = "Periodo 2000-2010",
                  y = "Precipitación (mm)")
box <- box + stat_boxplot(geom = "errorbar") +xlim(c(-2, 2))
