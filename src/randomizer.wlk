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
    const peces = [
        azulFactory,
        rojoFactory,
        verdeFactory,
        venenosoFactory
    ]

    if (personaje.estaEnvenenado()) {
        peces.add(curativoFactory)
    }

    return peces.anyOne().nuevoPez()
}
}