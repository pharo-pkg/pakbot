Class {
	#name : #CGOOngoingDependencyStatusTest,
	#superclass : #CGODependencyStatusTest,
	#category : 'CargoPackageManager-IntegrationTests'
}

{ #category : #utils }
CGOOngoingDependencyStatusTest >> createProjectDependency [
	^ PBPakbotProjectDependency named: 'AnotherProject' version: '=0.0.0-N/A'
		
]

{ #category : #utils }
CGOOngoingDependencyStatusTest >> installProject [
	
	| newProject |
	newProject := PBProject named: 'AnotherProject'.
	testRegistry register: newProject.
	newProject importPackageNamed: #AnotherPackage.
]
