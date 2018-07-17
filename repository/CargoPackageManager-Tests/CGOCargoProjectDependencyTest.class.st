Class {
	#name : #CGOCargoProjectDependencyTest,
	#superclass : #TestCase,
	#category : 'CargoPackageManager-Tests-Model'
}

{ #category : #tests }
CGOCargoProjectDependencyTest >> testCanCreateDependency [
	| dependency |
	dependency := CGOCargoProjectDependency example.
	self 
		assert: dependency repositoryUrl
		equals: 'git://git@github.com/demarey/pharo-counter.git'.

]

{ #category : #tests }
CGOCargoProjectDependencyTest >> testCanDeserializeDependency [
	| dependency |
	dependency := STON fromString: 'CGOCargoProjectDependency {
			#repository : CGOGitRepository {
				#repositoryUrl : ''git://git@github.com/demarey/pharo-counter-ui.git''
			}
		}'.
	self 
		assert: dependency repositoryUrl
		equals: 'git://git@github.com/demarey/pharo-counter-ui.git'.

]

{ #category : #tests }
CGOCargoProjectDependencyTest >> testCanSerializeDependency [
	| projectDependency projectDependencyString |
	projectDependency := CGOCargoProjectDependency named: 'pharo-counter' repositoryUrl: 'github://demarey/pharo-counter-ui:master'.
	projectDependencyString := STON toStringPretty: projectDependency.
	
	self 
		assert: projectDependencyString
		equals: '{
	#name : ''pharo-counter'',
	#repository : {
		#type : #git,
		#repositoryUrl : ''git://git@github.com/demarey/pharo-counter-ui.git'',
		#version : ''master''
	},
	#version : ''''
}'
]
