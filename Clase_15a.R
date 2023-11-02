##Clase AGGREGATE

#mayor ventaja: calcular en funcion de grupos y para graficar. funciona SOLO para data.frame


#Usamos siguiente conjunto de datos de R
df <- chickwts
head(df)

#Funcion MEAN

group_mean <- aggregate(df$weight, list(df$feed), mean)
group_mean <- aggregate(weight ~ feed, data = df, mean) # Equivalente
group_mean

###esto sirve para separar x ej segun anios, meses, etc y aplicar la media ;)


#Funcion LENGTH
aggregate(chickwts$feed, by = list(chickwts$feed), FUN = length)


#PARA SEPARAR SEGUN VARIAS CATEGORIAS
set.seed(1)
cat_var <- sample(c("A", "B", "C"), nrow(df), replace = TRUE)
df_2 <- cbind(df, cat_var)

#Aplico la funcion "sum" teniendo en cuenta la categoria del feed y de cat_var
aggregate(df_2$weight, by = list(df_2$feed, df_2$cat_var), FUN = sum)

