public
post
	| packageVersion |
	
	packageVersion := self stonRequest.
	(packageVersion isKindOf: CGOPackageVersion)
		ifTrue: [ [ self packageRepository savePackageVersion: packageVersion.
						self created: (self uriFor: packageVersion) ]
						on: CGOPackageVersionAlreadyExistsError
						do: [ :error | self badRequest: error messageText ] ]
		ifFalse: [ self badRequest: 'STON PackageVersion expected' ]