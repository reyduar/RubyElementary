# El operador :: indica al intérprete de Ruby qué módulo debe consultar para obtener el valor de la constante 
puts Math.sqrt(2)
puts Math::PI

#Si queremos referenciar a los métodos
#o constantes de un módulo, directamente, sin utilizar ::, 
#podemos incluir ese módulo con include:

#Podemos utilizar include para utilizar los valores de sus constantes y ejecutar
#sus metodos directamente
include Math
puts sqrt(2)
puts PI

