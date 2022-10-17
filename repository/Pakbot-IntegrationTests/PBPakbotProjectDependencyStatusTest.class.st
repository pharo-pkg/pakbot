Class {
	#name : #PBPakbotProjectDependencyStatusTest,
	#superclass : #PBDependencyStatusTest,
	#category : #'Pakbot-IntegrationTests-DependencyStatus'
}

{ #category : #utils }
PBPakbotProjectDependencyStatusTest >> createProjectDependency [
	^ PBPakbotProjectDependency named: 'AnotherProject' version: '=0.1'
		
]

{ #category : #utils }
PBPakbotProjectDependencyStatusTest >> installProject [
	
	| newProject |
	newProject := PBProjectVersion named: 'AnotherProject'.
	newProject 
		repository: PBGitMemoryRepository new;
		version: '0.1'.
	testRegistry register: newProject.
	newProject importPackageNamed: #AnotherPackage.
]
