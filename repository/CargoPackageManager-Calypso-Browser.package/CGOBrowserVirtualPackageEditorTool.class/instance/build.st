initialization
build
	| virtual |
	virtual := context lastSelectedProjectChild cargoPackage.
	
	self 
		addMorph: (CGOVirtualPackageView buildOnOngoing: virtual asOngoingPackageVersion)
		fullFrame: LayoutFrame identity.