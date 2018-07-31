Class {
	#name : #CGOMetacelloConfigurationDependencyStatusWithSymbolicTest,
	#superclass : #CGODependencyStatusTest,
	#category : #'CargoPackageManager-IntegrationTests'
}

{ #category : #utils }
CGOMetacelloConfigurationDependencyStatusWithSymbolicTest >> createProjectDependency [

	^ PBMetacelloConfigurationProjectDependency  
		name: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: #stable
]

{ #category : #utils }
CGOMetacelloConfigurationDependencyStatusWithSymbolicTest >> installProject [

	Metacello new
		configuration: 'CargoTestExample';
		repository: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main';
		version: #stable;
		load.

]
