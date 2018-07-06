tests
testCanCreateDependency
	| dependency |
	dependency := CGOCargoProjectDependency example.
	self 
		assert: dependency repositoryUrl
		equals: 'git://git@github.com:demarey/pharo-counter.git'.
	self 
		assert: dependency version
		equals: 'master'.