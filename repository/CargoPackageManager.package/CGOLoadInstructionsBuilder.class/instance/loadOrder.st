loading order
loadOrder
	| sortedElements |
	
	resolution hasConflicts ifTrue: [ self signalConflicts ].
	
	sortedElements := MalTopologicalSorting new
		privateNodes: self reducedGraph; 
		run.
	^ sortedElements 
		collect: [ :each | each model asOrderedCollection ]
		as: Array