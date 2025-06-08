import estadoDeJuego.*
import pulpo.*
import contador.*
import pez.*
import tiburon.*
import posiciones.*
import red.*
import randomizer.*
import entrada.*


class Escena {
    const entidades = #{}

    method entidades() = entidades.asList()

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
    const accionPausa = {game.stop()}

    override method cargarEscena(){
        const jugador = new Pulpo()
        self.agregarEntidad(jugador)
        self.agregarEntidad(new Contador(jugador = jugador))
    
        game.onTick(1000, "aparecerPez", { self.agregarEntidad(randomizer.randomPez()) })
        game.onTick(2500, "aparecerRed", { self.agregarEntidad(new Red()) })
        game.onTick(3000, "aparecerTiburon", { self.agregarEntidad(new Tiburon()) })
    
        entrada.alPresionarTecla(keyboard.p(), accionPausa)
        entrada.alPresionarTecla(keyboard.r(), accionRecargarEscena)
    }

    override method descargarEscena(){
        super()
        game.removeTickEvent("aparecerRed")
        game.removeTickEvent("aparecerPez")
        game.removeTickEvent("aparecerTiburon")
        entrada.alPresionarTecla(keyboard.p(), accionPausa)
        entrada.quitarPresionarTecla(keyboard.r(), accionRecargarEscena)
    }
}