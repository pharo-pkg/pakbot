public
get
	| packageName packageVersion |
	
	packageName := variables first asSymbol.
	[ packageVersion := self packageRepository
		latestVersionOfPackage: packageName 
		suitableForEnvironment: self platformValues ]
		on: CGOPackageNotFoundError
		do: [ ^ self notFound ].
	^ self stonResponse: packageVersion  