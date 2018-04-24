*CargoPackageManager-Tests
fromString: aString project: aCGOProject
	"Utility method for tests"
	"self fromString: #Foo project: CGOProject example "	
	| pkgVersionReference |
	pkgVersionReference := aString asPackageVersionReference.
	aCGOProject instVarNamed: 'version' put: pkgVersionReference versionString.
	^ self 
		newFrom: { #package -> pkgVersionReference packageName .
			#project -> aCGOProject } asDictionary