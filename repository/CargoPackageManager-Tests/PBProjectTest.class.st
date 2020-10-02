Class {
	#name : #PBProjectTest,
	#superclass : #PBModelTest,
	#category : #'CargoPackageManager-Tests-Model'
}

{ #category : #tests }
PBProjectTest >> testAddingDependencyPerformAnnouncement [
	| announced subscription |

	[ 
		announced := false.
		subscription := SystemAnnouncer uniqueInstance
			when: CGODependenciesChanged
			do: [ :ann | 
				ann project = ongoingProject
					ifTrue: [ announced := true ] ].
		ongoingProject
			addDependency: (PBPakbotProjectDependency named: 'AnotherProject' version: '=1.0.0').
		self assert: announced 
	] ensure: [ SystemAnnouncer uniqueInstance removeSubscription: subscription ]
]

{ #category : #tests }
PBProjectTest >> testCanGetMetacelloProjects [
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
PBProjectTest >> testCanGetPackageUnits [
	| units |
	units := ongoingProject packageUnits.
	
	self assert: (units allSatisfy: #isUnit).
]

{ #category : #tests }
PBProjectTest >> testRemovingDependencyPerformAnnouncement [
	| announced subscription dep |

	dep := (PBPakbotProjectDependency named: 'AnotherProject' version: '=1.0.0').
	ongoingProject addDependency: dep.

	[ 
		announced := false.
		subscription := SystemAnnouncer uniqueInstance
			when: CGODependenciesChanged
			do: [ :ann | ann project = ongoingProject ifTrue: [ announced := true ] ].

		ongoingProject removeDependency: dep.		

		self assert: announced 
	] ensure: [ SystemAnnouncer uniqueInstance removeSubscription: subscription ]
]
