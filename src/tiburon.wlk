import src.escena.*
import posiciones.*
import randomizer.*
import pulpo.*
import entidad.*

class Tiburon inherits EntidadConTick{
    var property direccion = derecha
    var property position = game.at(0, 0)
    var property puntaje = 10

    override method milisegundos() = 250

    method image() = "shark_sinfondo.png"

    override method alAgregarAEscena(_escena){
        super(_escena)
        position = randomizer.randomBorderX()
        direccion = if(position.x() == 0) { derecha } else { izquierda }
    }

    override method actualizar(){
        self.nadar()
    }

    method seSaleDelMapa(){
        const siguiente = direccion.siguiente(position).x()
        return siguiente < 0 || siguiente >= game.width()
    }

    method nadar(){
        if(self.seSaleDelMapa()){
            escena.quitarEntidad(self)
        }
        else{
            position = direccion.siguiente(position)
        }
    }

    method colision(personaje){
        personaje.morir()
    }
}