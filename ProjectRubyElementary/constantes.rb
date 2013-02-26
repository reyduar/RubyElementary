#Constantes
#Una constante tiene un nombre que comienza con una letra mayúscula. Se le debe asignar valor sólo una vez. En la
#implementación actual de Ruby, reasignar un valor a una constante genera un aviso y no un error (la versión no ANSI
#de eval.rb no informa de este aviso):

# Creamos una clase para definir constantes
class ConstClass
  Constante1 = 101
  Constante2 = 103
  Constante3 = 102
  def show
    print Constante1," ",Constante2," " ,Constante3, "\n" 
  end
end

#Las constantes de una clase se extraen asi ::
puts ConstClass::Constante1
#Intanciamos la clase usamos el metodo show para imprimir sus valores
ConstClass.new.show


# Las constantes también se pueden definir en un módulo.
module ConstModulo
  C1 = 201
  C2 = 202
  C3 = 203
  def showContants
    print C1, " ",C2, " ", C3, "\n"
  end
end

# Para poder llegar a los valores del modulo usamos
include ConstModulo 
puts C1

# Para un modulo llamamos directamente al metodo
  showContants
  
C1=99 # realmente una idea no muy buena
puts C1
  
puts ConstModulo::C1 # La constante del módulo queda sin tocar ...

  





