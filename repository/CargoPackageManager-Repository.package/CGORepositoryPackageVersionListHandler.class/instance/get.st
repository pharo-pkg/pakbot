public
get
	| packageName versions |
	
	packageName := variables first asSymbol.
	[ versions := self packageRepository versionsOf: packageName ]
		on: CGOPackageVersionNotFoundError
		do: [ ^ self notFound ].
	^ self stonResponse: versions