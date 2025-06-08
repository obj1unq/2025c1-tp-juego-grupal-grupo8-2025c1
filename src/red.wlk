import posiciones.*
import entidad.*
import randomizer.*

class Red inherits EntidadConTick {
    var property direccion = abajo
    var property position = game.at(0, 0)

    override method inmediato() = false
    override method milisegundos() = 500
    method image() = "red.png"

    override method alAgregarAEscena(_escena){
        super(_escena)
        position = randomizer.randomBorderY()
    }

    method reaparecer(){
        position = randomizer.randomBorderY()
        direccion = if(position.y() == 0) { arriba } else { abajo }
    }

    method seSaleDelMapa(){
        const siguiente = direccion.siguiente(position).y()
        return siguiente < 0 || siguiente >= game.height()
    }

    override method actualizar(){
        self.caer()
    }

    method caer(){
        if(self.seSaleDelMapa()){
            self.desaparecer()
        }
        else{
            position = direccion.siguiente(position)
        }
    }
    
    method colision(personaje){
        personaje.atraparsePorRed()
        self.desaparecer()
    }

    method desaparecer() {
        escena.quitarEntidad(self)
    } 
}