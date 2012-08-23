#Procesamiento de excepciones: rescue
#Estrcutura:

# begin
#    # ... procesamos la entrada ...
# rescue
#    # ... aquí tratamos cualquier otra excepción
# end

#Un programa en ejecución puede encontrarse con problemas inesperados. Podría no existir un fichero que desea leer,
#al salvar algunos datos se podría llenar un disco, un usuario podría introducir algún tipo de datos de entrada poco
#adecuados.

def first_line( filename )
  begin
    file = open(filename)
    info = file.gets
    file.close
    info # Lo último que se evalúa es el valor devuelto
  rescue
    print "Erro: No puedo leer el fichero, luego no devuelvo una cadena \n"
    nil
  end
end

first_line("xxx")
print "**************************************************\n"
#A continuación, si el fichero no existe, se prueba a utilizar la
#entrada estándar:
begin
  file = open("algun_fichero")
rescue
  file = STDIN
end

#Dentro del código de rescue se puede utilizar retry para intentar de nuevo el código en begin. Esto nos permite
#reescribir el ejemplo anterior de una forma más compacta:
fname = "filename"
begin
  file = open(fname)
  print "Ahora lo encontre el archivo tiene el siguiente texto en su contenido: \n"
  # ... procesamos la entrada ...
  File.open(fname, 'r') do |f1|
    while linea = f1.gets
      puts linea
    end
  end
rescue
  fname = "archivo.txt"
  retry
end

print "**************************************************\n"
#Para lanzar una excepción utilizamos raise
begin
 raise "error"
rescue
  print "Ha ocurrido un error: ", $!, "\n"
end

#Se puede acceder a él posteriormente a través de la variable global
#especial $!.

