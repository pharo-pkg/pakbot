Class {
	#name : #CGOMetacelloConfigurationDependencyStatusTest,
	#superclass : #CGODependencyStatusTest,
	#category : 'CargoPackageManager-IntegrationTests'
}

{ #category : #utils }
CGOMetacelloConfigurationDependencyStatusTest >> createProjectDependency [
	^ PBMetacelloConfigurationProjectDependency  
		name: 'JSON'
		repositoryUrl: 'http://smalltalkhub.com/mc/PharoExtras/JSON/main/'
		version: '1.2'
]

{ #category : #utils }
CGOMetacelloConfigurationDependencyStatusTest >> installProject [

	Metacello new
		configuration: 'JSON';
		repository: 'http://smalltalkhub.com/mc/PharoExtras/JSON/main/';
		version: '1.2';
		load.

]

{ #category : #running }
CGOMetacelloConfigurationDependencyStatusTest >> tearDown [

	(#JSON asPackageIfAbsent: [ nil ]) ifNotNil: #removeFromSystem.	
	MetacelloProjectRegistration registry configurationRegistry removeKey: 'ConfigurationOfJSON' ifAbsent: [].
	
	super tearDown.
	
]
