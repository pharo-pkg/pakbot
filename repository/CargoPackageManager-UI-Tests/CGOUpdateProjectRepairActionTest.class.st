Class {
	#name : #CGOUpdateProjectRepairActionTest,
	#superclass : #PBAbstractTest,
	#instVars : [
		'registry',
		'project',
		'dependencyToProject'
	],
	#category : #'CargoPackageManager-UI-Tests'
}

{ #category : #'mocking RPackageOrganizer' }
CGOUpdateProjectRepairActionTest >> packageNamed: aString ifAbsent: aBlock [
	^ (project packageNames includes: aString)
		ifTrue: [ RPackage named: aString ] 
		ifFalse: [ aBlock value ]
]

{ #category : #running }
CGOUpdateProjectRepairActionTest >> setUp [
	super setUp.
	registry := PBPackageRegistry new.
	registry systemPackageOrganizer: self.
	project := registry newProjectNamed:'ATestProject'.

	dependencyToProject := (PBMetacelloConfigurationProjectDependency   
		name: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '2.0').

	project 
		repository: PBGitMemoryRepository new;
		importPackageNamed: #APackage.
	project addDependency: dependencyToProject
]

{ #category : #tests }
CGOUpdateProjectRepairActionTest >> testNotUpToDateProjectOfferUpdateProjectRepairAction [
	
	| repairActions |
	
	self deny: project isUpToDate.
	
	repairActions := CGORepairProjectAction allAvailableFor: project.
	
	self assert: (repairActions anySatisfy: [ :anAction | anAction isLoadProjectAction ])
]

{ #category : #tests }
CGOUpdateProjectRepairActionTest >> testNotUpToDateProjectOfferUpdateProjectRepairActionAndExecutingUpdateProject [
	
	| repairActions action dialog |
		
	repairActions := CGORepairProjectAction allAvailableFor: project.	
	action := repairActions detect: [ :anAction | anAction isLoadProjectAction ].

	dialog := action execute.
	
	dialog toolbar okButton performAction.
	
	self assert: project isUpToDate.
]
