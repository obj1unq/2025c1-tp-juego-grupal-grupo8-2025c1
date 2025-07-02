import wollok.game.*
import posiciones.*
import entidad.*
import entrada.*
import pantallapormuerte.*
import escena.*
import estadoDeJuego.*

class EstadoDePulpo{
	method puedeMoverse()
	method estaVivo()
	method estaEnvenenado()

	method atraparse(pulpo){}
	method envenenarse(pulpo){}
	method curarse(pulpo){}
	method image()
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
	override method image() = "pulpo2.png"
	override method envenenarse(pulpo){
		pulpo.estado(envenenado)
		game.onTick(1000, pulpo.nombreTickEnvenenado(), {pulpo.perdidaContinua()})
		pulpo.perdidaContinua()
	}
}
object envenenado inherits EstadoVivo {
	override method estaEnvenenado() = true
	override method puedeMoverse() = true
	override method image() = "pulpoEnvenenado.png"
	override method curarse(pulpo){
		pulpo.estado(vivo)
		game.removeTickEvent(pulpo.nombreTickEnvenenado())
	}
}

object atrapado inherits EstadoDePulpo {
	override method estaEnvenenado() = false
	override method puedeMoverse() = false
	override method estaVivo() = true
	override method image() = "pulpoAtrapado.png"
}

object muerto inherits EstadoDePulpo {
	override method estaEnvenenado() = false
	override method puedeMoverse() = false
	override method estaVivo() = false
	override method image() = "pulpoGris.png"
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
	method image() = estado.image()
	
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

	method mover(direccion) {
		if (estado.puedeMoverse())
			position = direccion.siguiente(self.position())
	}

	method comer(pez){
		if (estado.puedeMoverse()){
			puntaje += pez.puntaje()
			escena.quitarEntidad(pez)
		}
	}

	method morir(){
		estado = muerto
		escenaJuego.detenerSpawns()
		escenaJuego.finDelJuego(self)
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
}
