signaling
signal

	versionNumber ifNotNil: [ 
		self messageText: 'Cannot find package: ' , packageName asString, ' version: ', versionNumber asString ].
	(versionNumber isNil and: [ packageName notNil ]) ifTrue: [
		self messageText: 'Cannot find package: ', packageName ].
	
	super signal.