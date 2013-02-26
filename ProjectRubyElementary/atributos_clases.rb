#Si queremos declarar atributos legibles, los
#podemos declarar usando la palabra clave attr_reader:

class Perro # nombre de la clase
  attr_reader :nombre, :edad, :color #atributos legibles
  attr_writer :edad #atributo escribible
  
  # metodo para inicializar
  def initialize(nombre, edad, color) 
    @nombre = nombre # @nombre
    @edad = edad # @edad
    @color = color # @color ... variables internas
  end
  
  def inspect
     print "El perro se llama ", @nombre , " es de color ", @color, " tiene ", @edad
  end

  #Para hacer legible y/o escribible de la variable @nombre se hace un metodo
  def nombre # propiedad publica legible
    @nombre # retorna el nombre
  end
  
  def nombre=(nombreNuevo) # metodo para hacerlo escribible
    @nombre = nombreNuevo # modifica el nombre
  end
end


f = Perro.new("fifi", 5, "gris")
f.inspect
