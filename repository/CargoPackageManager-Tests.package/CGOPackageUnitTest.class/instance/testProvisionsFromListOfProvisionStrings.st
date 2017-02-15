tests
testProvisionsFromListOfProvisionStrings
	| provisions |
	provisions := (CGOPackageUnit provisionsFromListOfProvisionStrings: #('A@2.0' 'B')) asArray.
	self 
		assert: provisions first
		equals: 'A@2.0.0' asPackageVersionReference.
	self 
		assert: provisions second
		equals: 'B@1.0.0' asPackageVersionReference.