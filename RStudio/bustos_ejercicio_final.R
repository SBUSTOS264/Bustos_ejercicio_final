# Ejercitación final integradora - Borges
# Lectura distante en R con tidytext

library(tidyverse)
library(tidytext)
library(readr)
# Ver dónde estoy trabajando
getwd()

# Leer los .txt (ajustá los nombres si los tuyos son distintos)
archivos <- c("Borges_biblioteca.txt", "Borges_senderos.txt", "Borges_tlon.txt")

textos <- tibble(archivo = archivos) %>%
  mutate(texto = map_chr(archivo, read_file))

textos
"C:/Users/…/Documents/…"




