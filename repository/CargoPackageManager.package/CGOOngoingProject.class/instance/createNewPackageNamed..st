adding
createNewPackageNamed: aString 
	
	"We delegate to the system the creation of a package first.
	This will fail if a package with that name already exists.
	If that succeeds, we register that new package in this project."
	[ self systemPackageOrganizer createPackageNamed: aString ]
		on: RPackageConflictError
		do: [ :error | CGOSystemPackageAlreadyDefined signal: aString ].

	self newPackageUnit: aString.