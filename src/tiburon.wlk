import src.escena.*
import posiciones.*
import randomizer.*
import pulpo.*
import entidad.*
import estadoDeJuego.*
import mapa.*

class Tiburon inherits EntidadConTick{
    var property direccion = derecha
    var property position = game.at(0, 0)
    var property puntaje = 10

    override method milisegundos() = 250

    method image() = "shark.png"

    override method alAgregarAEscena(_escena){
        super(_escena)
        position = randomizer.randomBorderX()
        direccion = if(position.x() == 0) { derecha } else { izquierda }
    }

    override method actualizar(){
        self.nadar()
    }

    method nadar(){
        const siguiente = direccion.siguiente(position)
        if(!mapa.estaAdentro(siguiente)){
            escena.quitarEntidad(self)
        }
        else{
            position = siguiente
        }
    }

    method colision(personaje){
        if (estadoDeJuego.escenaActualDelJuego(escenaJuegoUnJugador)) 
        personaje.morir() 
          else
        personaje.penalizacionPorTiburon() 
    }
}