running
publishPackages: aListOfPackageNames
	(self manifestsFor: aListOfPackageNames)
		do: [ :each | self publishPackageVersion: each asOngoingPackageVersion ]