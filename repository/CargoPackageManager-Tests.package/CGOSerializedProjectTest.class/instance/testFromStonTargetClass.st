tests
testFromStonTargetClass
	| ston |
	ston := CGOPackageVersionWriter toStringPretty: 
				(CGOProject new
					instVarNamed: 'name' put: #A;
					instVarNamed: 'version' put: '1.0.0' asSemanticVersion;
					yourself).
	self 
		assert: (STON fromString: ston) class
		equals: CGOProject