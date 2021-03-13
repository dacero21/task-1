#==============================================================================#
# Autores: David Acero Acero: 201228148 Andres Cembrano:201630829 Jorge Lozano: 201816744
# Colaboradores:
# Fecha elaboracion:05 de marzo de 2021
# Ultima modificacion: 13 de marzo de 2021
# Version de R: 4.0.3
#==============================================================================#
rm(list = ls()) # Limpiar el ambiente 
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

#3.2 Descriptivas
#Tabla
base_stats=dplyr::select(base_final,ESC, P6020, P6160, P6170, P6040, P6050 ) #Se crea un subset con las variables de interes
print(summary(base_stats)) #Imprime estadisticas de las variables escogidas




#Graficas

h_ingreso=ggplot() + geom_histogram(data=base_final, aes(x=P6500, group=P6020, colour=P6020, fill=P6020)) + theme_light() + labs(title = "Histograma de Ingresos Hombres y Mujeres",
                                                                                                                                 caption="Hombres en Azul Oscuro  y Mujeres en Azul Claro", 
                                                                                                                                 y="Numero de personas",
                                                                                                                                 x="Ingreso" )
h_ingreso
ggsave(plot=h_ingreso, file="views/Histograma Ingreso.jpeg")


h_escolaridad=ggplot() + geom_histogram(data=base_final, aes(x=ESC, group=P6020, colour=P6020, fill=P6020)) + theme_light() + labs(title = "Histograma de Años de Escolaridad",
                                                                                                                                   caption="Hombres en Azul Oscuro  y Mujeres en Azul Claro", 
                                                                                                                                   y="Numero de personas",
                                                                                                                                   x="Anos de escolaridad" )
h_escolaridad
ggsave(plot = h_escolaridad, file="views/Histograma Escolaridad.jpeg")

h_edad=ggplot() + geom_histogram(data=base_final, aes(x=P6040, group=P6020, colour=P6020, fill=P6020)) + theme_light() + labs(title = "Histograma de Edad Hombres y Mujeres",
                                                                                                                              caption="Hombres en Azul Oscuro  y Mujeres en Azul Claro", 
                                                                                                                              y="Numero de personas",
                                                                                                                              x="Edad" )
h_edad
ggsave(plot=h_edad, file="views/Histograma Edad.jpeg")

esc_ing= ggplot(base_final, aes(x=ESC, y=P6500)) + geom_point(color="#69b3a2")+geom_smooth(method = lm,color="red", se=F) + theme_light() + labs(title = "Diagrama de dispercion Anos de Escolaridad e Ingreso",
                                                                                                                                                 y="Ingreso",
                                                                                                                                                 x="Anos de Escolaridad")
esc_ing
ggsave(plot = esc_ing, file="views/Dispercion Esc_Ing.jpeg")

esc_edad= ggplot(base_final, aes(x=P6040, y=P6500)) + geom_point(color="#69b3a2")+geom_smooth(method = lm,color="red", se=F) + theme_light() + labs(title = "Diagrama de dispercion Edad e Ingreso",
                                                                                                                                                    y="Ingreso",
                                                                                                                                                    x="Edad")
esc_edad
ggsave(plot = esc_edad, file="views/Dispercion Esc_Edad.jpeg")
