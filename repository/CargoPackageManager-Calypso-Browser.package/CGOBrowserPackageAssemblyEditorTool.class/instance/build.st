initialization
build
	| managedAssembly |
	managedAssembly := context lastSelectedProjectChild.
	self 
		addMorph: (CGOPackageAssemblyView buildOnOngoing: managedAssembly cargoAssembly asOngoingPackageVersion)
		fullFrame: LayoutFrame identity