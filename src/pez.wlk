import posiciones.*
import randomizer.*
import entidad.*

class Color {
    const property color
}
object rojo inherits Color(color="rojo") {}
object azul inherits Color(color="azul") {}
object verde inherits Color(color="verde") {}
object venenoso inherits Color(color="venenoso") {}
object curativo inherits Color(color="curativo") {}

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


class PezFactory {
    var property color
    var property velocidad
    var property puntaje

    method nuevoPez() = new Pez(color=color, puntaje=puntaje, velocidad=velocidad)
}

const azulFactory = new PezFactory(velocidad = 350, puntaje = 5, color = azul)
const rojoFactory = new PezFactory(velocidad = 250, puntaje = 10, color = rojo)
const verdeFactory = new PezFactory(velocidad = 200, puntaje = 20, color = verde)

class PezVenenoso inherits Pez() {
       
    override method colision(personaje) {
        self.desaparecer()
        personaje.envenenar()
    }
}

class PezCurativo inherits Pez() {
    
    override method colision(personaje) {
        personaje.curar()
        self.desaparecer()
    }
}

object venenosoFactory {
    method nuevoPez() = new PezVenenoso(puntaje=0, velocidad=100, color=venenoso)
}

object curativoFactory {
    method nuevoPez() = new PezCurativo(puntaje=0, velocidad=250, color=curativo)
}