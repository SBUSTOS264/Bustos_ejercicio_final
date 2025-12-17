# ============================================
# Ejercitación final integradora - Borges
# Lectura distante en R con tidytext
# ============================================

# Librerías
library(tidyverse)
library(tidytext)
library(readr)

# Ver directorio de trabajo
getwd()

# --------------------------------------------
# Lectura de los textos
# --------------------------------------------

archivos <- c(
  "Borges_biblioteca.txt",
  "Borges_senderos.txt",
  "Borges_tlon.txt"
)

textos <- tibble(archivo = archivos) %>%
  mutate(texto = map_chr(archivo, read_file))

# --------------------------------------------
# Tokenización
# --------------------------------------------

tokens <- textos %>%
  unnest_tokens(word, texto)

# --------------------------------------------
# Eliminación de stopwords (español)
# --------------------------------------------

stop_es <- stop_words %>%
  filter(lexicon == "snowball")

tokens_limpios <- tokens %>%
  anti_join(stop_es, by = c("word" = "word")) %>%
  filter(nchar(word) > 2)

# --------------------------------------------
# Frecuencias y visualización
# --------------------------------------------

frecuencias <- tokens_limpios %>%
  count(archivo, word, sort = TRUE)

top_palabras <- frecuencias %>%
  group_by(archivo) %>%
  slice_max(n, n = 10) %>%
  ungroup()

ggplot(top_palabras, aes(x = reorder(word, n), y = n)) +
  geom_col() +
  coord_flip() +
  facet_wrap(~ archivo, scales = "free_y") +
  labs(
    title = "Top 10 palabras más frecuentes en cuentos de Borges (sin stopwords)",
    x = "Palabra",
    y = "Frecuencia"
  )
