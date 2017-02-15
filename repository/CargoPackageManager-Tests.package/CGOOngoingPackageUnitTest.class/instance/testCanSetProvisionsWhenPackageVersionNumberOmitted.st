tests
testCanSetProvisionsWhenPackageVersionNumberOmitted
	| unit |
	unit := self unitTestV1.
			
	unit provisions: #('A@2.0' 'B').
	
	self 
		assert: unit provisions first
		equals: 'A@2.0.0' asPackageVersionReference.
	self 
		assert: unit provisions second
		equals: 'B@1.0.0' asPackageVersionReference.