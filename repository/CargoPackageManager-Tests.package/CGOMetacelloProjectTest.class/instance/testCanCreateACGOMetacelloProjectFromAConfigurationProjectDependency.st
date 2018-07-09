tests
testCanCreateACGOMetacelloProjectFromAConfigurationProjectDependency
	| project |
	project := CGOMetacelloProject exampleConfiguration.
	
	self 
		assert: project name
		equals: 'JSON'.
	
	self
		assert: project version
		equals: #stable.
		
	self 	
		assert: project repository
		equals: 'http://smalltalkhub.com/mc/PharoExtras/JSON/main/' asZnUrl.
		
	self assert: project isConfiguration