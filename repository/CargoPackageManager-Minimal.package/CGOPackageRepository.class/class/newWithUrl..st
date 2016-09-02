instance creation
newWithUrl: anURL
	^ self basicNew	
		initializeWithUrl: anURL;
		yourself.
	