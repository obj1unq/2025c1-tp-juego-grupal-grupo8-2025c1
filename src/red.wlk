import posiciones.*
import randomizer.*

object red{
    var property direccion = abajo
    var property position = game.at(0, 0)
    var personajeAtrapado = null

    method image() = "red.png"

    method reaparecer(){
        position = randomizer.randomBorderY()
        personajeAtrapado = null
        direccion = if(position.y() == 0) { arriba } else { abajo }
    }

    method seSaleDelMapa(){
        const siguiente = direccion.siguiente(position).y()
        return siguiente < 0 || siguiente >= game.height()
    }

    method caer(personaje){
        if(self.seSaleDelMapa()){
            self.reaparecer()
        }
        else if (personajeAtrapado == null) {
            position = direccion.siguiente(position)
        }
    }
   
    
    method colision(personaje){
        personajeAtrapado = personaje
        personaje.atraparsePorRed()
    }

    method desaparecer() {
        game.removeVisual(self)
        game.schedule(3000, {
            self.reaparecer()
            game.addVisual(self)
        })
    } 

}