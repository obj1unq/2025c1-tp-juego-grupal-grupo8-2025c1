import entidad.*
class TextoFinal inherits Entidad {
    const puntajeFinal

    method position() = game.center()
    method text() = "💀 GAME OVER - Puntaje: " + puntajeFinal
}