Class {
	#name : #PBParametrizedConflictTest,
	#superclass : #PBAbstractTest,
	#instVars : [
		'project',
		'dependencyOne',
		'dependencyTwo',
		'registry',
		'expectedConflicts'
	],
	#category : #'CargoPackageManager-IntegrationTests-Conflicts'
}

{ #category : #private }
PBParametrizedConflictTest class >> isAbstract [
	^ self name = #PBParametrizedConflictTest 
]

{ #category : #utilities }
PBParametrizedConflictTest >> addDependency: aDependency [
	aDependency ifNotNil: [ project addDependency: aDependency ]
]

{ #category : #utilities }
PBParametrizedConflictTest >> createBaseline: aVersion [
	^ PBMetacelloBaselineProjectDependency  
		name: 'PakbotTestExample'
		repositoryUrl: 'github://pharo-pkg/PakbotTestExample'
		version: aVersion
]

{ #category : #utilities }
PBParametrizedConflictTest >> createConfiguration: aVersion [
	^ PBMetacelloConfigurationProjectDependency 
		name: 'CargoTestExample' 
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main' 
		version: aVersion
]

{ #category : #utilities }
PBParametrizedConflictTest >> createInstalledBaseline: aString [

	| conf |
	conf := self createBaseline: aString.
	(PBMetacelloBaselineProject fromProjectDependency: conf) basicLoad.
	^ conf
]

{ #category : #utilities }
PBParametrizedConflictTest >> createInstalledConfiguration: aString [

	| conf |
	conf := self createConfiguration: aString.
	(PBMetacelloConfigurationProject fromProjectDependency: conf) basicLoad.
	^ conf
]

{ #category : #accessing }
PBParametrizedConflictTest >> dependencyOne [
	^ dependencyOne
]

{ #category : #accessing }
PBParametrizedConflictTest >> dependencyOne: anObject [
	dependencyOne := anObject
]

{ #category : #accessing }
PBParametrizedConflictTest >> dependencyTwo [
	^ dependencyTwo
]

{ #category : #accessing }
PBParametrizedConflictTest >> dependencyTwo: anObject [
	dependencyTwo := anObject
]

{ #category : #accessing }
PBParametrizedConflictTest >> expectedConflicts [
	^ expectedConflicts
]

{ #category : #accessing }
PBParametrizedConflictTest >> expectedConflicts: anObject [
	expectedConflicts := anObject
]

{ #category : #utilities }
PBParametrizedConflictTest >> installBaseline: aString [

	self createInstalledBaseline: aString.
	^ nil
]

{ #category : #utilities }
PBParametrizedConflictTest >> installConfiguration: aString [

	self createInstalledConfiguration: aString.
	^ nil
]

{ #category : #private }
PBParametrizedConflictTest >> setUp [
	super setUp.
	registry := CGOPackageRegistry new.	

]

{ #category : #tests }
PBParametrizedConflictTest >> testShouldHaveConflicts [

	project := registry newProjectNamed: 'Test'.
	self addDependency: dependencyOne.
	self addDependency: dependencyTwo.
	
	self assert: project resolve hasConflicts equals: expectedConflicts
]

{ #category : #tests }
PBParametrizedConflictTest >> testWithConflictsIsResolvedWithTheFirstOne [

	"I only run, when there is conflicts"
	| resolution conflict selected |
	self expectedConflicts ifFalse: [ self skip ].

	project := registry newProjectNamed: 'Test'.
	self addDependency: dependencyOne.
	self addDependency: dependencyTwo.
	
	resolution := project resolve.
	conflict := resolution conflicts anyOne.
	
	selected := conflict resolutionFor: dependencyOne.
	
	conflict selectedResolution: selected.
	conflict resolveWithSelected.
	
	self deny: resolution hasConflicts
	
]

{ #category : #tests }
PBParametrizedConflictTest >> testWithConflictsIsResolvedWithTheSecondOne [

	"I only run, when there is conflicts"
	| resolution conflict selected |
	self expectedConflicts ifFalse: [ self skip ].

	project := registry newProjectNamed: 'Test'.
	self addDependency: dependencyOne.
	self addDependency: dependencyTwo.
	
	resolution := project resolve.
	conflict := resolution conflicts anyOne.

	"I have to handle the case when there is only one dependency and the other is already installed"	
	selected := dependencyTwo 
					ifNil: [(conflict dependencies detect: #isInstalledDependency) resolution ] 
					ifNotNil: [ conflict resolutionFor: dependencyTwo ].
		
	conflict selectedResolution: selected.
	conflict resolveWithSelected.
	
	self deny: resolution hasConflicts
	
]
