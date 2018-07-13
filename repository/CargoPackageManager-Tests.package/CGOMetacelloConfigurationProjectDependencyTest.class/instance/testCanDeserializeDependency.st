tests
testCanDeserializeDependency
	| dependency |
	dependency := STON fromString: 'MetacelloConfigurationProject {
	#configuration : #JSON,
	#url : ''http://smalltalkhub.com/mc/PharoExtras/JSON/main/'',
	#version : #stable
}'.
	self 
		assert: dependency repositoryUrl
		equals: 'http://smalltalkhub.com/mc/PharoExtras/JSON/main/' asZnUrl.
	self 
		assert: dependency version
		equals: #stable.