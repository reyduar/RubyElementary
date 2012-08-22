require_relative 'redefinicion_metodo'

#-- Instanciamos la superclase Humano y usamos el metodo identidad
Humano.new.identidad

#-- Instanciamos la subclase Estudiante y usamos el metodo identidad 
Estudiante.new.identidad

#-- Instanciamos la subclase Estudiante2 mejorada y usamos el metodo identidad 
Estudiante2.new.identidad

#-- Instanciamos la subclase deshonesto y usamos el metodo tarifa_tren le pasamos 25 años
Deshonesta.new.tarifa_tren(25)

#-- Instanciamos la subclase honesto y usamos el metodo tarifa_tren le pasamos 25 años
Honesta.new.tarifa_tren(25)