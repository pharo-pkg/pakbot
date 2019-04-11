Class {
	#name : #PBMetacelloConfigurationDependencyStatusTest,
	#superclass : #PBDependencyStatusTest,
	#category : #'CargoPackageManager-IntegrationTests-DependencyStatus'
}

{ #category : #utils }
PBMetacelloConfigurationDependencyStatusTest >> createProjectDependency [

	^ PBMetacelloConfigurationProjectDependency  
		name: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '1.0'
]

{ #category : #utils }
PBMetacelloConfigurationDependencyStatusTest >> installProject [

	Metacello new
		configuration: 'CargoTestExample';
		repository: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main';
		version: '1.0';
		load.

]
