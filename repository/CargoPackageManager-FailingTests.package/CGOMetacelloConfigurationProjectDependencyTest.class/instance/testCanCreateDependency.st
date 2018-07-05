tests
testCanCreateDependency
	| dependency |
	dependency := CGOMetacelloConfigurationProjectDependency example.
	self 
		assert: dependency repositoryUrl asString
		equals: 'http://smalltalkhub.com/mc/PharoExtras/JSON/main/'.
	self 
		assert: dependency version
		equals: #stable.