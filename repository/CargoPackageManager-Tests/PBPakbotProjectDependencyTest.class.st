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
		assert: dependency name
		equals: #'pharo-counter'.
	self 
		assert: dependency version
		equals: 'main'.
	self 
		assert: dependency repositoryUrl
		equals: 'https://github.com/pharo-pkg/pharo-counter.git'.

]

{ #category : #tests }
PBPakbotProjectDependencyTest >> testCanDeserializeDependency [

	| dependency |
	dependency := STON fromString: 'PakbotProject {
	#project : ''pharo-counter'',
	#url : ''https://github.com/pharo-pkg/pharo-counter.git'',
	#version : ''main''
}'.
	
	self
		assert: dependency repositoryUrl
		equals: 'https://github.com/pharo-pkg/pharo-counter.git'
]

{ #category : #tests }
PBPakbotProjectDependencyTest >> testCanSerializeDependency [

	| projectDependencyString |
	
	projectDependencyString := STON toStringPretty: PBPakbotProjectDependency example.

	self assert: projectDependencyString equals: '{
	#project : ''pharo-counter'',
	#url : ''https://github.com/pharo-pkg/pharo-counter.git'',
	#version : ''main''
}'
]

{ #category : #tests }
PBPakbotProjectDependencyTest >> testFetchRaiseErrorWhenNoRepositoryDefined [

	| dependency |
	dependency := PBPakbotProjectDependency named: 'foo' version: 'v1.0'.
	
	self
		should: [ dependency fetch ]
		raise: PBMissingSourceRepositoryError

]
