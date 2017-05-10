accessing
shouldBeActivatedInContext: aBrowserContext
	^ aBrowserContext selectedObjects 
		anySatisfy: [ :each | each project isUnit ]