initialization
build
	| packageManager unit |
	packageManager := context systemEnvironment projectManager packageManagers first.
	unit := packageManager versionOf: context lastSelectedPackage.
	
	self 
		addMorph: (CGOPackageUnitView buildOnOngoing: unit asOngoingPackageVersion)
		fullFrame: LayoutFrame identity