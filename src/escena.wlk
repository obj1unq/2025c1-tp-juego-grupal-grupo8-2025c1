import estadoDeJuego.*
import pulpo.*
import contador.*
import pez.*
import tiburon.*
import posiciones.*
import red.*
import randomizer.*
import entrada.*
import pantallapormuerte.*
import entidad.*
import pantallainicial.*



class Escena {
    const property entidades = #{}
    var activa = false

    method activa() = activa 

    method validarAgregarEntidad(entidad){
        if(entidades.contains(entidad)){
            self.error("La entidad ya esta en la escena")
        }
        if(!activa){//
            self.error("La escena no esta activa")//
        }
    }

    method agregarEntidad(entidad){
        self.validarAgregarEntidad(entidad)
        entidad.alAgregarAEscena(self)
        entidades.add(entidad)
        game.addVisual(entidad)
    }

    method validarQuitarEntidad(entidad){
        if(!entidades.contains(entidad)){
            self.error("La entidad no esta en la escena")
        }
    }

    method quitarEntidad(entidad){
        self.validarQuitarEntidad(entidad)
        game.removeVisual(entidad)
        entidad.alQuitarDeEscena()
        entidades.remove(entidad)
    }

    method cargarEscena() { 
        activa = true 
    } 

    method descargarEscena(){
        activa = false
        entidades.forEach({entidad => self.quitarEntidad(entidad)})
    }
 }

 class EscenaJuego inherits Escena {

    const accionRecargarEscena = {estadoDeJuego.recargarEscena()}

    override method cargarEscena(){
        super() 
        const jugador = new Pulpo()
        self.agregarEntidad(jugador)
        self.agregarEntidad(new Contador(jugador = jugador))
    
        game.onTick(1000, "aparecerPez", { self.agregarEntidad(randomizer.randomPez(jugador)) })
        game.onTick(2500, "aparecerRed", { self.agregarEntidad(new Red()) })
        game.onTick(3000, "aparecerTiburon", { self.agregarEntidad(new Tiburon()) })
    
        entrada.alPresionarTecla(keyboard.r(), accionRecargarEscena)
    }

    override method descargarEscena(){
        super()
        self.detenerSpawns()
        game.removeTickEvent("verificarPuntaje")
        entrada.quitarPresionarTecla(keyboard.r(), accionRecargarEscena)
    }

    method detenerSpawns() {
        game.removeTickEvent("aparecerRed")
        game.removeTickEvent("aparecerPez")
        game.removeTickEvent("aparecerTiburon")
    }

    method finDelJuego(_jugador) {
        const pantallafinal = new PantallaFinal()
        self.detenerSpawns()
        game.schedule(1000, {self.agregarEntidad(pantallafinal)})   	
		game.schedule(1030, {
        const puntajeFinal = new PuntajeFinal()
        self.agregarEntidad(puntajeFinal)
        puntajeFinal.mostrar(_jugador)
        })
    }
}

object escenaJuegoUnJugador inherits EscenaJuego {}

object escenaJuegoDosJugadores inherits EscenaJuego {

    override method cargarEscena(){
        activa = true
        const jugador = new Pulpo(position=game.at(2,3))
        const jugador2 = new PulpoDos()

        self.agregarEntidad(jugador)
        self.agregarEntidad(new Contador(jugador = jugador))

        self.agregarEntidad(jugador2)
        self.agregarEntidad(new Contador(jugador = jugador2,position = game.at(game.width() - 1, game.height() - 1) ))
    
        game.onTick(1000, "aparecerPez",     { self.agregarEntidad(randomizer.randomPez(jugador)) })
        game.onTick(2500, "aparecerRed",     { self.agregarEntidad(new Red()) })
        game.onTick(3000, "aparecerTiburon", { self.agregarEntidad(new Tiburon()) })
        self.verificarGanador(jugador,pantallaGanador1)
        self.verificarGanador(jugador2,pantallaGanador2)                                   
    
        entrada.alPresionarTecla(keyboard.r(), accionRecargarEscena)
    }

    method verificarGanador(_jugador,_pantalla) {
        game.onTick(50, "verificarPuntaje",  { if (self.jugadorGanador(_jugador)) {
                                                     self.finDelJuego(_pantalla)
                                                     game.removeTickEvent("verificarPuntaje")}})
    }

    override method finDelJuego(pantalla) {
        self.detenerSpawns()	
        game.schedule(1100, {self.agregarEntidad(pantalla)})
    }

    method jugadorGanador(_jugador) = _jugador.puntaje() >= 300
}

object menuPrincipal inherits Escena {}   