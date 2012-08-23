#Procesamiento de excepciones: ensure
#Que es desgarbada y se nos escapa de las manos cuando el código se vuelve más complicado debido a que hay que
#tratar todo return y break.
#Por esta razón se añadió otra palabra reservada a esquema begin ... rescue ... end, ensure. El bloque de código de
#ensure se ejecuta independientemente del éxito o fracaso del bloque de código en begin.

#Estructura:
begin
file = open("/tmp/algun_fichero","w")
# ... Escribimos en el fichero ...
rescue
# ... gestionamos las excepciones ...
ensure
file.close # ... Y esto se ejecuta siempre.
end

#Se puede utilizar ensure sin rescue y viceversa, pero si se utilizan en el mismo bloque begin ... end, rescue debe
#preceder a ensure.

#Es como el finally de java