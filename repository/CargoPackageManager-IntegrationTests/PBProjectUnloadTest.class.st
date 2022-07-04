Class {
	#name : #PBProjectUnloadTest,
	#superclass : #PBAbstractTest,
	#instVars : [
		'project'
	],
	#category : #'CargoPackageManager-IntegrationTests'
}

{ #category : #tests }
PBProjectUnloadTest >> setUp [
	super setUp.

	project := testRegistry newProjectNamed: 'TestProject'.
	project 
		repository: PBGitMemoryRepository new;
		version: '1.0';
		createPackageNamed: 'TestProject-Pck1';
		newNotLoadedPackage: 'TestProject-Pck2'.
]

{ #category : #tests }
PBProjectUnloadTest >> tearDown [
	
	self removePackageIfExists: 'TestProject-Pck1'.
	
	super tearDown
]

{ #category : #tests }
PBProjectUnloadTest >> testAProjectToRemoveKnowsTheProjectsThatAffect [

	| project2 project3 |

	project2 := testRegistry newProjectNamed: 'TestProject2'.
	project2 version: '1.2'.
	project3 := testRegistry newProjectNamed: 'TestProject3'.
	project3 version: '1.3'.
	
	project2 addDependency: (PBPakbotProjectDependency named: 'TestProject' version: project version ).
	project3 addDependency: (PBPakbotProjectDependency named: 'TestProject2' version: project2 version ).	
	
	self assertCollection: project dependantProjects hasSameElements:  { project2. project3 }
]

{ #category : #tests }
PBProjectUnloadTest >> testUnloadKeepsThePackagesInTheSystem [
	
	| packageOrNil |
	project unload.
	
	packageOrNil := 'TestProject-Pck1' asPackageIfAbsent: [ nil ].	
	self assert: packageOrNil isNotNil.
]

{ #category : #tests }
PBProjectUnloadTest >> testUnloadRemovesTheProjectFromTheRegistry [
	
	project unload.
	
	self deny: (testRegistry isProjectRegistered: 'TestProject').
]

{ #category : #tests }
PBProjectUnloadTest >> testUnloadRemovingPackagesKeepsThePackagesInTheSystem [
	
	| packageOrNil |
	project unloadRemovingPackages.
	
	packageOrNil := 'TestProject-Pck1' asPackageIfAbsent: [ nil ].	
	self assert: packageOrNil isNil.
]

{ #category : #tests }
PBProjectUnloadTest >> testUnloadRemovingPackagesRemovesTheProjectFromTheRegistry [
	
	project unloadRemovingPackages.
	
	self deny: (testRegistry isProjectRegistered: project).
]
