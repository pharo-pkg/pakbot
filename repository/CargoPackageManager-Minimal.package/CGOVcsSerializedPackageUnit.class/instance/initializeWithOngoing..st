initialization
initializeWithOngoing: aCGOOngoingPackageUnit
	super initializeWithOngoing: aCGOOngoingPackageUnit.
	dependencies := self serializedDependenciesOf: aCGOOngoingPackageUnit dependencies.
	platformRequirements := self toArrayOrNilIfEmpty: aCGOOngoingPackageUnit platformRequirements.
	provisions := self toArrayOrNilIfEmpty: aCGOOngoingPackageUnit provisions