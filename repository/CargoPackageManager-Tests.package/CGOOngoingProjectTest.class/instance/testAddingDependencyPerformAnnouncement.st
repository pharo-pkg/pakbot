running
testAddingDependencyPerformAnnouncement
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