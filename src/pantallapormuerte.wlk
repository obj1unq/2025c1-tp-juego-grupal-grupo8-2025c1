import entidad.*

class PantallaFinal inherits Entidad {
    
    const property puntajeFinal

    method esPantallaFinal() = true
    method image() = "gameover1.png"  
    method position() = game.at(0, 0)

}