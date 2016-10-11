instance creation
newInDirectory: aPathOrFileReference
	
	^ self basicNew
		directory: aPathOrFileReference asFileReference;
		initialize;
		yourself