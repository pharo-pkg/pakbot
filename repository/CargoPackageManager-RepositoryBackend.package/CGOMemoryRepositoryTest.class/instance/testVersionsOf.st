tests - versions fetching
testVersionsOf
	| result |
	
	result := repository versionsOf: 'Zinc-HTTP'.
	self 
		assert: result size
		equals: 2.
	result := result collect: [ :each | each asString ].
	self 
		assert: result asArray
		equals: #('Zinc-HTTP@2.4.8' 'Zinc-HTTP@2.5.2')