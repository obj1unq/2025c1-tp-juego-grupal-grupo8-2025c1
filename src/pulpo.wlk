import wollok.game.*
import posiciones.*
import entidad.*
import entrada.*
import pantallapormuerte.*
import escena.*
import estadoDeJuego.*
object vivo {
	const tiempoAtrapado = 1200
	method puedeMoverse() = true
	method estaVivo() = true

	method atraparse(pulpo){
		pulpo.estado(atrapado)
		game.schedule(tiempoAtrapado, {
			if(pulpo.estado().estaVivo()){
				pulpo.estado(self)
			}
		})
	}
}

object atrapado {
	method puedeMoverse() = false
	method estaVivo() = true

	method atraparse(pulpo){}
}

object muerto {
	method puedeMoverse() = false
	method estaVivo() = false

	method atraparse(pulpo){}
}

class Pulpo inherits Entidad {
	var property position = game.center()
	var property puntaje = 0
	var property estado = vivo
	const moverArriba = {self.mover(arriba)}
	const moverIzquierda = {self.mover(izquierda)}
	const moverAbajo = {self.mover(abajo)}
	const moverDerecha = {self.mover(derecha)}
	
	var property image = "pulpo2.png"

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
	    image =  "pulpoGris.png"	
		escenaJuego.detenerSpawns()
		game.schedule(1000, {escena.agregarEntidad(new PantallaFinal())})   	
		game.schedule(1001, {
        const puntajeFinal = new PuntajeFinal()
        escena.agregarEntidad(puntajeFinal)
        puntajeFinal.mostrar(self)
        })
	}
		
    method atraparsePorRed(red) {
        self.penalizacionPorRed(red)
        estado.atraparse(self)
    }

	method penalizacionPorRed(red) {
		if (estado.estaVivo()) 
        puntaje -= red.penalizacion()
           if(puntaje < 0) {
              puntaje = 0
        }
	}

	method digitos() {
		return puntaje.toString().split("")
	}
}
