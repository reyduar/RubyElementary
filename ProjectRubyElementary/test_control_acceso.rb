require_relative 'control_acceso'

#Instanciamos la clase Util que tiene el metodo invisible
test = Util.new

#Usamos el metodo como tiene que se
test.times_two(6)

#Tratamos de usar el metodo privado engine
test.engine(6) #Genera un error : private method `engine' called for #<Util:0x1b12540> (NoMethodError)


