publishing
publishNewPackageVersion
	[ [ self newPackageVersion ]
	on: CGOMissingSourcePackageRepository
		do: [ :error |
				self setSourceRepositories.
				error resume ] ]
	on: CGODirtyPackageWarning
		do: [ :error |
				self savePackage.
				error resume ].
	Cargo defaultPackageRepository
		savePackageVersion: self newPackageVersion