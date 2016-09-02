initialization
initialize
	super initialize.
	znClient := ZnClient new
		accept: ZnMimeType applicationSton;
		enforceHttpSuccess: true;
		contentReader: [ :entity | entity ifNotNil: [ STON fromString: entity contents ] ];
		contentWriter: [ :object | ZnEntity with: (CGOPackageVersionWriter toStringPretty: object) type: ZnMimeType applicationSton ];
		yourself