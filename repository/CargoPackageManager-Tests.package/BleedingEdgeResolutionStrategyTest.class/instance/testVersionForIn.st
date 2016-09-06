tests
testVersionForIn
	| strategy packageVersionRef |
	
	strategy := CGOBleedingEdgeResolutionStrategy new.

	packageVersionRef := strategy 
					versionOf: #'Seaside-Flow'
					in: repository asOrderedCollection
					for: #( #pharo ).
	self
		assert: packageVersionRef asString
		equals: 'Seaside-Flow@3.1.0'.

