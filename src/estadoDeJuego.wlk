import escena.*
import entrada.*
object estadoDeJuego {
    var escenaActiva = escenaJuegoUnJugador
    
    method escenaActiva() = escenaActiva

    method inicializar(){
        entrada.inicializar() 
        escenaActiva.cargarEscena()
    }

    method recargarEscena(){
        escenaActiva.descargarEscena()
        escenaActiva.cargarEscena()
    }

    method cambiarAEscena(siguienteEscena){
        escenaActiva.descargarEscena()
        escenaActiva = siguienteEscena
        escenaActiva.cargarEscena()
    }

    method escenaActualDelJuego(_escena) {
        return escenaActiva ==_escena
    }
}