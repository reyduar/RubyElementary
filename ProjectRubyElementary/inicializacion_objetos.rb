#Inicialización de objetos

#Ruby tiene un mecanismo para asegurar que las
#variables instancia se inicialicen siempre

# 1 - El método initialize
#Siempre que Ruby crea un objeto nuevo, busca un método llamado initialize y lo ejecuta

class Fruta
  def initialize
    @kind = "manzana"
    @condition = "madura"
  end
  
  def inspect
  "una " + @kind + " " + @condition
  end
end

fruta = Fruta.new
puts fruta.inspect #Ahora podemos utilizar el metodo inspect sin problema

# 2 - Modificando suposiciones por requisitos
#Para hacer esto se debe añadir un argumento formal al método initialize
class Fruta2
  def initialize(k)
    @kind = k
    @condition = "madura"
  end
  
  def inspect
  "Una " + @kind + " " + @condition
  end
end
f2 = Fruta2.new("pera") 
puts f2.inspect


puts "------------------------------------------------------"
# 3 - Inicialización flexible
class Fruta3
  def initialize(k="manzana")
    @kind = k
    @condition = "madura"
  end
  
  def inspect
  "Una " + @kind + " " + @condition
  end
end
f3 = Fruta3.new("Naranja") #Se le puede pasar el parametro
puts f3.inspect

f3 = Fruta3.new #Y si no se lo pasamo tomara el predeterminado k="manzana"
puts f3.inspect




