tests
testCanSerializeDependency
	| projectDependencyString |
	projectDependencyString := STON toStringPretty: CGOMetacelloConfigurationProjectDependency example.
	
	self 
		assert: projectDependencyString
		equals: 'CGOMetacelloConfigurationProjectDependency {
	#url : ''http://smalltalkhub.com/mc/PharoExtras/JSON/main/'',
	#version : #stable
}'.