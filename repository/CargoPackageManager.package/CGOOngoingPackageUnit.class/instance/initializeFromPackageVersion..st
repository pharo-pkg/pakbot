initialization
initializeFromPackageVersion: aCGOPackageVersion
	super initialize.
	package := aCGOPackageVersion package.
	version := aCGOPackageVersion version deepCopy.
	description := aCGOPackageVersion copy.
	timestamp := DateAndTime now.
	"projectName := aCGOPackageVersion projectName copy."
	dependencies := aCGOPackageVersion dependencies collect: #copy as: OrderedCollection.
	self provisions: aCGOPackageVersion provisions.
	platformRequirements := aCGOPackageVersion platformRequirements asOrderedCollection.	
	src := aCGOPackageVersion sourcePackageVersion deepCopy.