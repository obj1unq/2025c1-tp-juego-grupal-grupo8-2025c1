import entrada.*
import estadoDeJuego.*

object pantallaInicial {
    var property position = game.at(0, 0)

     method image() = "pantallainicial22.png"

     method iniciarJuego() {

        game.addVisual(self)
        
        keyboard.q().onPressDo({
            entrada.inicializar() 
            estadoDeJuego.inicializar() 
            game.removeVisual(self)
        })
            
        keyboard.i().onPressDo({
            game.addVisual(imagenInstrucciones)
            game.removeVisual(self)
            self.volverAlMenuPrincipal(imagenInstrucciones)
        })

        keyboard.e().onPressDo({
            game.addVisual(enProceso)
            game.removeVisual(self)
            self.volverAlMenuPrincipal(enProceso)
        })
     }     

     method volverAlMenuPrincipal(imagen) {
            keyboard.z().onPressDo({
                game.removeVisual(imagen)
                game.addVisual(self)
                })
     }
}

object imagenInstrucciones {
    var property position = game.at(0, 0)

     method image() ="instruccioness.png"

}

object enProceso {

    var property position = game.at(0, 0)

     method image() ="enproceso.png"
  
}