import wollok.game.*
import posiciones.*
import entidad.*
import entrada.*
import pantallapormuerte.*
import escena.*
import mapa.*

class EstadoDePulpo{
	method puedeMoverse()
	method estaVivo()
	method estaEnvenenado()

	method atraparse(pulpo){}
	method envenenarse(pulpo){}
	method curarse(pulpo){}
	method image(pulpo)
}

class EstadoVivo inherits EstadoDePulpo {
	const tiempoAtrapado = 1200

	override method estaVivo() = true

	override method atraparse(pulpo){
		pulpo.estado(atrapado)
		game.schedule(tiempoAtrapado, {
			if(pulpo.estado().estaVivo()){
				pulpo.estado(self)
			}
		})
	}
}

object vivo inherits EstadoVivo {
	override method estaEnvenenado() = false
	override method puedeMoverse() = true
	override method image(pulpo) = if (pulpo.playerUno()) "jugador1.png" else "jugador2.png"
	override method envenenarse(pulpo){
		pulpo.estado(envenenado)
		game.onTick(1000, pulpo.nombreTickEnvenenado(), {pulpo.perdidaContinua()})
		pulpo.perdidaContinua()
	}
}

object envenenado inherits EstadoVivo {
	override method estaEnvenenado() = true
	override method puedeMoverse() = true
	override method image(pulpo) = if (pulpo.playerUno()) "pulpoEnvenenado.png" else "pulpoEnvenenadodoss.png"
	override method curarse(pulpo){
		pulpo.estado(vivo)
		game.removeTickEvent(pulpo.nombreTickEnvenenado())
	}
}

object choque inherits EstadoVivo {
	override method estaEnvenenado() = false
	override method puedeMoverse() = true
	override method image(pulpo) = if (pulpo.playerUno()) "jugador1choque.png" else "jugador2choque.png"
}

object atrapado inherits EstadoDePulpo {
	override method estaEnvenenado() = false
	override method puedeMoverse() = false
	override method estaVivo() = true 
	override method image(pulpo) = if (pulpo.playerUno()) "pulpoAtrapado.png" else "pulpoDosAtrapado.png"
}

object muerto inherits EstadoDePulpo {
	override method estaEnvenenado() = false
	override method puedeMoverse() = false
	override method estaVivo() = false
	override method image(pulpo) = "pulpoGris.png"
}

class Pulpo inherits Entidad {
	var property position = game.center()
	var property puntaje = 0
	var property estado = vivo
	const moverArriba = {self.mover(arriba)}
	const moverIzquierda = {self.mover(izquierda)}
	const moverAbajo = {self.mover(abajo)}
	const moverDerecha = {self.mover(derecha)}

	method nombreTickEnvenenado() = "envenenado"+self.identity() 
	method image() = estado.image(self)
	
	override method alAgregarAEscena(_escena) {
		super(_escena)
		puntaje = 0
		estado = vivo 

		game.onCollideDo(self, { e => e.colision(self) })
		entrada.alPresionarTecla(keyboard.w(), moverArriba)
		entrada.alPresionarTecla(keyboard.a(), moverIzquierda)
		entrada.alPresionarTecla(keyboard.s(), moverAbajo)
		entrada.alPresionarTecla(keyboard.d(), moverDerecha)
	}

	method agregarPuntaje() {
		escena.agregar(puntaje)
	}

    override method alQuitarDeEscena() {
		super()
		entrada.quitarPresionarTecla(keyboard.w(), moverArriba)
		entrada.quitarPresionarTecla(keyboard.a(), moverIzquierda)
		entrada.quitarPresionarTecla(keyboard.s(), moverAbajo)
		entrada.quitarPresionarTecla(keyboard.d(), moverDerecha)
	}

	method estaEnvenenado() = estado.estaEnvenenado()

	method estaEnElMapa(direccion) = mapa.estaAdentro(direccion.siguiente(position))

	method puedeMoverse(direccion){
		return estado.puedeMoverse() && self.estaEnElMapa(direccion)
	}
	
	method mover(direccion) {
		if (self.puedeMoverse(direccion))
			position = direccion.siguiente(self.position())
	}

	method comer(pez){
		if (estado.puedeMoverse()){
			puntaje += pez.puntaje()
			pez.desaparecer()
    		}
	}

	method morir(){
		estado = muerto
		escenaJuegoUnJugador.finDelJuego(self)
	}
		
    method atraparsePorRed(red) {
        self.penalizacionPorRed(red)
        estado.atraparse(self)
    }

	method penalizacionPorRed(red) {
		if (estado.estaVivo()){
        	puntaje = 0.max(puntaje - red.penalizacion())
		}
	}

	method digitos() {
		return puntaje.toString().split("")
	}

	method envenenar() {
		estado.envenenarse(self)
    }

    method curar() {
        estado.curarse(self)
    }

	method perdidaContinua() {
        if (estado.estaEnvenenado()) {
            puntaje = 0.max(puntaje - 5)
        }
    }

	method penalizacionPorTiburon() {
	    self.iniciarPenalizacion()
	    game.schedule(500, {self.estado(vivo)}) 
	
	}

	method iniciarPenalizacion() {
		estado = choque
		puntaje = 0.max(puntaje - 150)
	}

	method playerUno() = true
}

class PulpoDos inherits Pulpo(position = game.at(10,3)) {

	override method alAgregarAEscena(_escena) {
		puntaje = 0
		estado = vivo 

		game.onCollideDo(self, { e => e.colision(self) })
		entrada.alPresionarTecla(keyboard.u(), moverArriba)
		entrada.alPresionarTecla(keyboard.h(), moverIzquierda)
		entrada.alPresionarTecla(keyboard.j(), moverAbajo)
		entrada.alPresionarTecla(keyboard.k(), moverDerecha)
	}

	override method alQuitarDeEscena() {
		
		entrada.quitarPresionarTecla(keyboard.u(), moverArriba)
		entrada.quitarPresionarTecla(keyboard.h(), moverIzquierda)
		entrada.quitarPresionarTecla(keyboard.j(), moverAbajo)
		entrada.quitarPresionarTecla(keyboard.k(), moverDerecha)
	}

	override method playerUno() = false
}
