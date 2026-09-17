object camion {
    const cosas = #{}
    const tara = 1000

    method carga(cosa) {
        cosas.add(cosa)
    }
    method descargar(cosa) {
        cosas.remove(cosa)
    }
    method pesoTotal() {
        return tara + self.pesoCarga()
    }
    method pesoCarga() = cosas.sum({unaCosa => unaCosa.peso()})

    method excedidoDePeso() = self.pesoTotal() > 2500
    
    method objetosPeligrosos(nivel) {
        return cosas.filter({ c => c.peligrosidad() > nivel})
    }
    method objetosMasPeligrososQue(cosa) {
        return cosas.filter({c => c.peligrosidad() > cosa.peligrosidad()})
    }
    method puedeCircularEnRuta(nivelMaximoPeligrosidad) {
        return cosas.all({ unaCosa => unaCosa.peligrosidad() <= nivelMaximoPeligrosidad})
    }

}