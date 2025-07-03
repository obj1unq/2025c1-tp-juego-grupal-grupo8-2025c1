object mapa {
    method estaAdentro(posicion){
        return (
            posicion.x().between(0, game.width() - 1) &&
            posicion.y().between(0, game.height() - 1)
        )
    }
}