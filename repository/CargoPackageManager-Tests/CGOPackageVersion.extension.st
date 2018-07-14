Extension { #name : #CGOPackageVersion }

{ #category : #'*CargoPackageManager-Tests' }
CGOPackageVersion class >> fromString: aString [
	"Utility method for tests"
	"self fromString: 'Foo@1.2' "	
	^ self fromString: aString project: CGOProject example
]

{ #category : #'*CargoPackageManager-Tests' }
CGOPackageVersion class >> fromString: aString project: aCGOProject [
	"Utility method for tests"
	"self fromString: #Foo project: CGOProject example "	
	| pkgVersionReference |
	pkgVersionReference := aString asPackageVersionReference.
	aCGOProject instVarNamed: 'version' put: pkgVersionReference versionString.
	^ self 
		newFrom: { #package -> pkgVersionReference packageName .
			#project -> aCGOProject } asDictionary
]
