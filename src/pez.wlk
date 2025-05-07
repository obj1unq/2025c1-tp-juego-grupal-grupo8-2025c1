import posiciones.*
import randomizer.*

class Pez{
    var property direccion = derecha
    var property position = game.at(0, 0)
    var property puntaje = 10
    var property color = "rojo"
    var property velocidad = 250

    method image() = "pez-" + color + ".png"

    method aparecer(){
        position = randomizer.randomBorderX()
        direccion = if(position.x() == 0) { derecha } else { izquierda }
        game.schedule(velocidad, self.nadar())
    }

    method colision(personaje){
        personaje.comer(self)
    }

    method seSaleDelMapa(){
        const siguiente = direccion.siguiente(position).x()
        return siguiente < 0 || siguiente >= game.width()
    }

    method nadar(){
        if(self.seSaleDelMapa()){
            self.desaparecer()
        }
        else{
            position = direccion.siguiente(position)
        }
    }

    method desaparecer(){
        game.removeVisual(self)
    }
}