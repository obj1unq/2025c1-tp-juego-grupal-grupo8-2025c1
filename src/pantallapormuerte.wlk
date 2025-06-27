import entidad.*
import escena.*
class PantallaFinal inherits Entidad {
    
    method image() = "gameover33.png"  
    method position() = game.at(0, 0)
}

class PuntajeFinal inherits Entidad { 

    method position() = game.at(8, 3)         

    method mostrar(jugador) {
    const digitos = jugador.digitos()
    var x = 8
    
    digitos.forEach({ d =>
        const numero = new NumeroFinal(valor = d, posX = x)
        escena.agregarEntidad(numero)
        x = x + 1
        })
    }
}

class NumeroFinal inherits Entidad {
    const valor
    const posX

    method image() = "numero" + valor + ".png"
    method position() = game.at(posX, 3)
}



