Class {
	#name : #PBProjectVersionTest,
	#superclass : #PBModelTest,
	#instVars : [
		'repository'
	],
	#category : #'Pakbot-Tests-Model'
}

{ #category : #accessing }
PBProjectVersionTest >> pharoCounterGitUrl [
	^ 'https://github.com/pharo-pkg/pharo-counter.git'
]

{ #category : #running }
PBProjectVersionTest >> tearDown [ 
	repository ifNotNil: [:repo | repo iceRepository delete].
	self removePackageIfExists: 'Counter-Core'.
	self removePackageIfExists: 'Counter-Tests'.
	super tearDown.
]

{ #category : #tests }
PBProjectVersionTest >> testAddingDependencyPerformAnnouncement [
	| announced subscription |

	[ 
		announced := false.
		subscription := Pakbot announcer
			when: PBDependenciesChanged
			do: [ :ann | 
				ann project = ongoingProject
					ifTrue: [ announced := true ] ].
		ongoingProject
			addDependency: (PBPakbotProjectDependency named: 'AnotherProject' version: '=1.0.0').
		self assert: announced 
	] ensure: [ Pakbot announcer removeSubscription: subscription ]
]

{ #category : #tests }
PBProjectVersionTest >> testCanGetMetacelloProjects [
	| metacelloProjects |
	ongoingProject 
		addExternalProjectRequirement: 
			(PBMetacelloConfigurationProjectDependency
				name: 'Ston'
				repositoryUrl: 'http://ss3.gemstone.com/ss/STON'
				version: #stable).
				
	metacelloProjects := ongoingProject metacelloProjects.
	self 
		assert: metacelloProjects size 
		equals: 1.

	self 
		assert: metacelloProjects anyOne name
		equals: 'Ston'.
	
	self
		assert: metacelloProjects anyOne version
		equals: #stable.
		
	self 	
		assert: metacelloProjects anyOne repository
		equals: 'http://ss3.gemstone.com/ss/STON'.
]

{ #category : #tests }
PBProjectVersionTest >> testCanGetPackageUnits [
	| units |
	units := ongoingProject packageUnits.
	
	self assert: (units allSatisfy: #isUnit).
]

{ #category : #tests }
PBProjectVersionTest >> testCanLoadProjectWithoutUnresolvedDependenciesWarning [

	| project |
	repository := PBGitRepositoryCreator repositoryFromUrl: self pharoCounterGitUrl.
	project := repository project.
	project packages: { project packageNamed: 'Counter-Tests' . project packageNamed: 'Counter-Core' }. "ensure tests are loaded before core for the purpose of the test"
	project 
		registry: registry;
		repository: repository.

	self
		shouldnt: [ project load ]
		raise: Warning.
]

{ #category : #tests }
PBProjectVersionTest >> testIcebergRepositoryHavingPakbotProjectReferencingADifferentPakbotProjectRaisesError [
	
	| project newRepository |
	project := PBProjectVersion example.
	newRepository := PBGitRepository example.
	newRepository iceRepository. "force iceRepository creation to trigger the check"
	
	self 
		should: [ project repository: newRepository ]
		raise: PBIcebergProjectMismatch.
	 
]

{ #category : #tests }
PBProjectVersionTest >> testRemovingDependencyPerformAnnouncement [
	| announced subscription dep |

	dep := (PBPakbotProjectDependency named: 'AnotherProject' version: '=1.0.0').
	ongoingProject addDependency: dep.

	[ 
		announced := false.
		subscription := Pakbot announcer
			when: PBDependenciesChanged
			do: [ :ann | ann project = ongoingProject ifTrue: [ announced := true ] ].

		ongoingProject removeDependency: dep.		

		self assert: announced 
	] ensure: [ Pakbot announcer removeSubscription: subscription ]
]
