fetching
fetchFromRepositories
	packageRepositories ifEmpty: [ packageRepositories := Array with: Cargo defaultPackageRepository ].
	packageRepositories do: 
		[ :repository |
		[ ^ repository fetch: packageName version: version ]
			on: CGOPackageNotFoundError, CGOPackageVersionNotFoundError
			do: [ "ignore, let's iterate on the next repository" ] ].
	CGOPackageVersionNotFoundError signal: 'Cannot find ' , self asString