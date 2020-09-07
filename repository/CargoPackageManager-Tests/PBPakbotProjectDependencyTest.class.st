Class {
	#name : #PBPakbotProjectDependencyTest,
	#superclass : #TestCase,
	#category : #'CargoPackageManager-Tests-Model'
}

{ #category : #tests }
PBPakbotProjectDependencyTest >> testCanCreateDependency [
	| dependency |
	dependency := PBPakbotProjectDependency example.
	self 
		assert: dependency repositoryUrl
		equals: 'git@github.com:demarey/pharo-counter.git'.

]

{ #category : #tests }
PBPakbotProjectDependencyTest >> testCanDeserializeDependency [
	| dependency dict |
	dict := STON fromString: '{
	#name : ''pharo-counter'',
	#repository : {
		#type : #git,
		#repositoryUrl : ''git://git@github.com/demarey/pharo-counter-ui.git'',
		#version : ''master''
	},
	#version : ''''
}'.
	dependency := PBVcsSerializedProject new pakbotProjectDependencyFrom: dict.
	self 
		assert: dependency repositoryUrl
		equals: 'git://git@github.com/demarey/pharo-counter-ui.git'.

]

{ #category : #tests }
PBPakbotProjectDependencyTest >> testCanSerializeDependency [
	| projectDependency projectDependencyString |
	projectDependency := PBPakbotProjectDependency named: 'pharo-counter' repositoryUrl: 'git@github.com:demarey/pharo-counter-ui.git'.
	projectDependency repository version: 'master'.
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
