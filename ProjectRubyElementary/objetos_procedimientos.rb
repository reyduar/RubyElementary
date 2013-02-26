#Objetos procedimiento

#A menudo es deseable tener la posibilidad de deﬁnir respuestas especíﬁcas a sucesos inesperados. Resulta que esto
#se consigue con gran sencillez si podemos pasar un bloque de código a otros métodos, lo que signiﬁca que deseamos
#tratar el código como si fuesen datos

#Un objeto procedimiento nuevo se obtiene utilizando proc:

quuxx = proc{
  print "QUUXQUUXQUUX!!!\n"
} 

#Ahora quux referencia a un objeto y como las mayoría de los objetos, tiene un comportamiento que se puede invocar.
#Concretamente, podemos pedir que se ejecute a través de su método call
  
quuxx.call


#Creamos otro proc.
mi_procedimiento = proc{
  print "Ejecuto sentencias y realizo la operaciones que quieras donde quieras!!!\n"
} 

#Luego, después de todo esto. ¿Podemos utilizar quux cómo un argumento de un método? Ciertamente.
def run (p)
  print "Vamos a llamar a un procedimiento...\n"
  p.call
  print "Finalizado..\n"
end

#Ejecutamos el metodo y le pasamos como parametro el nombre del proc.
run mi_procedimiento