initialization
initializeWithProject: aCGOProject
	name := aCGOProject name.
	description := aCGOProject description.
	repository := aCGOProject repository asSerializableRepository.
	version := aCGOProject version asString.
	unitNames := self toArrayOrNilIfEmpty: aCGOProject packageUnitNames.
	assemblies := self toArrayOrNilIfEmpty: aCGOProject assemblies "asSerializableAssembly?".
	authors := self toArrayOrNilIfEmpty: aCGOProject authors.