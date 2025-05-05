import posiciones.*
import randomizer.*

object pez{
    var property direccion = derecha
    var property position = game.at(0, 0)
    var property puntaje = 10

    method image() = "pez.png"

    method reaparecer(){
        position = randomizer.randomBorderX()
        direccion = if(position.x() == 0) { derecha } else { izquierda }
    }

    method seSaleDelMapa(){
        const siguiente = direccion.siguiente(position).x()
        return siguiente < 0 || siguiente >= game.width()
    }

    method nadar(){
        if(self.seSaleDelMapa()){
            self.reaparecer()
        }
        else{
            position = direccion.siguiente(position)
        }
    }
}