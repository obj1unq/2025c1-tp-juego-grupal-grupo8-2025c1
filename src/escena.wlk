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

    method validarAgregarEntidad(entidad){
        if(entidades.contains(entidad)){
            self.error("La entidad ya esta en la escena")
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

    method cargarEscena()

    method descargarEscena(){
        entidades.forEach({entidad => self.quitarEntidad(entidad)})
    }
 }
object escenaJuego inherits Escena {

    const accionRecargarEscena = {estadoDeJuego.recargarEscena()}
    var  jugador = new Pulpo()

    override method cargarEscena(){
        jugador = new Pulpo()
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
        entrada.quitarPresionarTecla(keyboard.r(), accionRecargarEscena)
    }

    method detenerSpawns() {
        game.removeTickEvent("aparecerRed")
        game.removeTickEvent("aparecerPez")
        game.removeTickEvent("aparecerTiburon")
    }

    method finDelJuego(_jugador) {
        const pantallafinal = new PantallaFinal()
        game.schedule(1000, {self.agregarEntidad(pantallafinal)})   	
		game.schedule(1025, {
        const puntajeFinal = new PuntajeFinal()
        self.agregarEntidad(puntajeFinal)
        puntajeFinal.mostrar(_jugador)
        pantallaInicial.volverAlMenuPrincipal(pantallafinal)
        })
    }
}