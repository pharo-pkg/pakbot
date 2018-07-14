testing
isLoaded
	
	^ registry notNil
		and: [ registry isProjectInstalled: self ]