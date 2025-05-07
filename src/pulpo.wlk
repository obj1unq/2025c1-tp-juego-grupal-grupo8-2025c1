import wollok.game.*
import posiciones.*

object pulpo {
	var property position = game.at(3,5)
	var property puntaje = 0
		
	method image(){
		return "pulpo.png"
	}
	
	method mover(direccion) {
		position = direccion.siguiente(self.position())
	}

	method comer(pez){
		puntaje += pez.puntaje()
		self.decirPuntaje()
		pez.reaparecer()
	}

	method decirPuntaje(){
		game.say(self, "Tengo " + puntaje + " puntos!")
	}
	method anunciarMuerte(){
		game.say(self, "Estoy muerto")
	}

	method morir(){
		puntaje = 0
		self.anunciarMuerte()
	}
	/*
	method debilitarse(){
		self.puntaje() / 2
		self.decirPuntaje()
		//Opcion que debilita al pulpo
	}
	*/
}
