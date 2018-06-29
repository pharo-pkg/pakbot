tests
testCanDeserializeDependency
	| dependency |
	dependency := STON fromString: 'CGOCargoProjectDependency {
			#repository : CGOGitRepository {
				#repositoryUrl : ''git+ssh://git@github.com/demarey/pharo-counter-ui.git'',
				#version : ''master''
			}
		}'.
	self 
		assert: dependency repositoryUrl
		equals: 'git@github.com:demarey/pharo-counter-ui.git'.
	self 
		assert: dependency version
		equals: 'master'.