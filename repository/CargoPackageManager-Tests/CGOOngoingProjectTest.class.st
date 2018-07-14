Class {
	#name : #CGOOngoingProjectTest,
	#superclass : #CGOProjectTest,
	#instVars : [
		'defaultPackageRepository',
		'testPackageRepository',
		'fs'
	],
	#category : 'CargoPackageManager-Tests'
}

{ #category : #running }
CGOOngoingProjectTest >> testAddingDependencyPerformAnnouncement [
	| announced subscription |

	[ 
		announced := false.
		subscription := SystemAnnouncer uniqueInstance
			when: CGODependenciesChanged
			do: [ :ann | 
				ann project = ongoingProject
					ifTrue: [ announced := true ] ].
		ongoingProject
			addDependency: (CGOCargoProjectDependency named: 'AnotherProject' version: '=1.0.0').
		self assert: announced 
	] ensure: [ SystemAnnouncer uniqueInstance removeSubscription: subscription ]
]

{ #category : #tests }
CGOOngoingProjectTest >> testCanGetMetacelloProjects [
	| metacelloProjects |
	ongoingProject 
		addExternalCargoProject: 
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
		equals: 'http://ss3.gemstone.com/ss/STON' asZnUrl.
]

{ #category : #running }
CGOOngoingProjectTest >> testRemovingDependencyPerformAnnouncement [
	| announced subscription dep |

	dep := (CGOCargoProjectDependency named: 'AnotherProject' version: '=1.0.0').
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
