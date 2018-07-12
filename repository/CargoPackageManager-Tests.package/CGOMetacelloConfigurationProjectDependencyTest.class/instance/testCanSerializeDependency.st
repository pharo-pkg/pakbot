tests
testCanSerializeDependency
	| projectDependencyString |
	projectDependencyString := STON toStringPretty: CGOMetacelloConfigurationProjectDependency example.
	
	self 
		assert: projectDependencyString
		equals: 'CGOMetacelloConfigurationProject {
	#configuration : #JSON,
	#url : ''http://smalltalkhub.com/mc/PharoExtras/JSON/main/'',
	#version : #stable
}'.