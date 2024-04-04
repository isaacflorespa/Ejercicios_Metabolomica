2+2
2^(-4)
Suma<-2+2 
Suma
2+Suma
CHO<- 535000
VERO<-1350000
Total<-CHO+VERO
Total
#hola
x<-35
y<-22
w<-34
z<-22
x+y
w+z

V1<-c(1,2,3)
V2<-c(4,5,6)
V3<-c(7,8,9)

DT_V<-data.frame("V4",V1,V2,V3)
View(DT_V)

install.packages("readr")
library(readr)

library(readr)
datos_titulacion_2_ <- read_csv("Documents/Ejercicio R/datos_titulacion (2).csv")
View(datos_titulacion_2_)

library(readr)
titulacion <- read_csv(file="https://raw.githubusercontent.com/ManuelLaraMVZ/titulacion_amino_acidos/main/datos_titulacion%20(2).csv")
head(titulacion)

install.packages("ggplot2")
library(ggplot2)
grafica<-ggplot(titulacion,aes(x=Volumen, y=pH))+
  geom_point()+
  labs(title = "Titulacion de aminoacidos")
grafica
                
