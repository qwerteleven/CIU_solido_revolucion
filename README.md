# CIU_solido_revolucion

![](animation.gif)

```
Autor Leopoldo lopez reveron 
Escuela de ingeniería informática
Universidad de las palmas de Gran Canaria
```

# Requisitos

```
Disponer de processing

```

# Controles:
```
Click Izquierdo: para definir los vertices del perfil de la figura 

Control de Estado:
  
  Click Derecho: para finalizar la figura
                 Si ya existe una figura, se resetea el lienzo
  
```  

  
# Trabajo realizado
```
  Se ha desarrollado un creador de solidos de revolucion, mediante la herramienta processing, en la cual se han tenido en
  cuenta las siguientes características:
    
    - Recogida de puntos del perfil
    - Rotacion del perfil 
    - Creacion del solido mediante PShape usando TRIANGLE_STRIP
    
 ```   
    
# Decisiones adoptadas para la solución propuesta
```
  
  Las teclas de control se inspiran en la clase de presentacion de la practica
  
  La figura se dibuja sin relleno para ver la totalidad de triangulos generados y posibles 
  estructuras interiores
  
  Para el inicio y finalizacion del perfil, se completa añadiendo tanto por el final como el principio
  el punto mas cercano de la linea central divisoria
  
  Se permite el dibujado tanto por la derecha como por la izquierda, permitiendo de forma mas sencilla la 
  creacion de solidos dentro de solidos
  

```

# Referencias y herramientas utilizadas

  - ## Definición de especificación del proyecto
  - [Guion practica](https://ncvt-aep.ulpgc.es/cv/ulpgctp21/pluginfile.php/412240/mod_resource/content/37/CIU_Pr_cticas.pdf)




