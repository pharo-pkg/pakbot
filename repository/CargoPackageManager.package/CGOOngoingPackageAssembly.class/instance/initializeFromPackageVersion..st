initialization
initializeFromPackageVersion: aCGOPackageVersion
	super initialize.
	package := aCGOPackageVersion package.
	description := aCGOPackageVersion copy.
	parts := aCGOPackageVersion dependencies collect: #copy as: OrderedCollection.
