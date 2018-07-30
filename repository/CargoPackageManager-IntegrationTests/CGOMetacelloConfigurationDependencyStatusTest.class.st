Class {
	#name : #CGOMetacelloConfigurationDependencyStatusTest,
	#superclass : #CGODependencyStatusTest,
	#category : 'CargoPackageManager-IntegrationTests'
}

{ #category : #utils }
CGOMetacelloConfigurationDependencyStatusTest >> createProjectDependency [

	^ PBMetacelloConfigurationProjectDependency  
		name: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '1.0'
]

{ #category : #utils }
CGOMetacelloConfigurationDependencyStatusTest >> installProject [

	Metacello new
		configuration: 'CargoTestExample';
		repository: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main';
		version: '1.0';
		load.

]
