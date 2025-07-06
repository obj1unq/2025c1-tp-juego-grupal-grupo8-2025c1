import pez.*

object randomizer{
    method randomBorderX(){
        const x = [0, game.width() - 1].anyOne()
        const y = (0 .. game.height() - 1).anyOne()
        return game.at(x, y)
    }

    method randomBorderY() {
    const x = (0 .. game.height() - 1).anyOne()  
    const y = 8
    return game.at(x, y) 
}

    method randomBool(chance, in){
        return (0 .. in).anyOne() < chance
    }

    method randomPez(personaje) {
    // duplicamos los mismos factories para hacer ciertos tipos de pez mas comunes
    const factories = [
        azulFactory,
        azulFactory,
        rojoFactory,
        rojoFactory,
        rojoFactory,
        amarilloFactory,
        amarilloFactory
    ]

    if (personaje.estaEnvenenado()) {
        factories.add(curativoFactory)
    }
    else{
        factories.add(venenosoFactory)
    }

    return factories.anyOne().nuevoPez()
}
}