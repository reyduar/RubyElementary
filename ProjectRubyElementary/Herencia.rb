#-- Creamos la clase Padre mamifero
class Mamifero
  def respirar
    print "Inhala y exhala\n"
  end
end

#--Creamos la clase gato y hacemos que herede de Mamifero
class Gato<Mamifero
  def maulla
    print "miauuuuuuuuuroowwwww\n"    
  end
end

#Existen situaciones donde ciertas propiedades de las superclases no deben heredarse por una determinada 
#subclase.
#Aunque en general los pájaros vuelan, los pingüinos es una subclase de los pájaros que no vuelan.

#-- Creamos la clase Padre Pajaro
class Pajaro
  def aseo
    print "Me limpio las plumas con el piquillo\n"
  end
  
  def vuela
    print "Estoy volando\n"
  end
end

#--Creamos la clase pinguino y hacemos que herede de Pajaro
class Pinguino<Pajaro
  def vuela
    print "Soy un pinguino no vuelo\n"    
  end
end


#En vez de deﬁnir exhaustivamente todas las características de cada nueva clase, lo 
#que se necesita es añadir o re-deﬁnir las diferencias entre cada subclase y superclase. 
#Esta utilización de la herencia se conoce como programación
#diferencial. Y es uno de los beneﬁcios de la programación orientada a objetos.