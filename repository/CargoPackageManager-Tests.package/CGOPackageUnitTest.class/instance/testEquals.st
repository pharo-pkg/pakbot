tests
testEquals
	| pkgA pkgB project |
	
	pkgA := CGOPackageUnit example. "UnitTest@2.1"
	pkgB := CGOPackageUnit example
				instVarNamed: 'package' put: (CGOPackageProvider default packageNamed: #UnitFoo);
				yourself.  "UnitFoo@2.1"
	
	self assert: pkgA equals: CGOPackageUnit example.
	self assert: pkgA ~= pkgB.
	
	project := CGOPackageUnit example project 
		instVarNamed: 'version' put: '2.0' asSemanticVersion;
		yourself.
	pkgA instVarNamed: 'project' put: project.
	self assert: pkgA ~= CGOPackageUnit example.