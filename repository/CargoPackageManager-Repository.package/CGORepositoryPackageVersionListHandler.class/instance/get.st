public
get
	| packageName versions |
	
	packageName := variables first asSymbol.
	[ versions := self packageRepository versionStringsOf: packageName ]
		on: CGOPackageVersionNotFoundError
		do: [ ^ self notFound ].
	^ self stonResponse: versions