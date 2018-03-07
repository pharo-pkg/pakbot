tests
testCanSerializeDependency
	| projectDependency projectDependencyString |
	projectDependency := CGOCargoProjectDependency repositoryUrl: 'github://demarey/pharo-counter-ui:master'.
	projectDependencyString := STON toStringPretty: projectDependency.
	
	self 
		assert: projectDependencyString
		equals: 'CGOCargoProjectDependency {
	#repository : CGOGitRepository {
		#repositoryUrl : ''git+ssh://git@github.com/demarey/pharo-counter-ui.git'',
		#version : ''master''
	}
}'.