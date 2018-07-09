tests
testCanGetImageDependencies
	| dependencyMap |
	dependencyMap := PMPackageDependenciesChecker new imageDependencies.
	
	self 
		assert: dependencyMap size
		equals: RPackage organizer packages size.
	
	self assert: dependencyMap keys anyOne isSymbol.
	self
		shouldnt: [ RPackage organizer packageNamed: dependencyMap keys anyOne ]
		raise: KeyNotFound.
	self assert: dependencyMap values anyOne isCollection
	
	.dependencyMap inspect