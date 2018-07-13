tests
testCanSerializeDependency
	| projectDependencyString |
	projectDependencyString := STON toStringPretty: PBMetacelloConfigurationProjectDependency example.
	
	self 
		assert: projectDependencyString
		equals: 'MetacelloConfigurationProject {
	#configuration : #JSON,
	#url : ''http://smalltalkhub.com/mc/PharoExtras/JSON/main/'',
	#version : #stable
}'.