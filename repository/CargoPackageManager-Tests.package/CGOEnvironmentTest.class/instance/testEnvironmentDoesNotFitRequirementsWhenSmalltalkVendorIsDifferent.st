tests
testEnvironmentDoesNotFitRequirementsWhenSmalltalkVendorIsDifferent
	self deny: 
		(self gemStone3Environment fitsRequirementsOf: self pharo60Environment).