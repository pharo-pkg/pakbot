accessing
mcVersion
	repository ifNil: [ MCRepositoryError signal: 'no source repository defined for ', self printString ].
	^ repository mcVersionFor: packageName , '-' , versionString