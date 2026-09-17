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


object knightRider {

    method peso() = 500
	method peligrosidad() = 10
	method bultos() = 1
	method accidente() {
	  
	}
}

object arenaGranel {
    var property peso = 0

    method peso() = peso
    method peligrosidad() = 1 
    method bultos() = 1

  method accidente() {
	peso = peso + 20
  }
}

object bumblebee {
    var property modoAuto = true
    method peso() = 800
    method peligrosidad() = if (modoAuto) 15 else 30
    method bultos() = 2

  method accidente() {
	if (modoAuto){
		modoAuto = false
	}else{
		modoAuto = true
	}
  }
}

object paqueteLadrillos {
    var property cantLadrillos = 0

    method peso() = 2 * cantLadrillos
    method peligrosidad() = 2 
    method bultos() = if (cantLadrillos <= 100) 1 else if(cantLadrillos <= 300) 2 else 3

  method accidente() {
	cantLadrillos = (cantLadrillos - 12).max(0)
  }
}

object bateriaAntiaerea {
    var property hayMisiles = true

    method peso() = if (hayMisiles) 300 else 200
    method peligrosidad() = if (hayMisiles) 100 else 0
    method bultos() = if (self.hayMisiles()) 2 else 1
  method accidente() {
	if (hayMisiles){
		hayMisiles = false
	}
  }
}

object residuosRadiactivos {
    var property peso = 0

    method peligrosidad() = 200 
    method bultos() = 1

    method accidente() {
        peso = peso + 15
    }
}
object embalajeSeguridad {
    var property cargaEnvuelta = bumblebee

    method peso() = cargaEnvuelta.peso()
    method peligrosidad() = cargaEnvuelta.peligrosidad()/2

  method bultos() = 2
  method accidente() {
	
  }
}

object contenedorPortuario {
    const peso = 100
    const carga = #{} 

    method carga() = carga

    method cargar(cosa) {
        carga.add(cosa)
    }

    method peso() = peso + self.pesoDeCosas()
    method pesoDeCosas() = carga.sum({unaCosa => unaCosa.peso()})
    method peligrosidad() = if(carga.isEmpty()) 0 else self.cargaMasPeligrosa()
    method cargaMasPeligrosa() =  carga.max({carga => carga.peligrosidad()}).peligrosidad()

  method bultos() {
	return 1 + carga.sum({ c => c.bultos() })
  }
}
