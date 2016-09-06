tests
testEquals
	| pkgA pkgB |
	
	pkgA := CGOPackageVersion fromString: 'A@1.0'.
	pkgB := CGOPackageVersion fromString: 'B@1.0'.
	
	self assert: pkgA equals: (CGOPackageVersion fromString: 'A@1.0').
	self assert: pkgA ~= pkgB.
	
	pkgB := CGOPackageVersion fromString: 'A@1.0'.
	self assert: pkgA equals: pkgB.
	
	pkgA instVarNamed: 'version' put: '1.1' asSemanticVersion.
	self assert: pkgA ~= (CGOPackageVersion fromString: 'B@0').