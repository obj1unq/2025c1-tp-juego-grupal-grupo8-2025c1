import wollok.game.*
import posiciones.*

object pulpo {
	var property position = game.at(3,5)
	var property puntaje = 0
	var property atrapado = false
			
	method image(){
		return "pulpo.png"
	}
	
	method mover(direccion) {
		if (!atrapado)
		position = direccion.siguiente(self.position())
	}

	method comer(pez){
		if (!atrapado)
		puntaje += pez.puntaje()
	}
	method anunciarMuerte(){
		game.say(self, "Estoy muerto")
	}

	method morir(){
		puntaje = 0
		self.anunciarMuerte()
	}
    
	method escaparseDeRed() {
	if (atrapado) {
		  atrapado = false
		  game.say(self, "Me escape")
	}
}


	method atraparsePorRed() {
	if (!atrapado) {
		atrapado = true
		game.say(self, "Estoy atrapado")
	}
}
}
