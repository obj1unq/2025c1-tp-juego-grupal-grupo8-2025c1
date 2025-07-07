import entrada.*
import escena.*
import pantallainicial.*

object estadoDeJuego {
    var escenaActiva = pantallaInicial
    
    method escenaActiva() = escenaActiva

    method inicializar(){
        entrada.inicializar()
        entrada.alPresionarTecla(keyboard.z(), {self.cambiarAEscena(pantallaInicial)})
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