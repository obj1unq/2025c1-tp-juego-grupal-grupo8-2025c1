import src.escena.*
import entrada.*
import estadoDeJuego.*

object pantallaInicial {
    var property position = game.at(0, 0)

     method image() = "pantallainicial22.png"

     method iniciarJuego() {

        game.addVisual(self)
        entrada.inicializar() 
        
        keyboard.q().onPressDo({
            self.jugarJuego(escenaJuegoUnJugador)
            })
            
        keyboard.i().onPressDo({
                 game.removeVisual(self)
                 game.addVisual(imagenInstrucciones)
                 self.volverAlMenuPrincipal()           
            })

        keyboard.e().onPressDo({
            self.jugarJuego(escenaJuegoDosJugadores)
            })
     }     

     method jugarJuego(escena) {
        estadoDeJuego.cambiarAEscena(escena)
        game.removeVisual(self)
        self.volverAlMenuPrincipal()
     }

     method volverAlMenuPrincipal() {
            keyboard.z().onPressDo({
                estadoDeJuego.cambiarAEscena(menuPrincipal)
                game.addVisual(self)
                game.removeVisual(imagenInstrucciones)
                })
     }
}

object imagenInstrucciones {
    var property position = game.at(0, 0)

     method image() ="instruccionessFinal.png"

}