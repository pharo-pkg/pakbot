tests
testReducedGraph
	| nodes |

	nodes := loadInstructionsBuilder reducedGraph.
	self 
		assert: (nodes 
			collect: [ :node | 
				node model isCollection
					ifTrue: [ node model collect: #asString as: Array ]
					ifFalse: [ node asString ] ]
			as: Array)
		equals: #('Foo@1.0.0' 'A@1.0.0' 'C@1.0.0' 'E@1.0.0' #('B@3.1.0' 'D@1.1.0'))