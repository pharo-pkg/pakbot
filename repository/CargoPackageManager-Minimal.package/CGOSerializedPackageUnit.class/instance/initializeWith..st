initialization
initializeWith: aPackageUnit
	super initializeWith: aPackageUnit.
	src := aPackageUnit sourcePackageVersion.
	self initializeDependenciesWith: aPackageUnit.
	platformRequirements := self toArrayOrNilIfEmpty: aPackageUnit platformRequirements.
	provisions := self toArrayOrNilIfEmpty: aPackageUnit provisions