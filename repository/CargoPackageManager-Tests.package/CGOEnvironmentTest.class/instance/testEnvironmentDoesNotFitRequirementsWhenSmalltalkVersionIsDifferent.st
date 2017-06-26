tests
testEnvironmentDoesNotFitRequirementsWhenSmalltalkVersionIsDifferent
	self deny: 
		(self pharo50Environment fitsRequirementsOf: self pharo60Environment).