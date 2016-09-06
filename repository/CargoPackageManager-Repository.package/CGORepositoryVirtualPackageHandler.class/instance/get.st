public
get
	| virtualPackageName version packageVersions platformAttributes |
	
	virtualPackageName := variables first asSymbol.
	version := variables second asSemanticVersion.
	platformAttributes := self platformValues.
	[ packageVersions := self packageRepository 
							packagesProviding: virtualPackageName
							version: version
							for: platformAttributes ]
		on: CGOPackageVersionNotFoundError
		do: [ ^ self notFound ].
	^ self stonResponse: packageVersions