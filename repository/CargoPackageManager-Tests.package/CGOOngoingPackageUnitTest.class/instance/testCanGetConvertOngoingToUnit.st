tests
testCanGetConvertOngoingToUnit
	| unit |
	unit := CGOOngoingPackageUnit example asPackageVersionOf: CGOProject example.
	
	self assert: unit project notNil.
		
	self
		assert: unit version asString
		equals: '2.1.0'.
	
	self 
		assert: unit packageName
		equals: #UnitTest