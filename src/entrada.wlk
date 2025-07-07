class Evento {
    const closures = #{}

    method disparar(){
        closures.forEach({c => c.apply()})
    }

    method agregar(closure){
        closures.add(closure)
    }

    method quitar(closure){
        closures.remove(closure)
    }
}

object entrada {
    const eventos = new Dictionary()

    method inicializar(){
        // Llenamos con las teclas que sean relevantes para el juego
        const teclas = [
            keyboard.w(),
            keyboard.a(),
            keyboard.s(),
            keyboard.d(),
            keyboard.p(),
            keyboard.h(),
            keyboard.r(),
            keyboard.u(),
            keyboard.j(),
            keyboard.k(),
            keyboard.j(),
            keyboard.z()
        ]

        teclas.forEach({tecla => 
            const evento = new Evento()
            eventos.put(self.obtenerCodigoDeTecla(tecla), evento)
            tecla.onPressDo({evento.disparar()})
        })
    }

    method obtenerCodigoDeTecla(tecla){
        return tecla.keyCodes().first()
    }

    method validarExisteTecla(tecla){
        if(!eventos.containsKey(self.obtenerCodigoDeTecla(tecla))){
            self.error("El juego no tiene soporte aún para la tecla!")
        }
    }

    method alPresionarTecla(tecla, closure){
        eventos.get(self.obtenerCodigoDeTecla(tecla)).agregar(closure)
    }

    method quitarPresionarTecla(tecla, closure){
        eventos.get(self.obtenerCodigoDeTecla(tecla)).quitar(closure)
    }
}