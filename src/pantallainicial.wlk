import src.escena.*
import entrada.*
import entidad.*
import estadoDeJuego.*

object pantallaInicial inherits Escena {
    const imagen = "pantallainicial22.png"

    const unJugador = {estadoDeJuego.cambiarAEscena(escenaJuegoUnJugador)}
    const dosJugadores = {estadoDeJuego.cambiarAEscena(escenaJuegoDosJugadores)}
    const instrucciones = {estadoDeJuego.cambiarAEscena(pantallaInstrucciones)}

    override method cargarEscena(){
        super()
        self.agregarEntidad(new Imagen(image=imagen))

        entrada.alPresionarTecla(keyboard.q(), unJugador)
        entrada.alPresionarTecla(keyboard.e(), dosJugadores)
        entrada.alPresionarTecla(keyboard.i(), instrucciones)
    }

    override method descargarEscena(){
        super()
        entrada.quitarPresionarTecla(keyboard.q(), unJugador)
        entrada.quitarPresionarTecla(keyboard.e(), dosJugadores)
        entrada.quitarPresionarTecla(keyboard.i(), instrucciones)
    }
}

object pantallaInstrucciones inherits Escena {
    const imagenInstrucciones = "instruccionessFinal.png"

    override method cargarEscena(){
        super()
        self.agregarEntidad(new Imagen(image=imagenInstrucciones))
    }

}