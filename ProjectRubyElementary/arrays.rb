#Arrays

#Se pueden crear un array listando elementos entre corchetes ([ ]) y separándolos por comas. Los arrays en Ruby
#pueden almacenar objetos de diferentes tipos.

a = [ "Jairo", "y", "Orfa", "se", "quedan", "en", "casa" ]
puts a.size   # el número de elementos en la lista
puts a[2]

#Para alterar una lista, podemos añadir elementos al final:
puts b = "viendo la television".split #parte el string en array de palabras
puts a.concat(b) #  ["Jairo", "y", "Orfa", "se", "quedan", "en", "casa","viendo", "la", "television"]

#Otras funciones prácticas con arreglos:
puts a.first                # accesa el primero
puts a.last                 # accesa el ultimo
puts a.empty?               # pregunta si esta vacia

#Un arreglo complejo puede tener otros arreglos adentro:
puts c = [1, 2, 3, [4, 5, [6, 7, 8], 9], 10]

#Para “aplanarlo” usar la función flatten:
#puts c.flatten  #[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

#Para insertar elementos se usa la función insert(índice, valor):
c.insert(3, 99) # [1, 2, 3, 99, 4, 5, 6, 7, 8, 9, 10]
#Para invertir el orden de un arreglo, se usa la función reverse:
["a", "b", "c"].reverse  # ["c", "b", "a"]
#Para ordenar un arreglo, usar la función sort:
["p", "z", "b", "m"].sort  #["b", "m", "p", "z"]

#Pop y push, remueven y añaden (respectivamente) elementos hacia el final del arreglo:
d=["Mozart", "Liszt", "Monk"]
d.pop                   #Remueve "Monk"
puts d
puts d.push("Bach")         #Agrega un elemento ["Mozart", "Liszt", "Bach"]
puts d.unshift("Beethoven")  #Agrega un elemento ["Beethoven", "Mozart", "Liszt", "Bach"]

puts "------------------------------------------------------------"
#Para concatenar los elementos de un arreglo produciendo una cadena:
x=[1,2,3]
puts x.join(":") # "1:2:3"
str = x.join(":")
puts str.split(":")