tests - versions fetching
testFetchVersionNotFound
	self 
		should: [ repository 
				fetch: #Foo
				version: '2.0.1' asSemanticVersion ]
		raise: CGOPackageNotFoundError