updating
packageUnits: aListOfPackageUnits
	units := aListOfPackageUnits asSet.
	units do: [ :each | each project: self ]