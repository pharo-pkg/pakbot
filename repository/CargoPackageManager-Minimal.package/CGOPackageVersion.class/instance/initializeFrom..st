initialization
initializeFrom: aDictionary
	super initialize.
	package := self packageFrom: aDictionary.
	version := self versionFrom: aDictionary.
	description := aDictionary at: #description ifAbsent: ''.
	timestamp := DateAndTime now.
	projectName := aDictionary at: #projectName ifAbsent: nil.