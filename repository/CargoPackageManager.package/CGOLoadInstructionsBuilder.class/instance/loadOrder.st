loading order
loadOrder
	| sortedElements |

	resolution ifNil: [ ^ self ].

	sortedElements := MalTopologicalSorting new
		privateNodes: self reducedGraph; 
		run.
	^ sortedElements 
		collect: [ :each | each model asOrderedCollection ]
		as: Array