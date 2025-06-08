import escena.*

object estadoDeJuego {
    var escenaActiva = escenaJuego

    method escenaActiva() = escenaActiva

    method inicializar(){
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
}