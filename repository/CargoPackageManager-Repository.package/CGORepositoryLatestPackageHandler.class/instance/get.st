public
get
	| packageName packageVersion |
	
	packageName := variables first asSymbol.
	[ packageVersion := self packageRepository 
		bleedingEdgeOf: packageName
		for: self platformValues ]
		on: CGOPackageNotFoundError
		do: [ ^ self notFound ].
	^ self stonResponse: packageVersion  