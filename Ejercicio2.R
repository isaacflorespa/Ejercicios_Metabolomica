# Isaac Flores Patiño
# Llamar bases de datos

#Desde la computadora
install.packages("readr")
library(readr)
titulacion<- read_csv("Documents/Ejercicio R/datos_titulacion (2).csv")

#Desde internet
repositorio<- read_csv(file="https://raw.githubusercontent.com/ManuelLaraMVZ/titulacion_amino_acidos/main/datos_titulacion%20(2).csv")
head(repositorio)
View(repositorio)

#Grafica de puntos
install.packages("ggplot2")
library(ggplot2)
grafica<-ggplot(titulacion,aes(x=Volumen, y=pH))+
  geom_point()+
  labs(title="Titulacion de cisteina I")
grafica
library(ggplot2)
ggsave(filename = "titulación_puntos.jpeg", plot = grafica, width = 6, height = 4, dpi = 500)


#Grafica de líneas
grafica2<-ggplot(titulacion,aes(x=Volumen, y=pH))+
  geom_line()+
  labs(title="Titulacion de cisteina II")
grafica2
ggsave(filename = "titulación_lineas.jpeg", plot = grafica2, width = 6, height = 4, dpi = 500)

