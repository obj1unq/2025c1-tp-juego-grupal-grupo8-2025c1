import entidad.*

class Contador inherits Entidad {
    
    const jugador
    var property position = game.at(0, game.height() - 1) 

   // method position() = game.at(0, game.height() - 1)
    method text() = "PUNTOS: " + jugador.puntaje()
}