initialization
build
	| virtual |
	virtual := context lastSelectedPackageGroup cargoPackage.
	
	self 
		addMorph: (CGOVirtualPackageView buildOnOngoing: virtual asOngoingPackageVersion)
		fullFrame: LayoutFrame identity.