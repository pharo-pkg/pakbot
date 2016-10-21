initialization
initializeWith: aPackageUnit
	super initializeWith: aPackageUnit.
	src := aPackageUnit sourcePackage ifNotNil: [:srcPkg | srcPkg asSerializableSourcePackageVersion].
	self initializeDependenciesWith: aPackageUnit.
	authors := self toArrayOrNilIfEmpty: aPackageUnit authors.
	contributors := self toArrayOrNilIfEmpty: aPackageUnit contributors.
	platformRequirements := self toArrayOrNilIfEmpty: aPackageUnit platformRequirements.
	provisions := self toArrayOrNilIfEmpty: aPackageUnit provisions