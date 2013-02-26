#Accesores

#Las variables
#instancia de un objeto son sus atributos, eso que diferencia a un objeto de otro dentro de la misma clase 
#Es importante poder modificar y leer estos atributos; lo que supone definir métodos denominados accesores de atributos

class Fruta 
  def set_kind(entrada)
    @kind = entrada
  end
  
  def get_kind
    @kind
  end
end

f1 = Fruta.new
f1.set_kind("banana")

puts f1.get_kind

#Los siguientes son más breves y convencionales:
class Fruta2
  def kind=(k)
    @kind = k
  end
  def kind
    @kind
  end
end

f2 = Fruta2.new
f2.kind = "banana"
puts f2.kind

puts "------------------------------------------"
# 1 - El método inspect
class Fruta3
  def inspect(n)
    @kind = n
  "una fruta de la variedad " + @kind
  end
end 

f3 = Fruta3.new
print f3.inspect("Cranberries")


# 2 - Facilitando la creación de accesores

#--Abreviatura-----------------Efecto---------------------------------|
#                                                                     |
#attr_reader :v      -->        def v; @v; end                        |
#attr_writer :v      -->        def v=(value); @v=value; end          |
#attr_accesor :v     -->        attr_reader :v; attr_writer :v        |
#attr_accesor :v, :w -->        attr_accesor :v; attr_accessor :w     |
#---------------------------------------------------------------------|

puts "------------------------------------------"
class Fruta4
  attr_accessor :kind, :condition
  def inspect
  print "una ", @kind , " ", @condition
  end
end

f4 = Fruta4.new
f4.condition = "Anana", "Podrida"
f4.inspect








