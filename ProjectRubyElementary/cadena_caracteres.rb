#Cadenas

#Ruby maneja tanto cadenas como datos numéricos. Las cadenas pueden estar entre comillas dobles("...") o comillas
#simples (’...’).

#Comillas simples y comillas dobles
 puts "Este es un ejemplo de String \n con comillas dobles"
 puts 'Con comillas simples no se puede usar caracteres especiales como (\n)'
 
# Como se vio en la lección anterior, los enteros y los reales también se pueden convertir a cadenas:
i = 5           # valor entero
i.to_s          # cadena
r = 3.14        # valor real
r.to_s          # cadena
#Alternativamente, las cadenas se pueden convertir a números:
"123".oct         # cadena octal a entero
"0x0a".hex        # cadena hexadecimal a entero
"123.45e1".to_f   # convierte a real
"1234.5".to_i     # convierte a entero
"0a".to_i(16)     # convierte desde hexadecimal
"1100101".to_i(2) # convierte desde binario

#La notación especial #{} reemplaza el valor de una variable dentro de una cadena:
edad=25
puts "La edad es :#{edad}"
puts "La edad es :"+edad.to_s   #es equivalente
print "La edad es : ",edad.to_s, "\n" #usamos print para imprimir y las (,) para concatenar 

#Otras funciones sobre cadenas son:
s = "ja"
puts s * 3               # una cadena con tres copias concatenadas
puts s + "ji"            # el signo + se usa para concatenar cadenas
z = "za"
puts z == s              # el contenido de las cadenas es distinto
  
y = "ab"
puts y << "cde"   # append: concatena al final de la cadena
puts y.length     # el número de caracteres en la cadena

#Funciones relacionadas con letras minúsculas y mayúsculas:
puts y.upcase                   #Mayusculas
puts "MN".downcase              #Minusculas
puts "AzmmA".swapcase           #Contrario 
puts "ruby".capitalize #Mayuscula capital

puts "-------------------------------------------------------"
#Las letras de la cadena se pueden accesar individualmente poniendo un índice entre paréntesis
#rectangulares [idx]: (el primer elemento tiene índice cero)
mi_cadena = "abcdefgi"
puts mi_cadena
puts mi_cadena[0].chr        #retorna el código del caracter en la posición 0, "a"
puts mi_cadena[1].chr        #retorna el código del caracter en la posición 1, "b"

#Al asignar un valor a una cadena con índice, se cambia el caracter en esa posición:
mi_cadena[0] = "z" #Reemplaza valor de la posicion
puts mi_cadena
#Para insertar y borrar letras de la cadena:
puts mi_cadena.delete("z") #Borra la coincidencia
puts mi_cadena.insert(2,"x") #parametro es (posicion, valor)
puts mi_cadena.reverse #invierte contenido




