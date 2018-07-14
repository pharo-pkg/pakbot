Class {
	#name : #CGOMetacelloConfigurationProjectDependencyTest,
	#superclass : #TestCase,
	#category : 'CargoPackageManager-Tests-Model'
}

{ #category : #tests }
CGOMetacelloConfigurationProjectDependencyTest >> testCanCreateDependency [
	| dependency |
	dependency := PBMetacelloConfigurationProjectDependency example.
	self 
		assert: dependency name
		equals: #JSON.
	self 
		assert: dependency repositoryUrl asString
		equals: 'http://smalltalkhub.com/mc/PharoExtras/JSON/main/'.
	self 
		assert: dependency version
		equals: #stable.
]

{ #category : #tests }
CGOMetacelloConfigurationProjectDependencyTest >> testCanDeserializeDependency [
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
]

{ #category : #tests }
CGOMetacelloConfigurationProjectDependencyTest >> testCanSerializeDependency [
	| projectDependencyString |
	projectDependencyString := STON toStringPretty: PBMetacelloConfigurationProjectDependency example.
	
	self 
		assert: projectDependencyString
		equals: 'MetacelloConfigurationProject {
	#configuration : #JSON,
	#url : ''http://smalltalkhub.com/mc/PharoExtras/JSON/main/'',
	#version : #stable
}'.
]
