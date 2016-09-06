accessing
sortedTopGroupsWithAtLeast: numberOfDependencies
	^ (self topGroups 
		reject: [ :each | each value < numberOfDependencies ]) 
			sorted: [ :a :b | a value > b value ]