instance creation
fromString: aString
	"self fromString: 'Foo@1.2' "	
	| pkgVersionReference |
	pkgVersionReference := aString asPackageVersionReference.
	^ self 
		newFrom: { #package -> pkgVersionReference packageName .
			#version -> pkgVersionReference versionNumber } asDictionary