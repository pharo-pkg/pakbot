tests-fetching
testFetchMissingDescription
	self
		assert:	(CGOPackageVersionCache new fetchDescription: 'Seaside-Core@3.1.0')
		equals: nil.
