class Entidad {
    // Valor por defecto en nulo para despues setearlo al agregar a la escena y no agregar complejidad al constructor
    var escena = null

    method escena() = escena 

    method activo() = escena != null

    method alAgregarAEscena(_escena) {
        escena = _escena
    }
    method alQuitarDeEscena() {
        escena = null
    }
}

class EntidadConTick inherits Entidad {
    method milisegundos()
    method inmediato() = false
    var tick = null
    const accionActualizar = {self.actualizar()}

    override method alAgregarAEscena(_escena) {
        super(_escena)
        tick = game.tick(self.milisegundos(), accionActualizar, self.inmediato())
        if(!self.inmediato()){
            game.schedule(
                self.milisegundos(), {if(self.activo()) {tick.start()}}
            )
        }
    }

    method quitarEventoTick(){
        tick.stop()
    }

    method actualizar()

    override method alQuitarDeEscena(){
        super()
        self.quitarEventoTick()
    }
}