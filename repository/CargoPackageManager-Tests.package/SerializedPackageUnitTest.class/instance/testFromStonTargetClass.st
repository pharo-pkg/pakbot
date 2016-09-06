tests
testFromStonTargetClass
	| ston |
	ston := CGOPackageVersionWriter toStringPretty: 
				(CGOSerializedPackageUnit new
					instVarNamed: 'package' put: #A;
					instVarNamed: 'version' put: '1.0.0' asSemanticVersion;
					yourself).
	self 
		assert: (CGOPackageVersionReader fromString: ston) class
		equals: CGOPackageUnit