testing
isDevelopmentVersion
	^ suffix 
		ifNil: [ false ]
		ifNotNil: [ suffix endsWith: '-dev' ]