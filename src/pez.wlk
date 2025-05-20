import posiciones.*
import randomizer.*

object rojo{ const property color = "rojo"}
object azul{ const property color = "azul"}
object verde{ const property color = "verde"}

class Pez{
    var property direccion = derecha
    var property position = game.at(0, 0)
    var property puntaje = 10
    var property color = rojo
    var property velocidad = 250

    method image() = "pez-" + color.color() + ".png"
    method nadarActionName() = "Nadar" + self.identity()

    method aparecer(){
        game.addVisual(self)
        position = randomizer.randomBorderX()
        direccion = if(position.x() == 0) { derecha } else { izquierda }
        game.onTick(velocidad, self.nadarActionName(), {self.nadar()})
        game.schedule(velocidad, { self.nadar() })
    }

    method colision(personaje){
        personaje.comer(self)
        self.desaparecer()
    }

    method puedeNadar(){
        return !self.seSaleDelMapa()
    }

    method seSaleDelMapa(){
        const siguiente = direccion.siguiente(position).x()
        return siguiente < 0 || siguiente >= game.width()
    }

    method nadar(){
        if(!self.puedeNadar()){
            self.desaparecer()
        }
        else{
            position = direccion.siguiente(position)
        }
    }

    method desaparecer(){
        game.removeTickEvent(self.nadarActionName())
        game.removeVisual(self)
    }

}
