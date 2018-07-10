running
testRemovingDependencyPerformAnnouncement
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