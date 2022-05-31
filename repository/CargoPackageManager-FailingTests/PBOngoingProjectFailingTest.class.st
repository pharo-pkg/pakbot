Class {
	#name : #PBOngoingProjectFailingTest,
	#superclass : #PBProjectVersionTest,
	#instVars : [
		'protocol'
	],
	#category : #'CargoPackageManager-FailingTests-Model'
}

{ #category : #running }
PBOngoingProjectFailingTest >> testAddingDependencyPerformAnnouncement [
	| announced subscription |

	[ 	announced := false.
		subscription := SystemAnnouncer uniqueInstance
			when: PBDependenciesChanged
			do: [ :ann | 
				ann project = ongoingProject
					ifTrue: [ announced := true ] ].
		ongoingProject
			addDependency: (PBPakbotProjectDependency named: 'AnotherProject' version: '=1.0.0').
		self assert: announced 
	] ensure: [ SystemAnnouncer uniqueInstance removeSubscription: subscription ]
]
