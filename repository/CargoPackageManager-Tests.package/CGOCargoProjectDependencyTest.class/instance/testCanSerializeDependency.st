tests
testCanSerializeDependency
	| projectDependency projectDependencyString |
	projectDependency := CGOCargoProjectDependency named: 'pharo-counter' repositoryUrl: 'github://demarey/pharo-counter-ui:master'.
	projectDependencyString := STON toStringPretty: projectDependency.
	
	self 
		assert: projectDependencyString
		equals: 'CGOCargoProjectDependency {
	#repository : CGOGitRepository {
		#repositoryUrl : ''git://git@github.com/demarey/pharo-counter-ui.git'',
		#version : ''master''
	},
	#name : ''pharo-counter'',
	#version : ''''
}'.