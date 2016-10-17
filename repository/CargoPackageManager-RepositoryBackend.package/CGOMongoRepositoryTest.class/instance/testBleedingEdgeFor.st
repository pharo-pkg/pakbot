tests - versions fetching
testBleedingEdgeFor
	| result |

	self flag: 'This test is failing randomly: sometimes success, sometimes error. Skip it till it has a reproducible status'.
	^ self skip.
		
	"result := repository 
				bleedingEdgeOf: #'Zinc-HTTP'
				for: #().
	self 
		assert: result first asString
		equals: 'Zinc-HTTP@2.5.2'"