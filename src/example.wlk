/** First Wollok example */
object rolando{
	var property nivelHechiceria 
	var property hechizoPreferido
	var property fuerzaOscura = 5
	var property artefactos = []
	const vBase = 3
	var property habilidadLucha 
	var property baseLucha = 1
	//Punto 1
	method calcularNivelHechiceria() {
		nivelHechiceria = (vBase * hechizoPreferido.poder()) + fuerzaOscura
	}
	method eclipse() {fuerzaOscura = fuerzaOscura * 2}
	method esPoderoso(){
		return hechizoPreferido.esPoderoso()
	}
	//Punto 2
	method agregarArtefacto(algunArtefacto) {artefactos.add(algunArtefacto)}
	method removerArtefacto(algunArtefacto) {artefactos.remove(algunArtefacto)}
	method removerTodosArtefactos(){artefactos.clear()}
	method calcularHabilidad() {
		habilidadLucha = baseLucha + artefactos.map({arma => arma.unidadesLucha()}).sum()
	}
	method mayorHabilidadLuchaQueDeHechizeria() {
		return nivelHechiceria > habilidadLucha
	}
	//Punto 3
	method estaCargado() {
		return artefactos.size() >= 5
	}
}

//Hechizos
object espectroMalefico{
	var property nombre = "Espectro Malefico"
	method esPoderoso() {
		return self.poder() > 15
	}
	method poder() {
		return nombre.length()
	}
}

object hechizoBasico{
	var property poder = 10
	method esPoderoso() {
		return false
	}
}

object libroHechizos{
	var property hechizos = []
	var property poder
	method agregarHechizo(_hechizo) {hechizos.add(_hechizo)}
	method removerHechizo(_hechizo) {hechizos.remove(_hechizo)}
	method poder() {
		poder = hechizos.filter({hechizo => hechizo.esPoderoso()}).map({hechizo => hechizo.poder()}).sum()
		return poder
	}
}
//Que libroHechizos se contenga asi mismo romperia al libroHechizo no entender el mensaje esPoderoso
//y ademas que entraria en un caso recursivo al preguntar el poder del libroHechizos

//Artefactos
object espada{
	method unidadesLucha() {
		return 3
	}
}
object collarDivino{
	var property perlas
	method unidadesLucha() {
		return perlas
	} 
}
object mascaraOscura{
	var property luchador = rolando
	method unidadesLucha() {
		return (rolando.fuerzaOscura()/2).max(4)
	}
}

object armadura{
	var property refuerzo
	method unidadesLucha(){
		if(refuerzo != null)
		{
			return 2 + refuerzo.unidadesLucha()
		}
		else
		{
			return 2 
		}
	} 
}

object cotaDeMalla{
	method unidadesLucha() {
		return 1
	}	
}

object bendicion{
	var property luchador = rolando
	method unidadesLucha(){
		return luchador.nivelHechiceria()
	}
}

object hechizo{
	var property hechizo
	method unidadesLucha() {
		return hechizo.poder()
	}
}

object espejoFantastico{
	var property luchador = rolando
	var unidadesLucha
	method unidadesLucha(){
		if(luchador.artefactos() == [self])
		{
			return 0
		}
		luchador.removerArtefacto(self)
		unidadesLucha = luchador.artefactos().map({artefacto => artefacto.unidadesLucha()}).max()
		luchador.agregarArtefacto(self)
		return unidadesLucha
	}
	
}