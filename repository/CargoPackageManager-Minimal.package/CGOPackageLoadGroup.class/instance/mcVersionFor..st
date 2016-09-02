loading
mcVersionFor: aPackageVersionReference
	self repositories , aPackageVersionReference repositories
		do: [ :repository | 
			[ ^ repository versionFrom: aPackageVersionReference file ]
				on: MCRepositoryError
				do: [ "ignore and continue with the next repository" ] ].
	MCRepositoryError signal: 'Cannot load ' , aPackageVersionReference file