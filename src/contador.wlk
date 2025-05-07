import pulpo.*


object contador {
    var property personaje = pulpo

    method position() = game.at(0, game.height() - 1)
    method text() = "PUNTOS: " + pulpo.puntaje()
}