initialization
initializeWithProject: aCGOProject
	name := aCGOProject packageName.
	description := aCGOProject description.
	repository := aCGOProject repository asSerializableRepository.
	version := aCGOProject version asString.
	unitNames := self toArrayOrNilIfEmpty: aCGOProject packageUnitNames.
	assemblies := self toArrayOrNilIfEmpty: aCGOProject assemblies "asVcsSerializedAssembly?".
	virtualPackages := self toArrayOrNilIfEmpty: (aCGOProject virtualPackages collect: #asVcsSerializedPackageVersion).
	authors := self toArrayOrNilIfEmpty: aCGOProject authors.