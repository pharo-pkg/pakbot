tests
testFromStonWithApkg
	| pkgVersion constraints |
	
	pkgVersion := STON fromString: self a100WithDependencies.

	self assert: pkgVersion packageName equals: #A.
	self assert: pkgVersion version equals: (SemanticVersion fromString: '1.0').
	self assert: pkgVersion description equals: 'A test package version.'.
	self 
		assert: (pkgVersion sourceRepository instVarNamed: 'repositoryUrl')
		equals: 'http://smalltalkhub.com/mc/Foo/Bar/main' asUrl.	
	self assert: pkgVersion dependencies size equals: 2.
	self assert: pkgVersion dependencies first targetedPackage equals: #B.
	self assert: pkgVersion dependencies second targetedPackage equals: #C.
	constraints := pkgVersion dependencies second constraints.
	self assert: constraints size equals: 2.
	self assert: constraints first asString equals: '=1.0.0'