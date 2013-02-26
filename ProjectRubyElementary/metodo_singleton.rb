#Métodos singleton
#En Ruby se puede asignar a cada OBJETO sus propios métodos.

#-- Creamos la superclase SingletonTest
class SingletonTest
  def size
    print "25\n"
  end
end

#-- Creamos la instancia de la clase para diferentes test
test1 = SingletonTest.new
test2 = SingletonTest.new

#-- Ahora redefinimos el metodo size de test2
 def test2.size
   print "10\n"
 end
 
 #-- Ejectamos los metodos
 test1.size
 test2.size
 