initialization
build
	| managedProject |
	managedProject := context lastSelectedProject.
	self 
		addMorph: (CGOProjectPanel buildOnOngoing: managedProject project asOngoingPackage)
		fullFrame: LayoutFrame identity