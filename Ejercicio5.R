#Creador: Isaac Flores

# Se realiza una serie de experimentos comparativos de cerebros de tres animalesdestetados cuyas madres estuvieron expuestas a una dieta restrictivas (desnutridas) y se compararon con tres animales cuyas madres se expusieron a una dieta ad libitum (eunutridas). Se desea saber: ¿Qué miRNAs fueron los que más cambiaron entre los animales desnutridos (tratamiento) comparados con los animales eunutridos (control)?
install.packages("pacman")
library(pacman)
p_load("readr", "ggplot2", "dplyr", "ggrepel")
library(ggplot2)

datos <- read_csv(file = "https://raw.githubusercontent.com/ManuelLaraMVZ/Transcript-mica/main/DesnutridasvsEunutridas.csv")
head(datos)

control <- datos %>%
  filter(Condicion == "Control")
head(control)

promedios_control <- control %>%
  summarise(
    Mean_C1 = mean(Cx1),
    Mean_C2 = mean(Cx2),
    Mean_C3 = mean(Cx3),
    Mean_T1 = mean(T1),
    Mean_T2 = mean(T2),
    Mean_T3 = mean(T3)
  ) %>%
  mutate(Gen = "Controles") %>%
  select(Gen, everything())
promedios_control

genes <- datos %>%
  filter(Condicion == "Target") %>%
  select(-Condicion)
genes

DCT <- genes %>%
  mutate(
    DCT_C1 = 2^-(Cx1 - promedios_control$Mean_C1),
    DCT_C2 = 2^-(Cx2 - promedios_control$Mean_C2),
    DCT_C3 = 2^-(Cx3 - promedios_control$Mean_C3),
    DCT_T1 = 2^-(T1 - promedios_control$Mean_T1),
    DCT_T2 = 2^-(T2 - promedios_control$Mean_T2),
    DCT_T3 = 2^-(T3 - promedios_control$Mean_T3)
  ) %>%
  select(-starts_with("Mean"))
DCT

promedios_DCT <- DCT %>%
  mutate(
    Mean_DCT_Cx = (DCT_C1 + DCT_C2 + DCT_C3) / 3,
    Mean_DCT_Tx = (DCT_T1 + DCT_T2 + DCT_T3) / 3)
promedios_DCT

grafica_puntos <- ggplot(promedios_DCT,
                         aes(x = Mean_DCT_Cx, y = Mean_DCT_Tx)) +
  geom_point(size = 3, color = "blue") +
  labs(
    title = "Análisis de puntos",
    x = "Condición de control (2^-DCT)",
    y = "Tratamiento (2^-DCT)"
  ) +
  geom_smooth(method = "lm", formula = y ~ x, color = "black", se = FALSE) +
  theme_minimal()

grafica_puntos

guardar <- ggsave(
  filename = "graficadispersion.jpeg",
  plot = grafica_puntos,
  width = 6,
  height = 4,
  dpi = 600)
guardar

top_10 <- promedios_DCT %>%
  select(Gen, Mean_DCT_Cx, Mean_DCT_Tx)

grafica_puntos2 <- grafica_puntos +
  geom_label_repel(
    data = top_10,
    aes(label = Gen),
    label.padding = unit(0.2, "lines")) +
  theme_minimal()
grafica_puntos2 


