tests - versions fetching
testVersionsOf
	| result |
	
	self flag: 'This test is failing randomly: sometimes success, sometimes error. Skip it till it has a reproducible status'; skip.
		
	result := repository versionStringsOf: 'Zinc-HTTP'.
	self 
		assert: result size
		equals: 2.
	result := result collect: [ :each | each asString ].
	self assert: (result includesAll: #('Zinc-HTTP@2.5.2' 'Zinc-HTTP@2.4.8'))