#Creador: Isaac Flores

#Analisis de datos de tiempo real
install.packages ('pacman')
library (pacman)
p_load ('readr', #para llamar a las bases de datos
        'dplyr') #para facilitar el manejo de datos

#Llamar la base de datos
datos_pcr <- read_csv(file = 'https://raw.githubusercontent.com/ManuelLaraMvz/Transcript-mica/main/Genes.csv')
head (datos_pcr)

#Obtencion de los genes referencia y de interes
actina <- datos_pcr %>%
slice (2)
actina
genes_interes <- datos_pcr %>%
slice (-1)
genes_interes

#Promediar los controles y los tratamientos
promedio_actina <- actina %>%
mutate (Mean_Cx= (C1+C2+C3)/3) %>%
mutate (Mean_Tx=(TI+T2+T3) /3)
promedio_actina
promedio_GI <- genes_interes %>%
mutate (Mean_Cx=(C1+C2+C3)/3) %>%
mutate (Mean_Tx=(TI+T2+T3)/3)
promedio_GI

#Analisis DCT
DCT <- promedio_GI %>%
mutate (DCT_Cx=(Mean_Cx-promedio_actina$Mean_Cx))%>%
mutate (DCT_Tx=(Mean_Tx-promedio_actinaSMean_Tx))
DCT

#Analisis DDCT
DOCT < - DCT %%
  mutate (DDCT=(DCT_TX-DCT_(x)) %>%
            mutate(12ppcT1_(2^(DncT)))
DOCT

#Guardar tabla
write. csV(DDCT, '2DDCT.csv', row. names = FALSE)
