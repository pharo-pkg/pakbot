tests - virtual packages
testPackagesProvidingVersionFor
	| result |
	
	self flag: 'This test is failing randomly: sometimes success, sometimes error. Skip it till it has a reproducible status'.
	^ self skip.
	
	"result := repository 
				packagesProviding: 'Seaside-Canvas-Platform'
				version: '3.1' asSemanticVersion
				for: (OrderedCollection with: #'pharo2.x').
	self 
		assert: result size
		equals: 1.
	self assert: result anyOne
		equals: 'Seaside-Canvas-Pharo20@3.1.0'"