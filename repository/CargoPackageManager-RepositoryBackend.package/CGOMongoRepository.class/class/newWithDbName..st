instance creation
newWithDbName: aString
	^ self basicNew
		initializeWithDbName: aString;
		yourself