import posiciones.*
import randomizer.*

object vivo {
    method puedeNadar(pez){
        return !pez.seSaleDelMapa()
    }
}
object muerto {
    method puedeNadar(pez) = false
}

object rojo{ const property color = "rojo"}
object azul{ const property color = "azul"}
object verde{ const property color = "verde"}

class Pez{
    var property direccion = derecha
    var property position = game.at(0, 0)
    var property puntaje = 10
    var property color = rojo
    var property velocidad = 250
    var property estado = vivo

    method image() = "pez-" + color.color() + ".png"

    method aparecer(){
        game.addVisual(self)
        position = randomizer.randomBorderX()
        direccion = if(position.x() == 0) { derecha } else { izquierda }
        game.schedule(velocidad, { self.nadar() })
    }

    method colision(personaje){
        personaje.comer(self)
        self.desaparecer()
    }

    method seSaleDelMapa(){
        const siguiente = direccion.siguiente(position).x()
        return siguiente < 0 || siguiente >= game.width()
    }

    method nadar(){
        if(!estado.puedeNadar(self)){
            self.desaparecer()
        }
        else{
            position = direccion.siguiente(position)
            game.schedule(velocidad, { self.nadar() })
        }
    }
// <<<<<<< tiburon
//    method colision(personaje){
//       personaje.comer(self)
//       //self.desaparecer()
//   }
//   /*
//   method desaparecer(){
//       //estado = muerto
//       game.removeVisual(self)
//   }
77    */
/7}