# Veamos primero cómo abrir un archivo existente, y cómo leer su contenido:
class LecturaArchivo
  archivo="archivo.txt" # el nombre en una variable si lo usamos varias veces
  if File.exists?(archivo) # nos aseguramos de que exista
    f = File.open(archivo) # abrimos el archivo datos.txt
    f.each do |linea| # procesamos cada linea como un arreglo
      puts "#{f.lineno}: #{linea}" # imprimimos numero y linea/ con lineno no da el numero de linea
    end
    f.close # lo cerramos al final del proceso
  else
    puts "#{archivo} no existe" # reportamos un error si no existe
  end
end

puts "\n"
puts "Lectura de archivos con IO"
puts "--------------------------"
#Otra alternativa es leer todo el contenido del archivo y guardarlo en un arreglo, con el método
#IO.readlines():
class LeerArchivoIO
  archivo="archivo.txt" # nombre del archivo
  if File.exists?(archivo) # nos aseguramos de que exista
    yoFile = File.open(archivo) # abrimos el archivo datos.txt
    yoArray = yoFile.readlines(archivo) # lo leemos y asignamos a un arreglo
    yoFile.close # una vez leido, ya lo podemos cerrar
    yoArray.each do |linea| # ahora procesamos cada linea del arreglo
      puts "#{linea}" # imprimimos la linea
    end
  else
    puts "#{archivo} no existe" # reportamos un error si no existe
  end
end

puts "\n"
puts "Lectura-Escritura de archivos"
puts "--------------------------"

#Si queremos leer una línea a la vez, usamos el método IO.read(): linea = f.read(archivo)
#Para leer una línea en particular, podemos usar la propiedad IO.lineno:
#f.lineno = 1000 # va a la linea 1000
#linea = f.gets # la lee y asigna a una variable

#Ahora, vamos a crear un archivo, le escribimos datos, y lo cerramos:
class EscribirArchivos
  archivo2 = "archivo2.txt"        # nombre en variable para uso frecuente
  f = File.new(archivo2, "w")       # abrimos el archivo nuevosdatos.txt si no existe lo crea
  f.puts("linea con texto")         # escribe una linea de texto al archivo
  pi = Math::PI
  f.print("pi aproximado ",pi,"\n") # otra forma de escribir al archivo
  e = Math::E
  f.write("e vale " + e.to_s + "\n")# otra forma de escribir al archivo
  f.close
  f = File.open(archivo2) # abrimos el archivo datos.txt
  f.each do |linea| # procesamos cada linea como un arreglo
    puts "#{f.lineno}: #{linea}" # imprimimos numero y linea
  end
  f.close # lo cerramos al final del proceso
end

#Como muestra el ejemplo anterior, el método File.new() permite crear archivos. El primer
#parámetro es el nombre del archivo, y el segundo parámetro es el modo de apertura. La tabla
#siguiente muestra los modos de apertura disponibles:

=begin
|--------------------------------------------------------------------------------------------------------------
| Modo                                  Significado
|--------------------------------------------------------------------------------------------------------------
| r     -->   Sololectura; comienza desde el principio del archivo (default).
| r+    -->   Lectura/Escritura: comienza desde el principio del archivo.
| w     -->   Soloescritura: trunca el archivo si existe, o crea uno nuevo para escritura.
| w+    -->   Lectura/Escritura: trunca el archivo si existe, o crea uno nuevo para lectura/escritura.
| a     -->   Soloescritura: comienza desde el final del archivo si existe, o lo crea nuevo para escritura.
| a+    -->   Lectura/Escritura: comienza desde el final del archivo si existe, o lo crea nuevo para lectura/escritura.
| b     -->   (Solo en Windows). Modo binario, y se puede combinar con cualquiera de las letras anteriores.
|--------------------------------------------------------------------------------------------------------------
=end