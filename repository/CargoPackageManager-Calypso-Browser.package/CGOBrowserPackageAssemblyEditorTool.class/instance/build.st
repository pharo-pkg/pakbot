initialization
build
	| managedAssembly |
	managedAssembly := context lastSelectedPackageGroup.
	self 
		addMorph: (CGOPackageAssemblyView buildOnOngoing: managedAssembly cargoAssembly asOngoingPackageVersion)
		fullFrame: LayoutFrame identity