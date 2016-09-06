tests
testFromSton
	| pkgAssembly |
	pkgAssembly := STON fromString: self assemblyFooStonString.
	self
		assert: pkgAssembly version
		equals: '1' asSemanticVersion.
	self
		assert: pkgAssembly packageName
		equals: 'Foo'.
	self assert: ((pkgAssembly parts collect: #class) anySatisfy: [ :class | class = CGOPackageDependency ])