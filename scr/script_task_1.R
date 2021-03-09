# Task 1 taller de R - Taller tipo A
#) Integrantes
# David Acero Acero: 201228148

pacman::p_load(tidyverse,readxl,haven,xlsx) #Cargar los paquetes necesarios 

#1. Vectores. 

vector_1_100=c(1:100) #Crear el vector vector_1_100 con los numeros del uno al cien.
vector_impar=seq(1,99,by = 2) #Crear el vector vector_impar cocon los números impares del uno al 99.
vector_par=vector_1_100[-vector_impar] #Crear el vector vector_par a partir de los primeros dos vectores.

#2. Limpiar una base de datos. 

cultivos <- read_excel("data/input/cultivos.xlsx",range = "A9:Y362") # Importar la base de datos 
cultivos = cultivos[-c(which(is.na(cultivos$DEPARTAMENTO))),] #Eliminar las filas de totales pues están lelnas de NA
cultivos=gather(cultivos,"Año","Hectareas de coca",5:25) #Pivotar la base de datos para que tenga un formato long
cultivos$`hectareas de coca`=replace(cultivos$`hectareas de coca`,which(is.na(cultivos$`hectareas de coca`)),0) #Remplazar los valores de NA por ceros en la columna de hectareas de coca

#3. GEIH

#3.1 Importarar y unir bases 

caracteristicas=readRDS("data/input/2019/Cabecera - Caracteristicas generales (Personas).rds") #Importar la base de caracteristicas
ocupados=readRDS("data/input/2019/Cabecera - Ocupados.rds") #Importar la base de ocupados
base_final=merge(caracteristicas,ocupados,by = c("directorio","secuencia_p","orden")) #Unificar las bases caracteristicas y ocupados
