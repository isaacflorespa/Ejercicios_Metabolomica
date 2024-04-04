#Creador: Isaac Flores

#Gráfica de dispersión
install.packages("pacman")
library(pacman)
p_load("readr","ggplot2","dplyr")
datos<-read_csv(file = "https://raw.githubusercontent.com/ManuelLaraMVZ/Transcript-mica/main/datos_miRNAs.csv")
head(datos)

control<-datos %>%
  filter(Condicion=="Control")
head(control)
promedios_control<-control %>%
  summarise(Mean_C1=mean(Cx1),
            Mean_C2=mean(Cx2),
            Mean_C3=mean(Cx3),
            Mean_T1=mean(T1),
            Mean_T2=mean(T2),
            Mean_T3=mean(T3)) %>%
mutate(Gen="Controles") %>%
  select(7,1,2,3,4,5,6)
promedios_control

genes<-datos %>%
  filter(Condicion=="Target") %>%
  select(-2)
genes

DCT<-genes %>%
  mutate(DCT_C1=2^-(Cx1-promedios_control$Mean_C1),
         DCT_C2=2^-(Cx2-promedios_control$Mean_C2),
         DCT_C3=2^-(Cx3-promedios_control$Mean_C3),
         DCT_T1=2^-(T1-promedios_control$Mean_T1),
         DCT_T2=2^-(T2-promedios_control$Mean_T2),
         DCT_T3=2^-(T3-promedios_control$Mean_T3)) %>%
  select (-2,-3,-4,-5,-6,-7)
DCT

promedios_DCT<-DCT%>%
  mutate(Mean_DCT_Cx=(DCT_C1+DCT_C2+DCT_C3)/3,
         Mean_DCT_Tx=(DCT_T1+DCT_T2+DCT_T3)/3)
promedios_DCT

grafica_puntos <- ggplot(promedios_DCT,
                         mapping = aes(x=Mean_DCT_Cx, y=Mean_DCT_Tx),
                         colour=cut)+
  geom_point(size = 3, color="blue")+
  labs(title = "Análisis de puntos",
       x="condicion de control (2^-DCT)",
       y="Tratamiento (2^-DCT)"+
         geom_smooth(method="lm",
                     alpha=0.5,
                     linewidth=1, span=1)+
         theme_minimal())
grafica_puntos
guardar<-ggsave(filename ="graficadispersion.jpeg",
                   plot=grafica_puntos,
                   width= 6, heigth=4,
                   dpi=600,)
guardar
