import entidad.*

class Contador inherits Entidad {
    
    const jugador

    method position() = game.at(0, game.height() - 1)
    method text() = "PUNTOS: " + jugador.puntaje()
}