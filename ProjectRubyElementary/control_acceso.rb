#Control de accesos

#Generaremos un clase con metodo que sera invisible para los usuario
class Util
  def times_two(a)
    print a," dos veces es :",engine(a),"\n"
  end
  
  def engine(b)
    b*2
  end
  #  Con private ocultamos el metodo
  private:engine
end
  
  

#Cuando un metodo se define fuera de una clase, el metodo pertence a la superclase Object

#-- Creamos el metodo square fuera de una clase
  def square(n)
    Math.sqrt(n)
  end
  
  
#-- Creamos una clase Mat para usar el metodo
  
  class Mat
    def oper_mat(x)
      puts square(x)
    end
  end
  
#-- Ejecutamos el metodo que ahora se encuentra en la clase Mat
Mat.new.oper_mat 625

#No se nos permite aplicar explícitamente el método a un objeto:
#     "fish".square(5) 