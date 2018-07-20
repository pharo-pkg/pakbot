Class {
	#name : #CGOOngoingDependencyStatusTest,
	#superclass : #CGODependencyStatusTest,
	#category : 'CargoPackageManager-IntegrationTests'
}

{ #category : #utils }
CGOOngoingDependencyStatusTest >> createProjectDependency [
	^ CGOCargoProjectDependency named: 'AnotherProject' version: '=0.0.0-N/A'
		
]

{ #category : #utils }
CGOOngoingDependencyStatusTest >> installProject [
	
	| newProject |
	newProject := CGOOngoingProject named: 'AnotherProject'.
	registry register: newProject.
	newProject importPackageNamed: #AnotherPackage.
]
