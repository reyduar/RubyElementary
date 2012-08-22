#Redeﬁnición de métodos
#En una subclase se puede modiﬁcar el comportamiento de las instancias redeﬁniendo 
#los métodos de la superclase.

#-- Creamos la Superclase Humano
class Humano
  def identidad
    print "Soy una persona\n"
  end
  
  def tarifa_tren(edad)
    if edad < 12
      puts "Tarifa reducida. Con anos de edad: #{edad}"
    else
      puts "Tarifa normal. Con anos de edad : #{edad}"
    end
  end
end

#-- Creamos la subclase Estudiante
class Estudiante<Humano
  def identidad
    print "Soy estudiante.\n"
  end
end

#Supongamos que en vez de reemplazar el método identidad lo que queremos es mejorarlo. 
#Para ello podemos utilizar super

#-- Creamos la subclase Estudiante 2 donde usamos super para heredar el codigo de la Superclase
class Estudiante2<Humano
  def identidad
    super
    print "Tambien soy estudiante.\n"
  end
end

#super nos permite pasar argumentos al método original. Se dice que hay dos tipos de personas ...

#Creamos la subclase Deshonesta
class Deshonesta<Humano
  def tarifa_tren(edad)
    super(11) #Quiero una tarifa barata
  end
end

#Creamos la subclase Deshonesta
class Deshonesta<Humano
  def tarifa_tren(edad)
    #Quiero una tarifa barata por lo tanto siempre se ejecuta el metodo con 11 
    #y no con el parametro de edad que recibe.
    super(11) 
  end
end


#Creamos la subclase Deshonesta
class Honesta<Humano
  def tarifa_tren(edad)
    #Pasa el valor de la edad a la superclase para que calcule honestamente la tarifa
    #y no con el parametro de edad que recibe.
    super(edad) 
  end
end
