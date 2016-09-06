public
get
	| packageName package |
	packageName := variables first asSymbol.
	[ package := self packageRepository package: packageName ]
		on: CGOPackageNotFoundError
		do: [ ^ self notFound ].
	^ self stonResponse: package