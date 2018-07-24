Class {
	#name : #CGOConflictResolutionTest,
	#superclass : #CGOAbstractTest,
	#category : #'CargoPackageManager-IntegrationTests'
}

{ #category : #tests }
CGOConflictResolutionTest >> testConflictingMetacelloDependenciesCanBeResolvedUsingAVersion [

	| testRegistry projectOne dep2 dep1 conflict solution resolution |
	testRegistry := CGOPackageRegistry new.	
	dep2 := PBMetacelloConfigurationProjectDependency
		name: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '2.0'.

	dep1 := PBMetacelloConfigurationProjectDependency
		name: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '1.0'.

	projectOne := testRegistry newProjectNamed: 'ProjectOne'.
	projectOne addDependency: dep1.		
	projectOne addDependency: dep2.

	[ projectOne load. self fail. ] on: PBProjectHasConflictsError 
		do: [ :ex | 
			resolution := ex resolution.
			conflict := ex conflicts anyOne ].

	solution := conflict possibleResolutions detect: [ :aResolution | aResolution resolvedProjectVersion version = '1.0' ].
	conflict selectedResolution: solution.
	conflict resolveWithSelected.
	
	self deny: resolution hasConflicts.
	self assert: resolution loadInstructions size equals:1.
	self assert: resolution loadInstructions groups anyOne loadableUnits size equals:1 .
	self assert: (resolution loadInstructions groups anyOne loadableUnits allSatisfy: [ :e | e version = '1.0' ]).
	
	

]

{ #category : #tests }
CGOConflictResolutionTest >> testConflictingMetacelloDependenciesCanBeResolvedUsingAnotherVersion [

	| testRegistry projectOne dep2 dep1 conflict solution resolution |
	testRegistry := CGOPackageRegistry new.	
	dep2 := PBMetacelloConfigurationProjectDependency
		name: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '2.0'.

	dep1 := PBMetacelloConfigurationProjectDependency
		name: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '1.0'.

	projectOne := testRegistry newProjectNamed: 'ProjectOne'.
	projectOne addDependency: dep1.		
	projectOne addDependency: dep2.

	[ projectOne load. self fail. ] on: PBProjectHasConflictsError 
		do: [ :ex | 
			resolution := ex resolution.
			conflict := ex conflicts anyOne ].

	solution := conflict possibleResolutions detect: [ :aResolution | aResolution resolvedProjectVersion version = '2.0' ].
	conflict selectedResolution: solution.
	conflict resolveWithSelected.
	
	self deny: resolution hasConflicts.
	self assert: resolution loadInstructions size equals:1.
	self assert: resolution loadInstructions groups anyOne loadableUnits size equals:1 .
	self assert: (resolution loadInstructions groups anyOne loadableUnits allSatisfy: [ :e | e version = '2.0' ]).
	
	

]

{ #category : #tests }
CGOConflictResolutionTest >> testConflictingMetacelloDependenciesExceptionHasConflicts [

	| testRegistry projectOne |
	testRegistry := CGOPackageRegistry new.	
	projectOne := testRegistry newProjectNamed: 'ProjectOne'.
	projectOne addDependency: (PBMetacelloConfigurationProjectDependency
		name: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '1.0').		
	projectOne addDependency: (PBMetacelloConfigurationProjectDependency
		name: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '2.0').

	[ projectOne load ] on: PBProjectHasConflictsError 
	do: [ :ex | self assert: ex conflicts isNotEmpty ]

]

{ #category : #tests }
CGOConflictResolutionTest >> testConflictingMetacelloDependenciesExceptionHasOneConflictForTheDependency [

	| testRegistry projectOne dep2 dep1 |
	testRegistry := CGOPackageRegistry new.	
	dep2 := PBMetacelloConfigurationProjectDependency
		name: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '2.0'.

	dep1 := PBMetacelloConfigurationProjectDependency
		name: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '1.0'.

	projectOne := testRegistry newProjectNamed: 'ProjectOne'.
	projectOne addDependency: dep1.		
	projectOne addDependency: dep2.

	[ projectOne load ] on: PBProjectHasConflictsError 
		do: [ :ex | 
			self assert: ex conflicts size equals: 1.
			self assertCollection: (ex conflicts anyOne dependencies collect: #dependency) hasSameElements: { dep1. dep2 }
		]

]

{ #category : #tests }
CGOConflictResolutionTest >> testConflictingMetacelloDependenciesThrowsException [

	| testRegistry projectOne |
	testRegistry := CGOPackageRegistry new.	
	projectOne := testRegistry newProjectNamed: 'ProjectOne'.
	projectOne addDependency: (PBMetacelloConfigurationProjectDependency
		name: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '1.0').		
	projectOne addDependency: (PBMetacelloConfigurationProjectDependency
		name: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '2.0').

	self should: [ projectOne load ] raise: PBProjectHasConflictsError 
]
