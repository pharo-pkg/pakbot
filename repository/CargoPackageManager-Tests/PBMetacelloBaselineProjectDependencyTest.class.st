Class {
	#name : #PBMetacelloBaselineProjectDependencyTest,
	#superclass : #TestCase,
	#category : #'CargoPackageManager-Tests-Model'
}

{ #category : #tests }
PBMetacelloBaselineProjectDependencyTest >> testCanBeConvertedToPakbotDependency [
	| dependency converted |
	dependency := PBMetacelloBaselineProjectDependency example.
	dependency 
		platformRequirements: #( 'pharo');
		loads: #( 'core' ).
	
	converted := dependency asPakbotProjectDependency.
	
	self 
		assert: converted name
		equals: dependency name.
	self 
		assert: converted repositoryUrl
		equals: dependency repositoryUrl.
	self 
		assert: converted version
		equals: dependency version.
	self 
		assert: converted platformRequirements
		equals: dependency platformRequirements.
	self 
		assert: converted packagesToLoad
		equals: dependency packagesToLoad.

]

{ #category : #tests }
PBMetacelloBaselineProjectDependencyTest >> testCanCreateDependency [
	| dependency |
	dependency := PBMetacelloBaselineProjectDependency example.
	self 
		assert: dependency name
		equals: #PakbotTestExample.
	self 
		assert: dependency repositoryUrl asString
		equals: 'ssh://git@github.com/pharo-pkg/PakbotTestExample.git'.
	self 
		assert: dependency version
		equals: '0866472ddded2a8fc36d3bae23f01aecfe947dc7'.
]

{ #category : #tests }
PBMetacelloBaselineProjectDependencyTest >> testCanDeserializeDependency [
	| dependency |
	dependency := STON fromString: 'MetacelloBaselineProject {
	#baseline : #PakbotTestExample,
	#url : ''git://git@github.com/pharo-pkg/PakbotTestExample.git'',
	#version : ''0866472ddded2a8fc36d3bae23f01aecfe947dc7''
}'.
	self 
		assert: dependency repositoryUrl
		equals: 'git://git@github.com/pharo-pkg/PakbotTestExample.git'.
	self 
		assert: dependency version
		equals: '0866472ddded2a8fc36d3bae23f01aecfe947dc7'.
]

{ #category : #tests }
PBMetacelloBaselineProjectDependencyTest >> testCanSerializeDependency [
	| projectDependencyString |
	projectDependencyString := STON toStringPretty: PBMetacelloBaselineProjectDependency example.
	
	self 
		assert: projectDependencyString
		equals: '{
	#baseline : #PakbotTestExample,
	#url : ''ssh://git@github.com/pharo-pkg/PakbotTestExample.git'',
	#version : ''0866472ddded2a8fc36d3bae23f01aecfe947dc7''
}'.
]

{ #category : #tests }
PBMetacelloBaselineProjectDependencyTest >> testIcebergUrlWhenGitUrlProvided [
	| dependency |
	dependency := PBMetacelloBaselineProjectDependency 
		name: 'PakbotTestExample'
		repositoryUrl: 'git://git@github.com/pharo-pkg/PakbotTestExample.git'
		version: '2.0'.
		
	self 
		assert: dependency icebergUrl
		equals: 'git@github.com:pharo-pkg/PakbotTestExample.git'.
]

{ #category : #tests }
PBMetacelloBaselineProjectDependencyTest >> testIcebergUrlWhenMetacelloGithubUrlProvided [
	| dependency |
	dependency := PBMetacelloBaselineProjectDependency 
		name: 'PakbotTestExample'
		repositoryUrl: 'github://pharo-pkg/PakbotTestExample'
		version: '2.0'.
		
	self 
		assert: dependency icebergUrl
		equals: 'git@github.com:pharo-pkg/PakbotTestExample.git'.
]
