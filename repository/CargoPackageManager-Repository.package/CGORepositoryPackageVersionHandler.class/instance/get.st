public
get
	| packageName version packageVersion |
	
	packageName := variables first asSymbol.
	version := variables second asSemanticVersion.
	[ packageVersion := self packageRepository fetch: packageName version: version ]
		on: CGOPackageVersionNotFoundError
		do: [ ^ self notFound ].
	^ self stonResponse: packageVersion  