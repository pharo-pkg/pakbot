accessing
mcVersion
	repositoryUrl ifNil: [ MCRepositoryError signal: 'no source repository defined for ', self printString ].
	^ (MCRepository fromUrl: repositoryUrl)
		versionFrom: packageName , '-' , versionString