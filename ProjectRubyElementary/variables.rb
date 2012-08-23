# Clases de variables

# $         --> Variable global
# @         --> Variable instancia
# [a-z] ó _ --> Variable local
# [A-Z]     --> Constante

# 1° VARIABLES GLOBALES
#Una variable global tiene un nombre que comienza con $. Se puede utilizar en cualquier parte de un programa. Antes
#de inicializarse, una variable global tiene el valor especial nil.

puts $foot = 5 

#Como es muy peligroso que las variables locales cambien de valor inadvertidamente
#se puede definir un procedimiento que se llame cada vez que se modifique el valor de la variable.
trace_var:$x, proc{print "$x es ahora ", $x, "\n"} 
$x = 10
$x = 200
$x = 5

#Cuando una varible funciona con un disparador se llama variable activa que se llama cada vez que se modifica.
#Son útiles, por ejemplo, para mantener un GUI actualizado
  
  
# 2° VARIABLES DEL SISTEMA
#$!       -->         Último mensaje de error
#$@       -->         Posición del error
#$_       -->         Última cadena leída con gets
#$.       -->         Último número de línea leído por el interprete
#$&       -->         Última cadena que ha coincidido con una expresión regular
#$~       -->         Última cadena que ha coincidido con una expresión regular como array de subexpresiones
#$n       -->         La n-ésima subexpresión regular de la última coincidencia (igual que $~[n])
#$=       -->         flag para tratar igual las mayúsculas y minúsculas
#$/       -->         Separador de registros de entrada
#$\       -->         Separador de registros de salida
#$0       -->         El nombre del fichero del guión Ruby
#$*       -->         El comando de la línea de argumentos
#$$       -->         El número de identificación del proceso del intérprete Ruby
#$?       -->         Estado de retorno del último proceso hijo ejecutado


# 3° VARIABLES DE INSTANCIAS
#Una variable de instancia tiene un nombre que comienza con @ y su ámbito está limitado al objeto al que referencia
#self

#Las variables de instancia en Ruby no necesitan declararse
class IntsTest
  def initialize(valor1, valor2)  
    print "El valor de la primera varible es instancia es :", @a = valor1, "\n"
    print "El valor de la primera varible es instancia es :", @b = valor2, "\n"
  end
  
  def saludar
    puts "Saludo al mundo en ingles #{@a} #{@b}"  
  end  
end

puts "VARIABLES DE INSTANCIAS"
puts "****************************"
#Paso de parametros en la instancia el metodo initialize se ejecuta de forma predeterminada
i = IntsTest.new("Hello","world")
i
i.saludar


puts "VARIABLES DE LOCALES"
puts "****************************"
# 4° VARIABLES DE LOCALES
#Una variable local tiene un nombre que empieza con una letra minúscula o con el carácter de subrayado (_). Las
#variables locales no tienen, a diferencia de las variables globales y las variables de instancia, el valor nil antes de la
#inicialización:

#Generalmente el ámbito de una variable local es uno de los siguientes:
#• proc{ ... }
#• loop{ ... }
#• def ... end
#• class ... end
#• module ... end

#En el siguiente ejemplo define? es un operador que verifica si un identificador está definido.
foo =44; print foo, "\n"; print defined? foo, "\n"
puts "****************************"
#Los objetos procedimiento que residen en el mismo ámbito comparten las variables locales que pertenecen a ese
#ámbito. En el siguiente ejemplo, la variable bar es compartida por main y los objetos procedimiento p1 y p2:
bar=0 #Si no definimos la variable local con 0 dara error en el proc. p2.call
p1 = proc{|n| print bar = n, "\n"}
p2 = proc{print bar, "\n"}

p1.call(5)
p2.call


#Una característica muy poderosa de los objetos procedimiento se deriva de su capacidad para recibir argumentos; las
#variables locales compartidas permanecen válidas incluso cuando se las pasa fuera de su ámbito original.
def box
  content = 15
  get = proc{print "Soy get ",content, "\n"}
  set = proc{|n| print "Soy set ", content=n, "\n"}
  return get, set
end
reader, writer = box
reader.call
writer.call(20)

#Ruby es especialmente inteligente con respecto al ámbito. En el ejemplo, es evidente que la variable contents está
#compartida por reader y writer. Ahora bien, es posible definir varios pares reader-writer que utilicen box cada uno
#de los cuales comparten su propia variable contents sin interferir uno con otro.
reader_1, writer_1 = box
reader_2, writer_2 = box
writer_1.call(99)
reader_1.call
reader_2.call









