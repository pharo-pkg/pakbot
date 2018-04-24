initialization
initializeFrom: aDictionary
	super initialize.
	package := self packageFrom: aDictionary.
	description := aDictionary at: #description ifAbsent: ''.
	timestamp := DateAndTime now.
	project := aDictionary at: #project ifAbsent: [ CGOPackageVersionInitializationError signal: 'No  project found for this package version'].