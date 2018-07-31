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

{ #category : #'building suites' }
PBParametrizedConflictTest class >> testParameters [

	^ ParametrizedTestMatrix new
		"Nothing Installed"
		addCase: { #dependencyOne -> [ :test | test createConfiguration: '1.0' ]. #dependencyTwo -> [ :test | test createConfiguration: '2.0' ]. #expectedConflicts -> true};
		addCase: { #dependencyOne -> [ :test | test createConfiguration: '1.0' ]. #dependencyTwo -> [ :test | test createConfiguration: '1.0' ]. #expectedConflicts -> false};
		addCase: { #dependencyOne -> [ :test | test createConfiguration: #stable ]. #dependencyTwo -> [ :test | test createConfiguration: '1.0' ]. #expectedConflicts -> true};
		addCase: { #dependencyOne -> [ :test | test createConfiguration: #stable ]. #dependencyTwo -> [ :test | test createConfiguration: '2.0' ]. #expectedConflicts -> false};

		"Installed"
		addCase: { #dependencyOne -> [ :test | test createConfiguration: '1.0' ]. #dependencyTwo -> [ :test | test createInstalledConfiguration: '2.0' ]. #expectedConflicts -> true};
		addCase: { #dependencyOne -> [ :test | test createConfiguration: '1.0' ]. #dependencyTwo -> [ :test | test createInstalledConfiguration: '1.0' ]. #expectedConflicts -> false};
		addCase: { #dependencyOne -> [ :test | test createConfiguration: #stable ]. #dependencyTwo -> [ :test | test createInstalledConfiguration: '1.0' ]. #expectedConflicts -> true};
		addCase: { #dependencyOne -> [ :test | test createConfiguration: #stable ]. #dependencyTwo -> [ :test | test createInstalledConfiguration: '2.0' ]. #expectedConflicts -> false};
		yourself
]

{ #category : #utilities }
PBParametrizedConflictTest >> createConfiguration: aVersion [
	^ PBMetacelloConfigurationProjectDependency 
		name: 'CargoTestExample' 
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main' 
		version: aVersion
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

{ #category : #private }
PBParametrizedConflictTest >> setUp [
	super setUp.
	registry := CGOPackageRegistry new.	

]

{ #category : #tests }
PBParametrizedConflictTest >> testShouldHaveConflicts [

	project := registry newProjectNamed: 'Test'.
	project addDependency: dependencyOne.
	project addDependency: dependencyTwo.
	
	self assert: project resolve hasConflicts equals: expectedConflicts
]

{ #category : #tests }
PBParametrizedConflictTest >> testWithConflictsIsResolvedWithTheFirstOne [

	"I only run, when there is conflicts"
	| resolution |
	self expectedConflicts ifFalse: [ self skip ].

	project := registry newProjectNamed: 'Test'.
	project addDependency: dependencyOne.
	project addDependency: dependencyTwo.
	
	resolution := project resolve.
	
	self halt.
	
]
