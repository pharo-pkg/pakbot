initialization
initializeFrom: aDictionary
	super initializeFrom: aDictionary.
	dependencies := self dependenciesFrom: aDictionary.
	provisions := self provisionsFrom: aDictionary.
	src := aDictionary at: #src ifAbsent: nil.
	platformRequirements := aDictionary at: #platformRequirements ifAbsent: #().
	