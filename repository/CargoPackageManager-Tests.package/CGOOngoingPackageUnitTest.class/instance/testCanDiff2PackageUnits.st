tests
testCanDiff2PackageUnits
	| window |
	
	window := self unitTestV1 diffWith: self unitTestV2.

	self 
		assert: window class
		equals: SystemWindow.
		
	window close.