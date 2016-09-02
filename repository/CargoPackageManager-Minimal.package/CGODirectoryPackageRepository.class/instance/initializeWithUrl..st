initialization
initializeWithUrl: aUrlString
	super initializeWithUrl: (ZnUrl fromString: aUrlString defaultScheme: #file).
	self initialize