testing
hasPackage: aPackageName
	packageNames add: aPackageName.
	"No way to check that the package exist in the current Metacello project without actually loading the code.
	We just remember the package name and assume it is valid."
	^ true