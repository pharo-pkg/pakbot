Class {
	#name : #CGOPakbotProjectDependencyStatusTest,
	#superclass : #CGODependencyStatusTest,
	#category : #'CargoPackageManager-IntegrationTests'
}

{ #category : #utils }
CGOPakbotProjectDependencyStatusTest >> createProjectDependency [
	^ PBPakbotProjectDependency named: 'AnotherProject' version: '=0.0.0-N/A'
		
]

{ #category : #utils }
CGOPakbotProjectDependencyStatusTest >> installProject [
	
	| newProject |
	newProject := PBProject named: 'AnotherProject'.
	testRegistry register: newProject.
	newProject importPackageNamed: #AnotherPackage.
]
