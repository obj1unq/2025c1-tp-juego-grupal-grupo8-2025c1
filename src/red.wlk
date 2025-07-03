import posiciones.*
import entidad.*
import randomizer.*
import mapa.*

class Red inherits EntidadConTick {
    var property direccion = abajo
    var property position = game.at(0, 0)
    const property penalizacion = 35

    override method inmediato() = false
    override method milisegundos() = 500
    method image() = "red2.png"

    override method alAgregarAEscena(_escena){
        super(_escena)
        position = randomizer.randomBorderY()
    }

    override method actualizar(){
        self.caer()
    }

    method caer(){
        const siguiente = direccion.siguiente(position)
        if(mapa.estaAdentro(siguiente)){
            self.desaparecer()
        }
        else{
            position = siguiente
        }
    }
    
    method colision(personaje){
        personaje.atraparsePorRed(self)
        self.desaparecer()
    }

    method desaparecer() {
        escena.quitarEntidad(self)
    } 
}