import posiciones.*
import randomizer.*
import entidad.*

object rojo{ const property color = "rojo"}
object azul{ const property color = "azul"}
object verde{ const property color = "verde"}

class Pez inherits EntidadConTick{
    var property direccion = derecha
    var property position = game.at(0, 0)
    var property puntaje = 10
    var property color = rojo
    var property velocidad = 250

    method image() = "pez-" + color.color() + ".png"
    method nadarActionName() = "Nadar" + self.identity()

    override method milisegundos() = velocidad
    override method inmediato() = false

    override method alAgregarAEscena(_escena){
        super(_escena)
        position = randomizer.randomBorderX()
        direccion = if(position.x() == 0) { derecha } else { izquierda }
    }

    override method actualizar(){
        self.nadar()
    }

    method colision(personaje){
        personaje.comer(self)
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
        escena.quitarEntidad(self)
    }
}
