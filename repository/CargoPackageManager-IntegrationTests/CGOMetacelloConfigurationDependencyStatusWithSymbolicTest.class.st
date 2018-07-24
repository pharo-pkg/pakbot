Class {
	#name : #CGOMetacelloConfigurationDependencyStatusWithSymbolicTest,
	#superclass : #CGODependencyStatusTest,
	#category : #'CargoPackageManager-IntegrationTests'
}

{ #category : #utils }
CGOMetacelloConfigurationDependencyStatusWithSymbolicTest >> createProjectDependency [
	^ PBMetacelloConfigurationProjectDependency  
		name: 'JSON'
		repositoryUrl: 'http://smalltalkhub.com/mc/PharoExtras/JSON/main/'
		version: #stable
]

{ #category : #utils }
CGOMetacelloConfigurationDependencyStatusWithSymbolicTest >> installProject [

	Metacello new
		configuration: 'JSON';
		repository: 'http://smalltalkhub.com/mc/PharoExtras/JSON/main/';
		version: '1.2';
		load.

]

{ #category : #running }
CGOMetacelloConfigurationDependencyStatusWithSymbolicTest >> tearDown [

	(#JSON asPackageIfAbsent: [ nil ]) ifNotNil: #removeFromSystem.	
	MetacelloProjectRegistration registry configurationRegistry removeKey: 'ConfigurationOfJSON' ifAbsent: [].
	
	super tearDown.
	
]
