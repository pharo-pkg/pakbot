initialization
initializeFromPackageVersion: aCGOPackageVersion
	super initialize.
	package := aCGOPackageVersion package.
	version := aCGOPackageVersion version deepCopy.
	description := aCGOPackageVersion copy.
	timestamp := DateAndTime now.
	parts := aCGOPackageVersion dependencies collect: #copy as: OrderedCollection.
	projectRepository := aCGOPackageVersion projectRepository deepCopy.
