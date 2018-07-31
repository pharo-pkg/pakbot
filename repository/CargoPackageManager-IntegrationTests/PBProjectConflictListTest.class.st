Class {
	#name : #PBProjectConflictListTest,
	#superclass : #PBAbstractTest,
	#instVars : [
		'resolution',
		'registry',
		'project',
		'configurationProjectV1',
		'configurationProjectV2',
		'configurationProject2V1',
		'configurationProject2V2'
	],
	#category : #'CargoPackageManager-IntegrationTests'
}

{ #category : #running }
PBProjectConflictListTest >> setUp [

	super setUp.
	
	registry := CGOPackageRegistry new.	
	project := registry newProjectNamed: 'Test'.
	
	configurationProjectV1 := PBMetacelloConfigurationProjectDependency
		name: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '1.0'.

	configurationProjectV2 := PBMetacelloConfigurationProjectDependency
		name: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '2.0'.

	configurationProject2V1 := PBMetacelloConfigurationProjectDependency
		name: 'CargoTestExample2'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '1.0'.

	configurationProject2V2 := PBMetacelloConfigurationProjectDependency
		name: 'CargoTestExample2'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '2.0'.
		
]

{ #category : #tests }
PBProjectConflictListTest >> testConflictingDependenciesToSameProjectAreFlattenedInOneConflict [

	project addDependency: configurationProjectV1.
	project addDependency: configurationProjectV2.	

	resolution := project resolve.

	self assert: resolution conflicts size equals: 1.

]

{ #category : #tests }
PBProjectConflictListTest >> testConflictingDependenciesToSameProjectHaveCorrectProjectName [

	| conflict |
	project addDependency: configurationProjectV1.
	project addDependency: configurationProjectV2.	

	resolution := project resolve.
	conflict := resolution conflicts anyOne. 

	self assert: conflict projectName equals: configurationProjectV1 name
]

{ #category : #tests }
PBProjectConflictListTest >> testConflictingDependenciesToSameProjectHaveTwoTheTwoDependencies [

	| conflict |
	project addDependency: configurationProjectV1.
	project addDependency: configurationProjectV2.	

	resolution := project resolve.
	conflict := resolution conflicts anyOne. 

	self assertCollection: conflict conflictingDependencies  hasSameElements: { 
		resolution resolutionFor: configurationProjectV1. 
		resolution resolutionFor: configurationProjectV2 }.
]

{ #category : #tests }
PBProjectConflictListTest >> testConflictingDependenciesToTwoProjectsHaveTwoConflicts [

	project addDependency: configurationProjectV1.
	project addDependency: configurationProjectV2.	
	project addDependency: configurationProject2V1.
	project addDependency: configurationProject2V2.	

	resolution := project resolve.

	self assert: resolution conflicts size equals: 2.

]
