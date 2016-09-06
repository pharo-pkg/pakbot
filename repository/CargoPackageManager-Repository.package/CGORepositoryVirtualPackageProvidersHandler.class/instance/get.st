public
get
	| virtualPackageName packages platformAttributes |
	
	virtualPackageName := variables first asSymbol.
	platformAttributes := self platformValues.
	[ packages := self packageRepository 
							packagesProviding: virtualPackageName
							for: platformAttributes ]
		on: CGOPackageNotFoundError
		do: [ ^ self notFound ].
	^ self stonResponse: packages