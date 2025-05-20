import wollok.game.*
import posiciones.*

object vivo {
	method puedeMoverse() = true
}
object atrapado {
	method puedeMoverse() = false
}
object muerto {
	method puedeMoverse() = false
}

object pulpo {
	var property position = game.at(3,5)
	var property puntaje = 0
	var property estado = vivo
			
	method image(){
		return "pulpo.png"
	}

	method reiniciar(){
		puntaje = 0
		estado = vivo
		position = game.at(3, 5)
	}

	method mover(direccion) {
		if (estado.puedeMoverse())
			position = direccion.siguiente(self.position())
	}

	method comer(pez){
		if (estado.puedeMoverse())
			puntaje += pez.puntaje()
	}

	method morir(){
		estado = muerto
	}
    
	method escaparseDeRed() {
		if (estado == atrapado) {
			estado = vivo
		}
	}

	method atraparsePorRed() {
		if (estado.puedeMoverse()) {
			estado = atrapado
		}
	}
}