Class {
	#name : #PBPakbotProjectDependencyStatusTest,
	#superclass : #PBDependencyStatusTest,
	#category : #'CargoPackageManager-IntegrationTests-DependencyStatus'
}

{ #category : #utils }
PBPakbotProjectDependencyStatusTest >> createProjectDependency [
	^ PBPakbotProjectDependency named: 'AnotherProject' version: '=0.0.0-N/A'
		
]

{ #category : #utils }
PBPakbotProjectDependencyStatusTest >> installProject [
	
	| newProject |
	newProject := PBProject named: 'AnotherProject'.
	testRegistry register: newProject.
	newProject importPackageNamed: #AnotherPackage.
]
